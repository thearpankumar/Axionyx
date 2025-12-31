/**
 * PCRDevice.cpp
 * PCR machine implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "PCRDevice.h"
#include "../../../common/utils/Logger.h"

PCRDevice::PCRDevice()
    : lastUpdate(0) {

    // Initialize temperature zones with different ambient temperatures
    // Zone 0: Denature zone (hot)
    tempZones[0] = TemperatureSimulator(25.0);
    tempZones[0].setHeatingRate(5.0);   // Fast heating for denaturation
    tempZones[0].setCoolingRate(2.0);   // Moderate cooling
    tempZones[0].setAmbientTemp(25.0);
    tempZones[0].enablePID(true);

    // Zone 1: Anneal zone (medium)
    tempZones[1] = TemperatureSimulator(25.0);
    tempZones[1].setHeatingRate(3.0);   // Moderate heating
    tempZones[1].setCoolingRate(2.0);
    tempZones[1].setAmbientTemp(25.0);
    tempZones[1].enablePID(true);

    // Zone 2: Extend zone (warm)
    tempZones[2] = TemperatureSimulator(25.0);
    tempZones[2].setHeatingRate(4.0);   // Good heating
    tempZones[2].setCoolingRate(1.5);
    tempZones[2].setAmbientTemp(25.0);
    tempZones[2].enablePID(true);
}

void PCRDevice::begin() {
    Logger::info("PCRDevice: Initializing");
    setState(IDLE);
    lastUpdate = millis();

    // Set default program
    currentProgram = PCRCycler::Program();

    Logger::info("PCRDevice: Initialized with " + String(NUM_ZONES) + " temperature zones");
}

void PCRDevice::loop() {
    unsigned long now = millis();
    float dt = (now - lastUpdate) / 1000.0; // Convert to seconds

    if (dt >= (UPDATE_INTERVAL / 1000.0)) {
        // Update PCR cycler state machine
        if (state == RUNNING) {
            cycler.update(now);

            // Sync temperature setpoints to current PCR phase
            syncTemperaturesToCycler();

            // Check if PCR program completed
            if (cycler.isComplete()) {
                Logger::info("PCRDevice: PCR program completed");
                setState(IDLE);
            }
        }

        // Update temperature simulations
        updateTemperatures(dt);

        lastUpdate = now;
    }
}

JsonDocument PCRDevice::getStatus() {
    JsonDocument doc;

    // Device state
    doc["state"] = getStateString();
    doc["uptime"] = getUptime();

    // Temperature zones
    JsonArray temps = doc["temperature"].to<JsonArray>();
    JsonArray setpoints = doc["setpoint"].to<JsonArray>();

    for (uint8_t i = 0; i < NUM_ZONES; i++) {
        temps.add(tempZones[i].read());
        setpoints.add(tempZones[i].getSetpoint());
    }

    // PCR cycling information
    if (state == RUNNING || state == PAUSED) {
        doc["currentPhase"] = cycler.getPhaseString();
        doc["cycleNumber"] = cycler.getCurrentCycle();
        doc["totalCycles"] = cycler.getTotalCycles();
        doc["phaseTimeRemaining"] = cycler.getPhaseTimeRemaining();
        doc["totalTimeRemaining"] = cycler.getTotalTimeRemaining();
        doc["progress"] = cycler.getProgress();
    } else {
        doc["currentPhase"] = "IDLE";
        doc["cycleNumber"] = 0;
        doc["totalCycles"] = 0;
        doc["phaseTimeRemaining"] = 0;
        doc["totalTimeRemaining"] = 0;
        doc["progress"] = 0.0;
    }

    // Program parameters
    JsonObject program = doc["program"].to<JsonObject>();
    program["cycles"] = currentProgram.cycles;
    program["denatureTemp"] = currentProgram.denatureTemp;
    program["annealTemp"] = currentProgram.annealTemp;
    program["extendTemp"] = currentProgram.extendTemp;

    // Errors
    JsonArray errors = doc["errors"].to<JsonArray>();
    // No errors in simulated device

    return doc;
}

bool PCRDevice::start(JsonDocument& params) {
    Logger::info("PCRDevice: Starting PCR program");

    // Parse program parameters if provided
    if (!params["program"].isNull()) {
        JsonObject programObj = params["program"];

        if (!programObj["cycles"].isNull()) {
            currentProgram.cycles = programObj["cycles"];
        }
        if (!programObj["denatureTemp"].isNull()) {
            currentProgram.denatureTemp = programObj["denatureTemp"];
        }
        if (!programObj["annealTemp"].isNull()) {
            currentProgram.annealTemp = programObj["annealTemp"];
        }
        if (!programObj["extendTemp"].isNull()) {
            currentProgram.extendTemp = programObj["extendTemp"];
        }
        if (!programObj["denatureTime"].isNull()) {
            currentProgram.denatureTime = programObj["denatureTime"];
        }
        if (!programObj["annealTime"].isNull()) {
            currentProgram.annealTime = programObj["annealTime"];
        }
        if (!programObj["extendTime"].isNull()) {
            currentProgram.extendTime = programObj["extendTime"];
        }
    }

    // Start the PCR cycler with current program
    cycler.start(currentProgram);
    setState(RUNNING);

    return true;
}

bool PCRDevice::stop() {
    Logger::info("PCRDevice: Stopping PCR program");

    cycler.stop();
    setState(IDLE);

    // Return all zones to ambient temperature
    for (uint8_t i = 0; i < NUM_ZONES; i++) {
        tempZones[i].setSetpoint(25.0);
    }

    return true;
}

bool PCRDevice::pause() {
    if (state == RUNNING) {
        Logger::info("PCRDevice: Pausing PCR program");
        cycler.pause();
        setState(PAUSED);
        return true;
    }
    return false;
}

bool PCRDevice::resume() {
    if (state == PAUSED) {
        Logger::info("PCRDevice: Resuming PCR program");
        cycler.resume();
        setState(RUNNING);
        return true;
    }
    return false;
}

bool PCRDevice::setSetpoint(uint8_t zone, float value) {
    if (zone >= NUM_ZONES) {
        Logger::error("PCRDevice: Invalid zone " + String(zone));
        return false;
    }

    Logger::info("PCRDevice: Setting zone " + String(zone) + " (" +
                getZoneName(zone) + ") to " + String(value) + "°C");

    tempZones[zone].setSetpoint(value);
    return true;
}

bool PCRDevice::loadProgram(const PCRCycler::Program& program) {
    Logger::info("PCRDevice: Loading new PCR program");
    currentProgram = program;
    return true;
}

void PCRDevice::updateTemperatures(float dt) {
    for (uint8_t i = 0; i < NUM_ZONES; i++) {
        if (state == RUNNING || state == PAUSED) {
            tempZones[i].update(dt);
        }
    }
}

void PCRDevice::syncTemperaturesToCycler() {
    if (!cycler.isRunning()) {
        return;
    }

    // Get target temperature from current PCR phase
    float targetTemp = cycler.getCurrentTargetTemp();

    // Set the same target for all zones in this simplified simulation
    // In a real PCR machine, each zone might have independent control
    for (uint8_t i = 0; i < NUM_ZONES; i++) {
        tempZones[i].setSetpoint(targetTemp);
    }
}

String PCRDevice::getZoneName(uint8_t zone) const {
    switch (zone) {
        case 0: return "Denature";
        case 1: return "Anneal";
        case 2: return "Extend";
        default: return "Unknown";
    }
}
