/**
 * PCRCycler.cpp
 * PCR thermal cycling implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "PCRCycler.h"
#include "../../../common/utils/Logger.h"

PCRCycler::PCRCycler()
    : currentPhase(IDLE),
      currentCycle(0),
      phaseStartTime(0),
      pauseStartTime(0),
      totalPausedTime(0),
      running(false),
      paused(false),
      totalProgramTime(0) {
}

void PCRCycler::start(const Program& program) {
    Logger::info("PCRCycler: Starting PCR program");
    Logger::info("PCRCycler: Type=" + String(program.type) +
                ", Cycles=" + String(program.cycles));
    Logger::info("PCRCycler: Denature=" + String(program.denatureTemp) + "°C" +
                ", Anneal=" + String(program.annealTemp) + "°C" +
                ", Extend=" + String(program.extendTemp) + "°C");

    if (program.hotStart.enabled) {
        Logger::info("PCRCycler: Hot start enabled - " +
                    String(program.hotStart.activationTime) + "s @ " +
                    String(program.hotStart.activationTemp) + "°C");
    }

    if (program.twoStepEnabled) {
        Logger::info("PCRCycler: Two-step PCR enabled - " +
                    String(program.annealExtendTemp) + "°C for " +
                    String(program.annealExtendTime) + "s");
    }

    if (program.touchdown.enabled) {
        Logger::info("PCRCycler: Touchdown PCR enabled - " +
                    String(program.touchdown.startAnnealTemp) + "°C → " +
                    String(program.touchdown.endAnnealTemp) + "°C");
    }

    if (program.gradient.enabled) {
        Logger::info("PCRCycler: Gradient PCR enabled - " +
                    String(program.gradient.tempLow) + "°C to " +
                    String(program.gradient.tempHigh) + "°C across " +
                    String(program.gradient.positions) + " positions");
    }

    programParams = program;

    // Start with hot start if enabled, otherwise initial denaturation
    if (program.hotStart.enabled) {
        currentPhase = HOT_START;
    } else {
        currentPhase = INITIAL_DENATURE;
    }

    currentCycle = 0;
    phaseStartTime = millis();
    pauseStartTime = 0;
    totalPausedTime = 0;
    running = true;
    paused = false;

    calculateTotalTime();
}

void PCRCycler::stop() {
    Logger::info("PCRCycler: Stopping PCR program");
    currentPhase = IDLE;
    currentCycle = 0;
    running = false;
    paused = false;
}

void PCRCycler::pause() {
    if (running && !paused) {
        Logger::info("PCRCycler: Pausing at cycle " + String(currentCycle) +
                    ", phase " + getPhaseString());
        paused = true;
        pauseStartTime = millis();
    }
}

void PCRCycler::resume() {
    if (running && paused) {
        Logger::info("PCRCycler: Resuming PCR program");
        paused = false;

        // Add the paused duration to total paused time
        unsigned long pauseDuration = millis() - pauseStartTime;
        totalPausedTime += pauseDuration;
        pauseStartTime = 0;
    }
}

void PCRCycler::update(unsigned long now) {
    if (!running || paused || currentPhase == COMPLETE) {
        return;
    }

    // Calculate elapsed time in current phase (excluding paused time)
    unsigned long elapsed = (now - phaseStartTime - totalPausedTime) / 1000; // Convert to seconds
    uint16_t phaseDuration = getCurrentPhaseDuration();

    // Check if current phase is complete
    if (elapsed >= phaseDuration) {
        transitionToNextPhase();
    }
}

void PCRCycler::transitionToNextPhase() {
    Phase nextPhase = currentPhase;

    switch (currentPhase) {
        case IDLE:
            // Should not happen
            break;

        case HOT_START:
            Logger::info("PCRCycler: Hot start activation complete");
            nextPhase = INITIAL_DENATURE;
            break;

        case INITIAL_DENATURE:
            Logger::info("PCRCycler: Initial denaturation complete");
            currentCycle = 1;
            nextPhase = DENATURE;
            break;

        case DENATURE:
            Logger::debug("PCRCycler: Cycle " + String(currentCycle) + " - Denaturation complete");

            // Two-step PCR: skip separate anneal and extend phases
            if (programParams.twoStepEnabled) {
                nextPhase = ANNEAL_EXTEND;
            } else {
                nextPhase = ANNEAL;
            }
            break;

        case ANNEAL:
            Logger::debug("PCRCycler: Cycle " + String(currentCycle) + " - Annealing complete");
            nextPhase = EXTEND;
            break;

        case EXTEND:
            Logger::debug("PCRCycler: Cycle " + String(currentCycle) + " - Extension complete");

            if (currentCycle < programParams.cycles) {
                currentCycle++;
                nextPhase = DENATURE;
            } else {
                Logger::info("PCRCycler: All cycles complete, starting final extension");
                nextPhase = FINAL_EXTEND;
            }
            break;

        case ANNEAL_EXTEND:
            Logger::debug("PCRCycler: Cycle " + String(currentCycle) + " - Anneal+Extend complete");

            if (currentCycle < programParams.cycles) {
                currentCycle++;
                nextPhase = DENATURE;
            } else {
                Logger::info("PCRCycler: All cycles complete, starting final extension");
                nextPhase = FINAL_EXTEND;
            }
            break;

        case FINAL_EXTEND:
            Logger::info("PCRCycler: Final extension complete, moving to hold");
            nextPhase = HOLD;
            break;

        case HOLD:
            Logger::info("PCRCycler: PCR program complete!");
            nextPhase = COMPLETE;
            running = false;
            break;

        case COMPLETE:
            // Already complete
            break;
    }

    currentPhase = nextPhase;
    phaseStartTime = millis();
    totalPausedTime = 0;  // Reset for new phase
}

String PCRCycler::getPhaseString() const {
    switch (currentPhase) {
        case IDLE: return "IDLE";
        case HOT_START: return "HOT_START";
        case INITIAL_DENATURE: return "INITIAL_DENATURE";
        case DENATURE: return "DENATURE";
        case ANNEAL: return "ANNEAL";
        case EXTEND: return "EXTEND";
        case ANNEAL_EXTEND: return "ANNEAL_EXTEND";
        case FINAL_EXTEND: return "FINAL_EXTEND";
        case HOLD: return "HOLD";
        case COMPLETE: return "COMPLETE";
        default: return "UNKNOWN";
    }
}

uint16_t PCRCycler::getCurrentPhaseDuration() const {
    switch (currentPhase) {
        case HOT_START: return programParams.hotStart.activationTime;
        case INITIAL_DENATURE: return programParams.initialDenatureTime;
        case DENATURE: return programParams.denatureTime;
        case ANNEAL: return programParams.annealTime;
        case EXTEND: return programParams.extendTime;
        case ANNEAL_EXTEND: return programParams.annealExtendTime;
        case FINAL_EXTEND: return programParams.finalExtendTime;
        case HOLD: return 0;  // Infinite hold
        case IDLE:
        case COMPLETE:
        default: return 0;
    }
}

uint16_t PCRCycler::getPhaseTimeRemaining() const {
    if (!running || currentPhase == IDLE || currentPhase == COMPLETE || currentPhase == HOLD) {
        return 0;
    }

    unsigned long now = millis();
    unsigned long elapsed = (now - phaseStartTime - totalPausedTime) / 1000;
    uint16_t duration = getCurrentPhaseDuration();

    if (elapsed >= duration) {
        return 0;
    }

    return duration - elapsed;
}

uint16_t PCRCycler::getTotalTimeRemaining() const {
    if (!running || currentPhase == COMPLETE) {
        return 0;
    }

    uint32_t remaining = 0;

    // Time remaining in current phase
    remaining += getPhaseTimeRemaining();

    // Calculate cycle time based on program type
    uint16_t cycleTime;
    if (programParams.twoStepEnabled) {
        cycleTime = programParams.denatureTime + programParams.annealExtendTime;
    } else {
        cycleTime = programParams.denatureTime + programParams.annealTime + programParams.extendTime;
    }

    // Calculate remaining phases based on current state
    switch (currentPhase) {
        case HOT_START:
            // Hot start + initial denature + all cycles + final extension
            remaining += programParams.initialDenatureTime;
            remaining += programParams.cycles * cycleTime;
            remaining += programParams.finalExtendTime;
            break;

        case INITIAL_DENATURE:
            // All cycles + final extension
            remaining += programParams.cycles * cycleTime;
            remaining += programParams.finalExtendTime;
            break;

        case DENATURE:
        case ANNEAL:
        case EXTEND:
        case ANNEAL_EXTEND: {
            // Remaining time in current cycle
            if (programParams.twoStepEnabled) {
                if (currentPhase == DENATURE) {
                    remaining += programParams.annealExtendTime;
                }
            } else {
                if (currentPhase == DENATURE) {
                    remaining += programParams.annealTime + programParams.extendTime;
                } else if (currentPhase == ANNEAL) {
                    remaining += programParams.extendTime;
                }
            }

            // Remaining cycles
            uint16_t remainingCycles = programParams.cycles - currentCycle;
            remaining += remainingCycles * cycleTime;

            // Final extension
            remaining += programParams.finalExtendTime;
            break;
        }

        case FINAL_EXTEND:
            // Just final extension remaining
            break;

        case HOLD:
        case IDLE:
        case COMPLETE:
        default:
            remaining = 0;
            break;
    }

    return remaining;
}

float PCRCycler::getProgress() const {
    if (!running || totalProgramTime == 0) {
        return 0.0;
    }

    if (currentPhase == COMPLETE) {
        return 100.0;
    }

    uint32_t elapsed = totalProgramTime - getTotalTimeRemaining();
    float progress = (float)elapsed / (float)totalProgramTime * 100.0;

    return constrain(progress, 0.0, 100.0);
}

float PCRCycler::getCurrentTargetTemp() const {
    switch (currentPhase) {
        case HOT_START: return programParams.hotStart.activationTemp;
        case INITIAL_DENATURE: return programParams.initialDenatureTemp;
        case DENATURE: return programParams.denatureTemp;
        case ANNEAL: return getCurrentAnnealTemp();  // May be touchdown temperature
        case EXTEND: return programParams.extendTemp;
        case ANNEAL_EXTEND: return programParams.annealExtendTemp;
        case FINAL_EXTEND: return programParams.finalExtendTemp;
        case HOLD: return programParams.holdTemp;
        case IDLE:
        case COMPLETE:
        default: return 25.0;  // Ambient
    }
}

void PCRCycler::calculateTotalTime() {
    totalProgramTime = 0;

    // Hot start (if enabled)
    if (programParams.hotStart.enabled) {
        totalProgramTime += programParams.hotStart.activationTime;
    }

    // Initial denaturation
    totalProgramTime += programParams.initialDenatureTime;

    // Cycling - depends on program type
    if (programParams.twoStepEnabled) {
        totalProgramTime += programParams.cycles * (programParams.denatureTime +
                                                    programParams.annealExtendTime);
    } else {
        totalProgramTime += programParams.cycles * (programParams.denatureTime +
                                                    programParams.annealTime +
                                                    programParams.extendTime);
    }

    // Final extension
    totalProgramTime += programParams.finalExtendTime;

    // Note: Hold is infinite, so not included in total time

    Logger::info("PCRCycler: Total program time = " + String(totalProgramTime) + " seconds (" +
                String(totalProgramTime / 60) + " minutes)");
}

float PCRCycler::calculateTouchdownTemp() const {
    if (!programParams.touchdown.enabled) {
        return programParams.annealTemp;
    }

    // Calculate touchdown temperature based on current cycle
    if (currentCycle <= programParams.touchdown.touchdownCycles) {
        float tempDecrease = (currentCycle - 1) * programParams.touchdown.stepSize;
        float currentTemp = programParams.touchdown.startAnnealTemp - tempDecrease;
        return constrain(currentTemp, programParams.touchdown.endAnnealTemp, programParams.touchdown.startAnnealTemp);
    }

    // After touchdown cycles, use final temperature
    return programParams.touchdown.endAnnealTemp;
}

float PCRCycler::calculateGradientTemp(uint8_t position) const {
    if (!programParams.gradient.enabled || programParams.gradient.positions == 0) {
        return programParams.annealTemp;
    }

    // Ensure position is within valid range
    if (position >= programParams.gradient.positions) {
        position = programParams.gradient.positions - 1;
    }

    // Calculate temperature for this gradient position
    float range = programParams.gradient.tempHigh - programParams.gradient.tempLow;
    float step = range / (programParams.gradient.positions - 1);
    return programParams.gradient.tempLow + (position * step);
}

float PCRCycler::getCurrentAnnealTemp() const {
    // Touchdown takes precedence over standard annealing temp
    if (programParams.touchdown.enabled) {
        return calculateTouchdownTemp();
    }

    // Otherwise use standard annealing temperature
    return programParams.annealTemp;
}
