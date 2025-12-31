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
    Logger::info("PCRCycler: Cycles=" + String(program.cycles) +
                ", Denature=" + String(program.denatureTemp) + "°C" +
                ", Anneal=" + String(program.annealTemp) + "°C" +
                ", Extend=" + String(program.extendTemp) + "°C");

    programParams = program;
    currentPhase = INITIAL_DENATURE;
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

        case INITIAL_DENATURE:
            Logger::info("PCRCycler: Initial denaturation complete");
            currentCycle = 1;
            nextPhase = DENATURE;
            break;

        case DENATURE:
            Logger::debug("PCRCycler: Cycle " + String(currentCycle) + " - Denaturation complete");
            nextPhase = ANNEAL;
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
        case INITIAL_DENATURE: return "INITIAL_DENATURE";
        case DENATURE: return "DENATURE";
        case ANNEAL: return "ANNEAL";
        case EXTEND: return "EXTEND";
        case FINAL_EXTEND: return "FINAL_EXTEND";
        case HOLD: return "HOLD";
        case COMPLETE: return "COMPLETE";
        default: return "UNKNOWN";
    }
}

uint16_t PCRCycler::getCurrentPhaseDuration() const {
    switch (currentPhase) {
        case INITIAL_DENATURE: return programParams.initialDenatureTime;
        case DENATURE: return programParams.denatureTime;
        case ANNEAL: return programParams.annealTime;
        case EXTEND: return programParams.extendTime;
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

    // Calculate remaining phases based on current state
    switch (currentPhase) {
        case INITIAL_DENATURE:
            // All cycles + final extension
            remaining += programParams.cycles * (programParams.denatureTime +
                                                 programParams.annealTime +
                                                 programParams.extendTime);
            remaining += programParams.finalExtendTime;
            break;

        case DENATURE:
        case ANNEAL:
        case EXTEND: {
            // Remaining time in current cycle
            if (currentPhase == DENATURE) {
                remaining += programParams.annealTime + programParams.extendTime;
            } else if (currentPhase == ANNEAL) {
                remaining += programParams.extendTime;
            }

            // Remaining cycles
            uint16_t remainingCycles = programParams.cycles - currentCycle;
            remaining += remainingCycles * (programParams.denatureTime +
                                           programParams.annealTime +
                                           programParams.extendTime);

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
        case INITIAL_DENATURE: return programParams.initialDenatureTemp;
        case DENATURE: return programParams.denatureTemp;
        case ANNEAL: return programParams.annealTemp;
        case EXTEND: return programParams.extendTemp;
        case FINAL_EXTEND: return programParams.finalExtendTemp;
        case HOLD: return programParams.holdTemp;
        case IDLE:
        case COMPLETE:
        default: return 25.0;  // Ambient
    }
}

void PCRCycler::calculateTotalTime() {
    totalProgramTime = 0;

    // Initial denaturation
    totalProgramTime += programParams.initialDenatureTime;

    // Cycling
    totalProgramTime += programParams.cycles * (programParams.denatureTime +
                                                programParams.annealTime +
                                                programParams.extendTime);

    // Final extension
    totalProgramTime += programParams.finalExtendTime;

    // Note: Hold is infinite, so not included in total time

    Logger::info("PCRCycler: Total program time = " + String(totalProgramTime) + " seconds (" +
                String(totalProgramTime / 60) + " minutes)");
}
