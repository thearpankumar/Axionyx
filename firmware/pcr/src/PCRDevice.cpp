/**
 * PCRDevice.cpp
 * PCR machine — single-zone heater, fan, NTC3950 temperature sensor
 * ESP8266MOD hardware implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "PCRDevice.h"
#include "../../common/utils/Logger.h"
#include <math.h>

PCRDevice::PCRDevice()
    : currentTemp(0.0f),
      targetTemp(0.0f),
      heaterOn(false),
      fanOn(false),
      pidIntegral(0.0f),
      pidPrevError(0.0f),
      testFanActive(false),
      testFanEndTime(0),
      lastUpdate(0),
      lastTempRead(0),
      currentProgramName("Custom Program")
{
}

// ─── Initialisation ──────────────────────────────────────────────────────────

void PCRDevice::begin() {
    Logger::info("PCRDevice: Initializing hardware");

    // Active-LOW drivers: pre-drive pins HIGH before pinMode to ensure
    // heater and fan stay OFF at boot (HIGH = off for active-LOW circuits).
    digitalWrite(PIN_HEATER, HIGH);
    digitalWrite(PIN_FAN,    HIGH);
    pinMode(PIN_HEATER, OUTPUT);
    pinMode(PIN_FAN,    OUTPUT);

    setState(IDLE);
    lastUpdate   = millis();
    lastTempRead = millis();

    currentProgram = PCRCycler::Program();  // default 95/60/72°C, 35 cycles

    // Take an initial temperature reading
    currentTemp = readTemperature();
    Logger::info("PCRDevice: Ambient temp = " + String(currentTemp, 1) + " °C");
    Logger::info("PCRDevice: Ready — Heater=D5(GPIO14) Fan=D6(GPIO12) Sensor=A0");
}

// ─── Main Loop ───────────────────────────────────────────────────────────────

void PCRDevice::loop() {
    unsigned long now = millis();

    // Read temperature at 20 Hz
    if (now - lastTempRead >= TEMP_READ_INTERVAL_MS) {
        float t = readTemperature();
        if (t > -100.0f) {
            currentTemp = t;  // only accept valid readings
        } else if (state == RUNNING || state == PAUSED) {
            // Sensor fault while running — shut down immediately for safety
            Logger::error("PCRDevice: Sensor fault during run — shutting down");
            cycler.stop();
            allOff();
            setState(ERROR);
        }
        lastTempRead = now;
    }

    // Control loop at 10 Hz
    if (now - lastUpdate >= UPDATE_INTERVAL_MS) {
        float dt = (now - lastUpdate) / 1000.0f;
        lastUpdate = now;

        if (state == RUNNING) {
            // Advance the PCR state machine
            cycler.update(now);

            // Check for program completion
            if (cycler.isComplete()) {
                Logger::info("PCRDevice: PCR program complete");
                allOff();
                setState(IDLE);
                return;
            }

            // Get the temperature target for the current phase
            targetTemp = cycler.getCurrentTargetTemp();

            // Drive hardware with PID
            updatePID(dt);

        } else if (state == PAUSED) {
            // Hold temperature at current target, still control hardware
            updatePID(dt);

        } else {
            // IDLE / ERROR — check for active fan test, otherwise everything off
            if (testFanActive) {
                if ((long)(millis() - testFanEndTime) >= 0) {
                    Logger::info("PCRDevice: Fan test complete — turning off");
                    testFanActive = false;
                    setFan(false);
                } else {
                    setFan(true);  // keep fan on for remainder of test
                }
                setHeater(0);
            } else {
                allOff();
            }
            pidIntegral  = 0.0f;
            pidPrevError = 0.0f;
        }
    }
}

// ─── DeviceBase Interface ────────────────────────────────────────────────────

JsonDocument PCRDevice::getStatus() {
    JsonDocument doc;

    doc["state"]   = getStateString();
    doc["uptime"]  = getUptime();

    // Single-zone temperature as array (keeps mobile app JSON compatible)
    JsonArray temps     = doc["temperature"].to<JsonArray>();
    JsonArray setpoints = doc["setpoint"].to<JsonArray>();
    temps.add(currentTemp);
    setpoints.add(targetTemp);

    // Hardware state
    doc["heaterOn"] = heaterOn;
    doc["fanOn"]    = fanOn;

    // PCR cycling info
    if (state == RUNNING || state == PAUSED) {
        doc["currentPhase"]       = cycler.getPhaseString();
        doc["cycleNumber"]        = cycler.getCurrentCycle();
        doc["totalCycles"]        = cycler.getTotalCycles();
        doc["phaseTimeRemaining"] = cycler.getPhaseTimeRemaining();
        doc["totalTimeRemaining"] = cycler.getTotalTimeRemaining();
        doc["progress"]           = cycler.getProgress();
    } else {
        doc["currentPhase"]       = "IDLE";
        doc["cycleNumber"]        = 0;
        doc["totalCycles"]        = 0;
        doc["phaseTimeRemaining"] = 0;
        doc["totalTimeRemaining"] = 0;
        doc["progress"]           = 0.0f;
    }

    // Program parameters
    JsonObject prog = doc["program"].to<JsonObject>();
    prog["name"]              = currentProgramName;
    prog["type"]              = currentProgram.twoStepEnabled ? "twostep" : "standard";
    prog["cycles"]            = currentProgram.cycles;
    prog["denatureTemp"]      = currentProgram.denatureTemp;
    prog["denatureTime"]      = currentProgram.denatureTime;
    prog["annealTemp"]        = currentProgram.annealTemp;
    prog["annealTime"]        = currentProgram.annealTime;
    prog["extendTemp"]        = currentProgram.extendTemp;
    prog["extendTime"]        = currentProgram.extendTime;
    prog["annealExtendTemp"]  = currentProgram.annealExtendTemp;
    prog["annealExtendTime"]  = currentProgram.annealExtendTime;

    doc["errors"].to<JsonArray>();  // empty array

    return doc;
}

bool PCRDevice::start(JsonDocument& params) {
    Logger::info("PCRDevice: Starting PCR program");

    // Store program name sent by app (e.g. "Standard PCR", "Colony PCR")
    if (!params["name"].isNull()) {
        currentProgramName = params["name"].as<String>();
    }

    // Parse optional overrides from app
    if (!params["cycles"].isNull())        currentProgram.cycles         = params["cycles"];
    if (!params["denatureTemp"].isNull())  currentProgram.denatureTemp   = params["denatureTemp"];
    if (!params["denatureTime"].isNull())  currentProgram.denatureTime   = params["denatureTime"];
    if (!params["annealTemp"].isNull())    currentProgram.annealTemp     = params["annealTemp"];
    if (!params["annealTime"].isNull())    currentProgram.annealTime     = params["annealTime"];
    if (!params["extendTemp"].isNull())    currentProgram.extendTemp     = params["extendTemp"];
    if (!params["extendTime"].isNull())    currentProgram.extendTime     = params["extendTime"];
    if (!params["initialDenatureTemp"].isNull()) currentProgram.initialDenatureTemp = params["initialDenatureTemp"];
    if (!params["initialDenatureTime"].isNull()) currentProgram.initialDenatureTime = params["initialDenatureTime"];
    if (!params["finalExtendTemp"].isNull())     currentProgram.finalExtendTemp     = params["finalExtendTemp"];
    if (!params["finalExtendTime"].isNull())     currentProgram.finalExtendTime     = params["finalExtendTime"];
    if (!params["annealExtendTemp"].isNull())    currentProgram.annealExtendTemp    = params["annealExtendTemp"];
    if (!params["annealExtendTime"].isNull())    currentProgram.annealExtendTime    = params["annealExtendTime"];

    // Apply program type: support standard and two-step; gradient/touchdown not supported on single zone
    if (!params["type"].isNull() && params["type"].as<String>() == "twostep") {
        currentProgram.type           = PCRCycler::TWOSTEP_PCR;
        currentProgram.twoStepEnabled = true;
    } else {
        currentProgram.type           = PCRCycler::STANDARD_PCR;
        currentProgram.twoStepEnabled = false;
    }
    currentProgram.hotStart.enabled = false;

    // Cancel any active fan test
    testFanActive = false;

    // Reset PID state
    pidIntegral  = 0.0f;
    pidPrevError = 0.0f;

    cycler.start(currentProgram);
    setState(RUNNING);

    if (currentProgram.twoStepEnabled) {
        Logger::info("PCRDevice: [Two-Step] Cycles=" + String(currentProgram.cycles) +
                     " Den=" + String(currentProgram.denatureTemp) + "°C/" + String(currentProgram.denatureTime) + "s" +
                     " AnnExt=" + String(currentProgram.annealExtendTemp) + "°C/" + String(currentProgram.annealExtendTime) + "s");
    } else {
        Logger::info("PCRDevice: [Standard] Cycles=" + String(currentProgram.cycles) +
                     " Den=" + String(currentProgram.denatureTemp) + "°C/" + String(currentProgram.denatureTime) + "s" +
                     " Ann=" + String(currentProgram.annealTemp)   + "°C/" + String(currentProgram.annealTime)   + "s" +
                     " Ext=" + String(currentProgram.extendTemp)   + "°C/" + String(currentProgram.extendTime)   + "s");
    }

    return true;
}

bool PCRDevice::stop() {
    Logger::info("PCRDevice: Stopping");
    cycler.stop();
    allOff();
    targetTemp   = 0.0f;
    pidIntegral  = 0.0f;
    pidPrevError = 0.0f;
    setState(IDLE);
    return true;
}

bool PCRDevice::pause() {
    if (state == RUNNING) {
        Logger::info("PCRDevice: Pausing at cycle " + String(cycler.getCurrentCycle()) +
                     " phase " + cycler.getPhaseString());
        cycler.pause();
        // Reset PID state so accumulated integral doesn't cause overshoot on resume
        pidIntegral  = 0.0f;
        pidPrevError = 0.0f;
        setState(PAUSED);
        return true;
    }
    return false;
}

bool PCRDevice::resume() {
    if (state == PAUSED) {
        Logger::info("PCRDevice: Resuming");
        cycler.resume();
        setState(RUNNING);
        return true;
    }
    return false;
}

bool PCRDevice::setSetpoint(uint8_t zone, float value) {
    // Allows the app to manually override the target temperature (outside of a running program)
    if (zone != 0) return false;
    targetTemp = value;
    Logger::info("PCRDevice: Manual setpoint = " + String(value) + " °C");
    return true;
}

bool PCRDevice::loadProgram(const PCRCycler::Program& program) {
    currentProgram = program;
    return true;
}

// ─── Diagnostic Tests ─────────────────────────────────────────────────────────

bool PCRDevice::runTest(JsonDocument& params) {
    String component = params["component"].as<String>();

    if (component == "fan") {
        if (state == RUNNING || state == PAUSED) {
            Logger::warning("PCRDevice: Cannot test fan — PCR program is active");
            return false;
        }

        Logger::info("PCRDevice: Fan test started — will run for " +
                     String(TEST_FAN_DURATION_MS / 1000) + " seconds");
        testFanActive  = true;
        testFanEndTime = millis() + TEST_FAN_DURATION_MS;
        setFan(true);
        return true;
    }

    Logger::warning("PCRDevice: Unknown test component: " + component);
    return false;
}

// ─── Hardware Helpers ─────────────────────────────────────────────────────────

/**
 * Read NTC3950 temperature using the β (beta) equation.
 *
 * Circuit: 3.3V → 10kΩ → A0 → NTC3950(100kΩ@25°C) → GND
 * NodeMCU A0 reads 0–3.3V mapped to ADC 0–1023.
 */
