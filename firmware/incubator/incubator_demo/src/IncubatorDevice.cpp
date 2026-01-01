/**
 * IncubatorDevice.cpp
 * Incubator device implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "IncubatorDevice.h"
#include "../../../common/utils/Logger.h"

IncubatorDevice::IncubatorDevice()
    : lastUpdate(0),
      stabilityAchievedTime(0),
      wasStable(false) {
}

void IncubatorDevice::begin() {
    Logger::info("IncubatorDevice: Initializing");

    envControl.begin();

    setState(IDLE);
    lastUpdate = millis();

    Logger::info("IncubatorDevice: Initialized");
}

void IncubatorDevice::loop() {
    unsigned long now = millis();
    float dt = (now - lastUpdate) / 1000.0; // Convert to seconds

    if (dt >= (UPDATE_INTERVAL / 1000.0)) {
        // Update protocol manager
        updateProtocol();

        // Update environmental control
        if (state == RUNNING || state == PAUSED) {
            envControl.update(dt);

            // Check alarms
            updateAlarms();

            // Check for stability transitions
            checkStabilityTransition();
        }

        lastUpdate = now;
    }
}

JsonDocument IncubatorDevice::getStatus() {
    JsonDocument doc;

    // Device state
    doc["state"] = getStateString();
    doc["uptime"] = getUptime();

    // Get environmental status
    EnvironmentControl::EnvironmentStatus envStatus = envControl.getStatus();

    // Current readings
    doc["temperature"] = envStatus.currentTemperature;
    doc["humidity"] = envStatus.currentHumidity;
    doc["co2Level"] = envStatus.currentCO2;

    // Target setpoints
    EnvironmentControl::EnvironmentParams targets = envControl.getTargets();
    doc["temperatureSetpoint"] = targets.temperature;
    doc["humiditySetpoint"] = targets.humidity;
    doc["co2Setpoint"] = targets.co2Level;

    // Errors (deviation from setpoint)
    doc["temperatureError"] = envStatus.temperatureError;
    doc["humidityError"] = envStatus.humidityError;
    doc["co2Error"] = envStatus.co2Error;

    // Stability indicators
    doc["temperatureStable"] = envStatus.temperatureStable;
    doc["humidityStable"] = envStatus.humidityStable;
    doc["co2Stable"] = envStatus.co2Stable;
    doc["environmentStable"] = envStatus.allStable;

    // Time at stable conditions
    if (envStatus.allStable && stabilityAchievedTime > 0) {
        unsigned long timeStable = (millis() - stabilityAchievedTime) / 1000;
        doc["timeStable"] = timeStable;
    } else {
        doc["timeStable"] = 0;
    }

    // Ramping status
    JsonObject ramping = doc["ramping"].to<JsonObject>();
    ramping["temperature"] = envStatus.temperatureRamping;
    ramping["humidity"] = envStatus.humidityRamping;
    ramping["co2"] = envStatus.co2Ramping;

    // Protocol information
    if (protocolManager.getState() != ProtocolManager::IDLE) {
        JsonObject protocol = doc["protocol"].to<JsonObject>();
        protocol["state"] = protocolManager.getStateString();
        protocol["name"] = protocolManager.getCurrentProtocol().name;
        protocol["type"] = static_cast<int>(protocolManager.getCurrentProtocol().type);
        protocol["currentStage"] = protocolManager.getCurrentStageNumber() + 1;
        protocol["totalStages"] = protocolManager.getTotalStages();
        protocol["stageName"] = protocolManager.getCurrentStage().name;
        protocol["stageTimeRemaining"] = protocolManager.getStageTimeRemaining();
        protocol["progress"] = protocolManager.getProgress();
    }

    // Alarm information
    JsonObject alarms = doc["alarms"].to<JsonObject>();
    alarms["activeCount"] = alarmManager.getActiveAlarmCount();
    alarms["hasCritical"] = alarmManager.hasCriticalAlarms();

    if (alarmManager.hasActiveAlarms()) {
        JsonArray activeAlarms = alarms["active"].to<JsonArray>();
        std::vector<AlarmManager::Alarm> activeList = alarmManager.getActiveAlarms();

        for (const auto& alarm : activeList) {
            JsonObject alarmObj = activeAlarms.add<JsonObject>();
            alarmObj["type"] = static_cast<int>(alarm.type);
            alarmObj["severity"] = static_cast<int>(alarm.severity);
            alarmObj["message"] = alarm.message;
            alarmObj["timestamp"] = alarm.timestamp;
            alarmObj["acknowledged"] = alarm.acknowledged;
            alarmObj["currentValue"] = alarm.currentValue;
            alarmObj["threshold"] = alarm.threshold;
        }
    }

    // Additional features
    doc["doorOpen"] = false;  // Simulated - always closed

    // Errors
    JsonArray errors = doc["errors"].to<JsonArray>();
    // No errors in simulated device

    return doc;
}

bool IncubatorDevice::start(JsonDocument& params) {
    Logger::info("IncubatorDevice: Starting incubation");

    EnvironmentControl::EnvironmentParams envParams;

    // Parse environment parameters if provided
    if (!params["temperature"].isNull()) {
        envParams.temperature = params["temperature"];
    }
    if (!params["humidity"].isNull()) {
        envParams.humidity = params["humidity"];
    }
    if (!params["co2Level"].isNull()) {
        envParams.co2Level = params["co2Level"];
    }

    // Set environmental targets
    envControl.setTargets(envParams);

    setState(RUNNING);
    stabilityAchievedTime = 0;
    wasStable = false;

    return true;
}

bool IncubatorDevice::stop() {
    Logger::info("IncubatorDevice: Stopping incubation");

    setState(IDLE);

    // Return to ambient conditions
    EnvironmentControl::EnvironmentParams ambient;
    ambient.temperature = 25.0;
    ambient.humidity = 50.0;
    ambient.co2Level = 0.04;  // Ambient CO2

    envControl.setTargets(ambient);

    stabilityAchievedTime = 0;
    wasStable = false;

    return true;
}

bool IncubatorDevice::pause() {
    if (state == RUNNING) {
        Logger::info("IncubatorDevice: Pausing (maintaining current conditions)");
        setState(PAUSED);
        return true;
    }
    return false;
}

bool IncubatorDevice::resume() {
    if (state == PAUSED) {
        Logger::info("IncubatorDevice: Resuming incubation");
        setState(RUNNING);
        return true;
    }
    return false;
}

bool IncubatorDevice::setSetpoint(uint8_t zone, float value) {
    // For incubator, zone parameter determines what to set:
    // 0 = temperature, 1 = humidity, 2 = CO2
    switch (zone) {
        case 0:
            return setTemperature(value);
        case 1:
            return setHumidity(value);
        case 2:
            return setCO2(value);
        default:
            Logger::error("IncubatorDevice: Invalid zone " + String(zone));
            return false;
    }
}

bool IncubatorDevice::setEnvironmentParams(const EnvironmentControl::EnvironmentParams& params) {
    Logger::info("IncubatorDevice: Setting environmental parameters");
    envControl.setTargets(params);
    return true;
}

EnvironmentControl::EnvironmentParams IncubatorDevice::getEnvironmentParams() const {
    return envControl.getTargets();
}

bool IncubatorDevice::setTemperature(float temp) {
    if (temp < 4.0 || temp > 50.0) {
        Logger::error("IncubatorDevice: Temperature out of range (4-50°C)");
        return false;
    }

    Logger::info("IncubatorDevice: Setting temperature to " + String(temp) + "°C");
    envControl.setTemperatureTarget(temp);

    // Reset stability tracking
    stabilityAchievedTime = 0;
    wasStable = false;

    return true;
}

bool IncubatorDevice::setHumidity(float humidity) {
    if (humidity < 0.0 || humidity > 100.0) {
        Logger::error("IncubatorDevice: Humidity out of range (0-100%)");
        return false;
    }

    Logger::info("IncubatorDevice: Setting humidity to " + String(humidity) + "%");
    envControl.setHumidityTarget(humidity);

    // Reset stability tracking
    stabilityAchievedTime = 0;
    wasStable = false;

    return true;
}

bool IncubatorDevice::setCO2(float co2) {
    if (co2 < 0.0 || co2 > 20.0) {
        Logger::error("IncubatorDevice: CO2 level out of range (0-20%)");
        return false;
    }

    Logger::info("IncubatorDevice: Setting CO2 level to " + String(co2) + "%");
    envControl.setCO2Target(co2);

    // Reset stability tracking
    stabilityAchievedTime = 0;
    wasStable = false;

    return true;
}

void IncubatorDevice::checkStabilityTransition() {
    EnvironmentControl::EnvironmentStatus status = envControl.getStatus();

    // Check if stability state changed
    if (!wasStable && status.allStable) {
        // Just became stable
        stabilityAchievedTime = millis();
        Logger::info("IncubatorDevice: Environmental conditions stabilized");
        wasStable = true;
    } else if (wasStable && !status.allStable) {
        // Lost stability
        stabilityAchievedTime = 0;
        Logger::warning("IncubatorDevice: Environmental conditions unstable");
        wasStable = false;
    }
}

void IncubatorDevice::updateProtocol() {
    if (protocolManager.getState() == ProtocolManager::IDLE ||
        protocolManager.getState() == ProtocolManager::COMPLETE) {
        return;
    }

    uint32_t now = millis();
    protocolManager.update(now);

    // Apply current stage parameters
    if (protocolManager.getState() == ProtocolManager::PREHEATING ||
        protocolManager.getState() == ProtocolManager::RUNNING) {
        applyProtocolStage(protocolManager.getCurrentStage());
    }
}

void IncubatorDevice::updateAlarms() {
    EnvironmentControl::EnvironmentStatus envStatus = envControl.getStatus();
    EnvironmentControl::EnvironmentParams targets = envControl.getTargets();

    alarmManager.checkAlarms(envStatus, targets.temperature,
                            targets.humidity, targets.co2Level);
}

void IncubatorDevice::applyProtocolStage(const ProtocolManager::ProtocolStage& stage) {
    // Apply stage targets with ramping if enabled
    if (stage.rampToTarget) {
        // Use ramping for gradual transition
        envControl.startTemperatureRamp(stage.temperature, stage.rampTime);
        envControl.startHumidityRamp(stage.humidity, stage.rampTime);
        envControl.startCO2Ramp(stage.co2Level, stage.rampTime);
    } else {
        // Instant setpoint change
        EnvironmentControl::EnvironmentParams params;
        params.temperature = stage.temperature;
        params.humidity = stage.humidity;
        params.co2Level = stage.co2Level;
        envControl.setTargets(params);
    }
}

bool IncubatorDevice::startProtocol(const ProtocolManager::Protocol& protocol) {
    Logger::info("IncubatorDevice: Starting protocol - " + protocol.name);

    // Set alarm thresholds from protocol
    AlarmManager::AlarmThresholds thresholds;
    thresholds.tempWarningHigh = protocol.tempAlarmHigh - 0.5;
    thresholds.tempCriticalHigh = protocol.tempAlarmHigh;
    thresholds.tempWarningLow = protocol.tempAlarmLow + 0.5;
    thresholds.tempCriticalLow = protocol.tempAlarmLow;
    thresholds.humidityWarningLow = protocol.humidityAlarmLow + 5.0;
    thresholds.humidityCriticalLow = protocol.humidityAlarmLow;
    thresholds.co2WarningHigh = protocol.co2AlarmHigh - 0.2;
    thresholds.co2CriticalHigh = protocol.co2AlarmHigh;
    thresholds.co2WarningLow = protocol.co2AlarmLow + 0.2;
    thresholds.co2CriticalLow = protocol.co2AlarmLow;

    alarmManager.setThresholds(thresholds);

    // Start protocol
    protocolManager.startProtocol(protocol);

    // Start device
    setState(RUNNING);
    stabilityAchievedTime = 0;
    wasStable = false;

    return true;
}

bool IncubatorDevice::stopProtocol() {
    Logger::info("IncubatorDevice: Stopping protocol");
    protocolManager.stopProtocol();
    return stop();
}

bool IncubatorDevice::pauseProtocol() {
    if (protocolManager.getState() == ProtocolManager::RUNNING ||
        protocolManager.getState() == ProtocolManager::PREHEATING) {
        Logger::info("IncubatorDevice: Pausing protocol");
        protocolManager.pauseProtocol();
        setState(PAUSED);
        return true;
    }
    return false;
}

bool IncubatorDevice::resumeProtocol() {
    if (protocolManager.getState() == ProtocolManager::PAUSED) {
        Logger::info("IncubatorDevice: Resuming protocol");
        protocolManager.resumeProtocol();
        setState(RUNNING);
        return true;
    }
    return false;
}

bool IncubatorDevice::nextProtocolStage() {
    if (protocolManager.getState() != ProtocolManager::IDLE &&
        protocolManager.getState() != ProtocolManager::COMPLETE) {
        Logger::info("IncubatorDevice: Advancing to next protocol stage");
        protocolManager.nextStage();
        return true;
    }
    return false;
}

void IncubatorDevice::acknowledgeAlarm(uint8_t index) {
    alarmManager.acknowledgeAlarm(index);
}

void IncubatorDevice::acknowledgeAllAlarms() {
    alarmManager.acknowledgeAll();
}
