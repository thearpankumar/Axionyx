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
        // Update environmental control
        if (state == RUNNING) {
            envControl.update(dt);

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
    if (params.containsKey("temperature")) {
        envParams.temperature = params["temperature"];
    }
    if (params.containsKey("humidity")) {
        envParams.humidity = params["humidity"];
    }
    if (params.containsKey("co2Level")) {
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
