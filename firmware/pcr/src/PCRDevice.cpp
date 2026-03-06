/**
 * PCRDevice.cpp
 * PCR machine implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "PCRDevice.h"
#include "../../common/utils/Logger.h"

PCRDevice::PCRDevice()
    : lastUpdate(0) {
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
    float dt = (now - lastUpdate) / 1000.0;

    if (dt >= (UPDATE_INTERVAL / 1000.0)) {
        // Update PCR cycler state machine
        if (state == RUNNING) {
            cycler.update(now);

            // Check if PCR program completed
            if (cycler.isComplete()) {
                Logger::info("PCRDevice: PCR program completed");
                setState(IDLE);
            }
        }

        lastUpdate = now;
    }
}

JsonDocument PCRDevice::getStatus() {
    JsonDocument doc;

    // Device state
    doc["state"] = getStateString();
    doc["uptime"] = getUptime();

    // TODO: Read actual temperatures from hardware sensors (3 zones)
    JsonArray temps = doc["temperature"].to<JsonArray>();
    JsonArray setpoints = doc["setpoint"].to<JsonArray>();
    for (uint8_t i = 0; i < NUM_ZONES; i++) {
        temps.add(0.0);
        setpoints.add(0.0);
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

    String programType;
    switch (currentProgram.type) {
        case PCRCycler::STANDARD_PCR:  programType = "standard";  break;
        case PCRCycler::GRADIENT_PCR:  programType = "gradient";  break;
        case PCRCycler::TOUCHDOWN_PCR: programType = "touchdown"; break;
        case PCRCycler::TWOSTEP_PCR:   programType = "twostep";   break;
        default:                       programType = "standard";  break;
    }
    program["type"] = programType;
    program["cycles"] = currentProgram.cycles;
    program["denatureTemp"] = currentProgram.denatureTemp;
    program["denatureTime"] = currentProgram.denatureTime;
    program["annealTemp"] = currentProgram.annealTemp;
    program["annealTime"] = currentProgram.annealTime;
    program["extendTemp"] = currentProgram.extendTemp;
    program["extendTime"] = currentProgram.extendTime;

    if (currentProgram.hotStart.enabled) {
        JsonObject hotStart = program["hotStart"].to<JsonObject>();
        hotStart["enabled"] = true;
        hotStart["activationTemp"] = currentProgram.hotStart.activationTemp;
        hotStart["activationTime"] = currentProgram.hotStart.activationTime;
    }

    if (currentProgram.twoStepEnabled) {
        program["twoStepEnabled"] = true;
        program["annealExtendTemp"] = currentProgram.annealExtendTemp;
        program["annealExtendTime"] = currentProgram.annealExtendTime;
    }

    if (currentProgram.touchdown.enabled) {
        JsonObject touchdown = program["touchdown"].to<JsonObject>();
        touchdown["enabled"] = true;
        touchdown["startAnnealTemp"] = currentProgram.touchdown.startAnnealTemp;
        touchdown["endAnnealTemp"] = currentProgram.touchdown.endAnnealTemp;
        touchdown["stepSize"] = currentProgram.touchdown.stepSize;
        touchdown["touchdownCycles"] = currentProgram.touchdown.touchdownCycles;
        if (state == RUNNING || state == PAUSED) {
            touchdown["currentAnnealTemp"] = cycler.getCurrentAnnealTemp();
        }
    }

    if (currentProgram.gradient.enabled) {
        JsonObject gradient = program["gradient"].to<JsonObject>();
        gradient["enabled"] = true;
        gradient["tempLow"] = currentProgram.gradient.tempLow;
        gradient["tempHigh"] = currentProgram.gradient.tempHigh;
        gradient["positions"] = currentProgram.gradient.positions;
    }

    // Errors
    JsonArray errors = doc["errors"].to<JsonArray>();

    return doc;
}

bool PCRDevice::start(JsonDocument& params) {
    Logger::info("PCRDevice: Starting PCR program");

    if (!params["programType"].isNull()) {
        String type = params["programType"].as<String>();
        if (type == "gradient")       currentProgram.type = PCRCycler::GRADIENT_PCR;
        else if (type == "touchdown") currentProgram.type = PCRCycler::TOUCHDOWN_PCR;
        else if (type == "twostep")   currentProgram.type = PCRCycler::TWOSTEP_PCR;
        else                          currentProgram.type = PCRCycler::STANDARD_PCR;
    }

    if (!params["hotStart"].isNull()) {
        JsonObject hs = params["hotStart"].as<JsonObject>();
        if (!hs["enabled"].isNull())        currentProgram.hotStart.enabled = hs["enabled"];
        if (!hs["activationTemp"].isNull()) currentProgram.hotStart.activationTemp = hs["activationTemp"];
        if (!hs["activationTime"].isNull()) currentProgram.hotStart.activationTime = hs["activationTime"];
    }

    if (!params["cycles"].isNull())           currentProgram.cycles = params["cycles"];
    if (!params["denatureTemp"].isNull())     currentProgram.denatureTemp = params["denatureTemp"];
    if (!params["denatureTime"].isNull())     currentProgram.denatureTime = params["denatureTime"];
    if (!params["annealTemp"].isNull())       currentProgram.annealTemp = params["annealTemp"];
    if (!params["annealTime"].isNull())       currentProgram.annealTime = params["annealTime"];
    if (!params["extendTemp"].isNull())       currentProgram.extendTemp = params["extendTemp"];
    if (!params["extendTime"].isNull())       currentProgram.extendTime = params["extendTime"];
    if (!params["twoStepEnabled"].isNull())   currentProgram.twoStepEnabled = params["twoStepEnabled"];
    if (!params["annealExtendTemp"].isNull()) currentProgram.annealExtendTemp = params["annealExtendTemp"];
    if (!params["annealExtendTime"].isNull()) currentProgram.annealExtendTime = params["annealExtendTime"];

    if (!params["gradient"].isNull()) {
        JsonObject grad = params["gradient"].as<JsonObject>();
        if (!grad["enabled"].isNull())  currentProgram.gradient.enabled = grad["enabled"];
        if (!grad["tempLow"].isNull())  currentProgram.gradient.tempLow = grad["tempLow"];
        if (!grad["tempHigh"].isNull()) currentProgram.gradient.tempHigh = grad["tempHigh"];
        if (!grad["positions"].isNull()) currentProgram.gradient.positions = grad["positions"];
    }

    if (!params["touchdown"].isNull()) {
        JsonObject td = params["touchdown"].as<JsonObject>();
        if (!td["enabled"].isNull())          currentProgram.touchdown.enabled = td["enabled"];
        if (!td["startAnnealTemp"].isNull())  currentProgram.touchdown.startAnnealTemp = td["startAnnealTemp"];
        if (!td["endAnnealTemp"].isNull())    currentProgram.touchdown.endAnnealTemp = td["endAnnealTemp"];
        if (!td["stepSize"].isNull())         currentProgram.touchdown.stepSize = td["stepSize"];
        if (!td["touchdownCycles"].isNull())  currentProgram.touchdown.touchdownCycles = td["touchdownCycles"];
    }

    if (!params["initialDenatureTemp"].isNull()) currentProgram.initialDenatureTemp = params["initialDenatureTemp"];
    if (!params["initialDenatureTime"].isNull()) currentProgram.initialDenatureTime = params["initialDenatureTime"];
    if (!params["finalExtendTemp"].isNull())     currentProgram.finalExtendTemp = params["finalExtendTemp"];
    if (!params["finalExtendTime"].isNull())     currentProgram.finalExtendTime = params["finalExtendTime"];
    if (!params["holdTemp"].isNull())            currentProgram.holdTemp = params["holdTemp"];

    cycler.start(currentProgram);
    setState(RUNNING);

    return true;
}

bool PCRDevice::stop() {
    Logger::info("PCRDevice: Stopping PCR program");
    cycler.stop();
    setState(IDLE);
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

    Logger::info("PCRDevice: Setpoint zone " + String(zone) + " = " + String(value) + "°C");
    // TODO: Apply setpoint to real hardware temperature controller
    return true;
}

bool PCRDevice::loadProgram(const PCRCycler::Program& program) {
    Logger::info("PCRDevice: Loading new PCR program");
    currentProgram = program;
    return true;
}
