/**
 * ProtocolManager.cpp
 * Multi-stage protocol implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "ProtocolManager.h"
#include "../../../common/utils/Logger.h"

ProtocolManager::ProtocolManager()
    : currentState(IDLE),
      pauseStartTime(0),
      totalPausedTime(0) {
}

void ProtocolManager::startProtocol(const Protocol& protocol) {
    Logger::info("ProtocolManager: Starting protocol: " + protocol.name);
    Logger::info("ProtocolManager: Total stages: " + String(protocol.stages.size()));

    currentProtocol = protocol;
    currentProtocol.currentStage = 0;
    currentProtocol.stageStartTime = millis();
    pauseStartTime = 0;
    totalPausedTime = 0;

    if (protocol.stages.size() > 0) {
        ProtocolStage stage = protocol.stages[0];
        Logger::info("ProtocolManager: Starting stage 1: " + stage.name);
        Logger::info("ProtocolManager: Target - Temp: " + String(stage.temperature) +
                    "°C, Humidity: " + String(stage.humidity) +
                    "%, CO2: " + String(stage.co2Level) + "%");

        if (stage.rampToTarget) {
            currentState = PREHEATING;
            Logger::info("ProtocolManager: Ramping to target over " +
                        String(stage.rampTime) + " seconds");
        } else {
            currentState = RUNNING;
        }
    } else {
        Logger::error("ProtocolManager: Protocol has no stages!");
        currentState = IDLE;
    }
}

void ProtocolManager::stopProtocol() {
    Logger::info("ProtocolManager: Stopping protocol");
    currentState = IDLE;
    currentProtocol.currentStage = 0;
    pauseStartTime = 0;
    totalPausedTime = 0;
}

void ProtocolManager::pauseProtocol() {
    if (currentState == RUNNING || currentState == PREHEATING) {
        Logger::info("ProtocolManager: Pausing protocol at stage " +
                    String(currentProtocol.currentStage + 1));
        currentState = PAUSED;
        pauseStartTime = millis();
    }
}

void ProtocolManager::resumeProtocol() {
    if (currentState == PAUSED) {
        Logger::info("ProtocolManager: Resuming protocol");

        // Add paused duration to total
        uint32_t pauseDuration = millis() - pauseStartTime;
        totalPausedTime += pauseDuration;
        pauseStartTime = 0;

        // Return to appropriate state
        ProtocolStage stage = getCurrentStage();
        if (stage.rampToTarget) {
            currentState = PREHEATING;
        } else {
            currentState = RUNNING;
        }
    }
}

void ProtocolManager::nextStage() {
    if (currentState != IDLE && currentState != COMPLETE) {
        Logger::info("ProtocolManager: Manual stage advancement requested");
        transitionToNextStage();
    }
}

void ProtocolManager::update(uint32_t now) {
    if (currentState == IDLE || currentState == PAUSED || currentState == COMPLETE) {
        return;
    }

    // Check if current stage is complete
    uint32_t elapsed = getStageElapsedTime(now);
    ProtocolStage stage = getCurrentStage();

    // If stage has a duration (not indefinite), check for completion
    if (stage.duration > 0 && elapsed >= stage.duration) {
        Logger::info("ProtocolManager: Stage " + String(currentProtocol.currentStage + 1) +
                    " (" + stage.name + ") complete");
        transitionToNextStage();
    }

    // If in PREHEATING state with ramping, check if ramp is complete
    if (currentState == PREHEATING && stage.rampToTarget) {
        if (elapsed >= stage.rampTime) {
            Logger::info("ProtocolManager: Pre-heating complete, entering running state");
            currentState = RUNNING;
        }
    }
}

void ProtocolManager::transitionToNextStage() {
    uint8_t nextStage = currentProtocol.currentStage + 1;

    if (nextStage >= currentProtocol.stages.size()) {
        // No more stages - protocol complete
        Logger::info("ProtocolManager: All stages complete!");
        currentState = COMPLETE;
        return;
    }

    // Move to next stage
    currentProtocol.currentStage = nextStage;
    currentProtocol.stageStartTime = millis();
    totalPausedTime = 0;  // Reset for new stage

    ProtocolStage stage = currentProtocol.stages[nextStage];
    Logger::info("ProtocolManager: Starting stage " + String(nextStage + 1) + ": " + stage.name);
    Logger::info("ProtocolManager: Target - Temp: " + String(stage.temperature) +
                "°C, Humidity: " + String(stage.humidity) +
                "%, CO2: " + String(stage.co2Level) + "%");

    if (stage.rampToTarget) {
        currentState = PREHEATING;
        Logger::info("ProtocolManager: Ramping to target over " +
                    String(stage.rampTime) + " seconds");
    } else {
        currentState = RUNNING;
    }
}

ProtocolManager::ProtocolStage ProtocolManager::getCurrentStage() const {
    if (currentProtocol.currentStage < currentProtocol.stages.size()) {
        return currentProtocol.stages[currentProtocol.currentStage];
    }
    return ProtocolStage();  // Return default stage if out of bounds
}

uint32_t ProtocolManager::getStageTimeRemaining() const {
    if (currentState == IDLE || currentState == COMPLETE) {
        return 0;
    }

    ProtocolStage stage = getCurrentStage();
    if (stage.duration == 0) {
        return 0;  // Indefinite stage
    }

    uint32_t elapsed = getStageElapsedTime(millis());
    if (elapsed >= stage.duration) {
        return 0;
    }

    return stage.duration - elapsed;
}

float ProtocolManager::getProgress() const {
    if (currentState == IDLE) {
        return 0.0;
    }

    if (currentState == COMPLETE) {
        return 100.0;
    }

    // Calculate progress as: (completed stages + current stage progress) / total stages
    uint8_t completedStages = currentProtocol.currentStage;
    uint8_t totalStages = currentProtocol.stages.size();

    if (totalStages == 0) {
        return 0.0;
    }

    float stageProgress = 0.0;
    ProtocolStage currentStage = getCurrentStage();

    if (currentStage.duration > 0) {
        uint32_t elapsed = getStageElapsedTime(millis());
        stageProgress = (float)elapsed / (float)currentStage.duration;
        stageProgress = constrain(stageProgress, 0.0, 1.0);
    }

    float progress = ((float)completedStages + stageProgress) / (float)totalStages * 100.0;
    return constrain(progress, 0.0, 100.0);
}

String ProtocolManager::getStateString() const {
    switch (currentState) {
        case IDLE: return "IDLE";
        case PREHEATING: return "PREHEATING";
        case RUNNING: return "RUNNING";
        case PAUSED: return "PAUSED";
        case COMPLETE: return "COMPLETE";
        default: return "UNKNOWN";
    }
}

uint32_t ProtocolManager::getStageElapsedTime(uint32_t now) const {
    if (currentState == IDLE || currentState == COMPLETE) {
        return 0;
    }

    // Calculate time since stage started, excluding paused time
    uint32_t elapsed = (now - currentProtocol.stageStartTime - totalPausedTime) / 1000;
    return elapsed;
}
