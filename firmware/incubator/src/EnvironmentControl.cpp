/**
 * EnvironmentControl.cpp
 * Environmental control implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "EnvironmentControl.h"
#include "../../common/utils/Logger.h"

EnvironmentControl::EnvironmentControl()
    : tempStabilityThreshold(0.5),      // ±0.5°C
      humidityStabilityThreshold(2.0),  // ±2%
      co2StabilityThreshold(0.3) {      // ±0.3%
}

void EnvironmentControl::begin() {
    Logger::info("EnvironmentControl: Initializing environmental control");
    // TODO: Initialize real sensors here
    Logger::info("EnvironmentControl: Initialized");
}

void EnvironmentControl::setTargets(const EnvironmentParams& targets) {
    Logger::info("EnvironmentControl: Setting new targets");
    Logger::info("  Temperature: " + String(targets.temperature) + "°C");
    Logger::info("  Humidity: " + String(targets.humidity) + "%");
    Logger::info("  CO2: " + String(targets.co2Level) + "%");

    targetParams = targets;
    // TODO: Push new setpoints to real hardware controllers
}

void EnvironmentControl::update(float dt) {
    // Update ramping logic
    updateRamps(millis());
    // TODO: Trigger real sensor reads here
}

EnvironmentControl::EnvironmentStatus EnvironmentControl::getStatus() const {
    EnvironmentStatus status;

    // TODO: Replace with real sensor reads
    status.currentTemperature = readTemperature();
    status.currentHumidity    = readHumidity();
    status.currentCO2         = readCO2();

    // Errors (deviation from setpoint)
    status.temperatureError = targetParams.temperature - status.currentTemperature;
    status.humidityError    = targetParams.humidity    - status.currentHumidity;
    status.co2Error         = targetParams.co2Level    - status.currentCO2;

    // Stability checks
    status.temperatureStable = isStable(status.currentTemperature, targetParams.temperature, tempStabilityThreshold);
    status.humidityStable    = isStable(status.currentHumidity,    targetParams.humidity,    humidityStabilityThreshold);
    status.co2Stable         = isStable(status.currentCO2,         targetParams.co2Level,    co2StabilityThreshold);
    status.allStable         = status.temperatureStable && status.humidityStable && status.co2Stable;

    // Ramping status
    status.temperatureRamping = tempRamp.active;
    status.humidityRamping    = humidityRamp.active;
    status.co2Ramping         = co2Ramp.active;
    status.temperatureTarget  = targetParams.temperature;
    status.humidityTarget     = targetParams.humidity;
    status.co2Target          = targetParams.co2Level;

    return status;
}

void EnvironmentControl::setTemperatureTarget(float temp) {
    Logger::info("EnvironmentControl: Temperature target -> " + String(temp) + "°C");
    targetParams.temperature = temp;
    // TODO: Push to real hardware controller
}

void EnvironmentControl::setHumidityTarget(float humidity) {
    Logger::info("EnvironmentControl: Humidity target -> " + String(humidity) + "%");
    targetParams.humidity = humidity;
    // TODO: Push to real hardware controller
}

void EnvironmentControl::setCO2Target(float co2) {
    Logger::info("EnvironmentControl: CO2 target -> " + String(co2) + "%");
    targetParams.co2Level = co2;
    // TODO: Push to real hardware controller
}

void EnvironmentControl::setStabilityThreshold(float tempThreshold,
                                              float humidityThreshold,
                                              float co2Threshold) {
    tempStabilityThreshold     = tempThreshold;
    humidityStabilityThreshold = humidityThreshold;
    co2StabilityThreshold      = co2Threshold;
    Logger::info("EnvironmentControl: Stability thresholds updated");
}

bool EnvironmentControl::isStable(float current, float target, float threshold) const {
    return abs(current - target) <= threshold;
}

void EnvironmentControl::startTemperatureRamp(float targetTemp, uint32_t durationSeconds) {
    float currentTemp = readTemperature(); // TODO: real sensor
    tempRamp.start(currentTemp, targetTemp, durationSeconds * 1000);
    targetParams.temperature = targetTemp;
    Logger::info("EnvironmentControl: Temperature ramp -> " + String(targetTemp, 1) + "°C over " + String(durationSeconds) + "s");
}

void EnvironmentControl::startHumidityRamp(float targetHumidity, uint32_t durationSeconds) {
    float currentHumidity = readHumidity(); // TODO: real sensor
    humidityRamp.start(currentHumidity, targetHumidity, durationSeconds * 1000);
    targetParams.humidity = targetHumidity;
    Logger::info("EnvironmentControl: Humidity ramp -> " + String(targetHumidity, 1) + "% over " + String(durationSeconds) + "s");
}

void EnvironmentControl::startCO2Ramp(float targetCO2, uint32_t durationSeconds) {
    float currentCO2 = readCO2(); // TODO: real sensor
    co2Ramp.start(currentCO2, targetCO2, durationSeconds * 1000);
    targetParams.co2Level = targetCO2;
    Logger::info("EnvironmentControl: CO2 ramp -> " + String(targetCO2, 2) + "% over " + String(durationSeconds) + "s");
}

void EnvironmentControl::stopAllRamps() {
    tempRamp.stop();
    humidityRamp.stop();
    co2Ramp.stop();
    Logger::info("EnvironmentControl: All ramps stopped");
}

bool EnvironmentControl::isRamping() const {
    return tempRamp.active || humidityRamp.active || co2Ramp.active;
}

void EnvironmentControl::updateRamps(uint32_t now) {
    if (tempRamp.active) {
        targetParams.temperature = tempRamp.getCurrentTarget(now);
        // TODO: Push updated target to real hardware controller
        if (tempRamp.isComplete(now)) {
            Logger::info("EnvironmentControl: Temperature ramp complete");
            tempRamp.stop();
        }
    }

    if (humidityRamp.active) {
        targetParams.humidity = humidityRamp.getCurrentTarget(now);
        // TODO: Push updated target to real hardware controller
        if (humidityRamp.isComplete(now)) {
            Logger::info("EnvironmentControl: Humidity ramp complete");
            humidityRamp.stop();
        }
    }

    if (co2Ramp.active) {
        targetParams.co2Level = co2Ramp.getCurrentTarget(now);
        // TODO: Push updated target to real hardware controller
        if (co2Ramp.isComplete(now)) {
            Logger::info("EnvironmentControl: CO2 ramp complete");
            co2Ramp.stop();
        }
    }
}

// TODO: Replace these stubs with real sensor driver calls
float EnvironmentControl::readTemperature() const { return 0.0; }
float EnvironmentControl::readHumidity()    const { return 0.0; }
float EnvironmentControl::readCO2()         const { return 0.0; }