float PCRDevice::readTemperature() {
    int raw = analogRead(PIN_TEMP_SENSOR);  // 0–1023

    // Guard against rail values (short / open circuit)
    if (raw <= 5 || raw >= 1018) {
        Logger::error("PCRDevice: Temperature sensor read error (raw=" + String(raw) + ")");
        return -999.0f;
    }

    // NTC resistance from voltage divider
    float ntcR = NTC_SERIES_R * (float)raw / (1023.0f - (float)raw);

    // β equation: 1/T = 1/T0 + (1/β) * ln(R/R0)
    float steinhart  = log(ntcR / NTC_NOMINAL_R) / NTC_BETA;
    steinhart       += 1.0f / (NTC_NOMINAL_T + 273.15f);

    return (1.0f / steinhart) - 273.15f;  // Kelvin → °C
}

/**
 * PID control — drives heater PWM and fan ON/OFF.
 *
 * Heating: error > 0  → heater PWM on, fan off
 * Cooling: error <= 0 → heater off, fan on until target reached
 */
void PCRDevice::updatePID(float dt) {
    if (dt <= 0.0f) return;

    float error      = targetTemp - currentTemp;
    pidIntegral     += error * dt;
    pidIntegral      = constrain(pidIntegral, -PID_INTEGRAL_MAX, PID_INTEGRAL_MAX);
    float derivative = (error - pidPrevError) / dt;
    float output     = PID_KP * error + PID_KI * pidIntegral + PID_KD * derivative;
    pidPrevError     = error;

    if (error > 0.0f) {
        // Need to heat — clamp PID output to PWM range 0–255
        int pwm = (int)constrain(output, 0.0f, 255.0f);
        setHeater(pwm);
        setFan(false);
    } else {
        // Above target — heater off, fan on to cool down
        setHeater(0);
        setFan(true);
    }
}

void PCRDevice::setHeater(int pwmValue) {
    if (pwmValue > 0) {
        // Active-LOW driver: invert PWM so higher pwmValue = more heat
        analogWrite(PIN_HEATER, 255 - pwmValue);
    } else {
        // Drive pin HIGH to keep heater OFF (active-LOW).
        // analogWrite(255) then digitalWrite(HIGH) ensures PWM stops and
        // gate stays HIGH — MOSFET off, heater off.
        analogWrite(PIN_HEATER, 255);
        digitalWrite(PIN_HEATER, HIGH);
    }
    heaterOn = (pwmValue > 0);
}

void PCRDevice::setFan(bool on) {
    digitalWrite(PIN_FAN, on ? LOW : HIGH);  // Active-LOW driver
    fanOn = on;
}

void PCRDevice::allOff() {
    setHeater(0);
    setFan(false);
    // targetTemp is intentionally NOT cleared here — a manual setpoint set via
    // the API must survive loop iterations.  It is cleared explicitly in stop().
}
