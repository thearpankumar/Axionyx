/**
 * EnvironmentControl.cpp
 * Environmental control implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "EnvironmentControl.h"
#include "../../../common/utils/Logger.h"

EnvironmentControl::EnvironmentControl()
    : tempSensor(25.0),
      humiditySensor(50.0),
      co2Sensor(0.04),  // Ambient CO2 (0.04%)
      tempStabilityThreshold(0.5),      // ±0.5°C
      humidityStabilityThreshold(2.0),  // ±2%
      co2StabilityThreshold(0.3) {      // ±0.3%
}

void EnvironmentControl::begin() {
    Logger::info("EnvironmentControl: Initializing environmental control");

    // Configure temperature sensor
    tempSensor.setHeatingRate(1.0);    // Slow, controlled heating
    tempSensor.setCoolingRate(0.5);    // Slow cooling
    tempSensor.setAmbientTemp(25.0);
    tempSensor.enablePID(true);
    tempSensor.setPIDConstants(1.5, 0.3, 0.8);  // Tuned for stability

    // Configure humidity sensor
    humiditySensor.setSetpoint(50.0);  // Default ambient

    // Configure CO2 sensor
    co2Sensor.setSetpoint(0.04);  // Ambient level

    Logger::info("EnvironmentControl: Initialized");
}

void EnvironmentControl::setTargets(const EnvironmentParams& targets) {
    Logger::info("EnvironmentControl: Setting new targets");
    Logger::info("  Temperature: " + String(targets.temperature) + "°C");
    Logger::info("  Humidity: " + String(targets.humidity) + "%");
    Logger::info("  CO2: " + String(targets.co2Level) + "%");

    targetParams = targets;

    // Update sensor setpoints
    tempSensor.setSetpoint(targets.temperature);
    humiditySensor.setSetpoint(targets.humidity);
    co2Sensor.setSetpoint(targets.co2Level);
}

void EnvironmentControl::update(float dt) {
    // Update ramping first
    updateRamps(millis());

    // Update all environmental parameters
    tempSensor.update(dt);
    humiditySensor.update(dt);
    co2Sensor.update(dt);
}

EnvironmentControl::EnvironmentStatus EnvironmentControl::getStatus() const {
    EnvironmentStatus status;

    // Read current values
    status.currentTemperature = tempSensor.read();
    status.currentHumidity = humiditySensor.read();
    status.currentCO2 = co2Sensor.read();

    // Calculate errors
    status.temperatureError = targetParams.temperature - status.currentTemperature;
    status.humidityError = targetParams.humidity - status.currentHumidity;
    status.co2Error = targetParams.co2Level - status.currentCO2;

    // Check stability
    status.temperatureStable = isStable(status.currentTemperature,
                                       targetParams.temperature,
                                       tempStabilityThreshold);

    status.humidityStable = isStable(status.currentHumidity,
                                    targetParams.humidity,
                                    humidityStabilityThreshold);

    status.co2Stable = isStable(status.currentCO2,
                               targetParams.co2Level,
                               co2StabilityThreshold);

    // Overall stability
    status.allStable = status.temperatureStable &&
                      status.humidityStable &&
                      status.co2Stable;

    // Ramping status
    status.temperatureRamping = tempRamp.active;
    status.humidityRamping = humidityRamp.active;
    status.co2Ramping = co2Ramp.active;
    status.temperatureTarget = targetParams.temperature;
    status.humidityTarget = targetParams.humidity;
    status.co2Target = targetParams.co2Level;

    return status;
}

void EnvironmentControl::setTemperatureTarget(float temp) {
    Logger::info("EnvironmentControl: Setting temperature target to " +
                String(temp) + "°C");
    targetParams.temperature = temp;
    tempSensor.setSetpoint(temp);
}

void EnvironmentControl::setHumidityTarget(float humidity) {
    Logger::info("EnvironmentControl: Setting humidity target to " +
                String(humidity) + "%");
    targetParams.humidity = humidity;
    humiditySensor.setSetpoint(humidity);
}

void EnvironmentControl::setCO2Target(float co2) {
    Logger::info("EnvironmentControl: Setting CO2 target to " +
                String(co2) + "%");
    targetParams.co2Level = co2;
    co2Sensor.setSetpoint(co2);
}

void EnvironmentControl::setStabilityThreshold(float tempThreshold,
                                              float humidityThreshold,
                                              float co2Threshold) {
    tempStabilityThreshold = tempThreshold;
    humidityStabilityThreshold = humidityThreshold;
    co2StabilityThreshold = co2Threshold;

    Logger::info("EnvironmentControl: Stability thresholds updated");
}

bool EnvironmentControl::isStable(float current, float target, float threshold) const {
    return abs(current - target) <= threshold;
}

void EnvironmentControl::startTemperatureRamp(float targetTemp, uint32_t durationSeconds) {
    float currentTemp = tempSensor.read();
    tempRamp.start(currentTemp, targetTemp, durationSeconds * 1000);
    targetParams.temperature = targetTemp;

    Logger::info("EnvironmentControl: Starting temperature ramp from " +
                String(currentTemp, 1) + "°C to " + String(targetTemp, 1) +
                "°C over " + String(durationSeconds) + " seconds");
}

void EnvironmentControl::startHumidityRamp(float targetHumidity, uint32_t durationSeconds) {
    float currentHumidity = humiditySensor.read();
    humidityRamp.start(currentHumidity, targetHumidity, durationSeconds * 1000);
    targetParams.humidity = targetHumidity;

    Logger::info("EnvironmentControl: Starting humidity ramp from " +
                String(currentHumidity, 1) + "% to " + String(targetHumidity, 1) +
                "% over " + String(durationSeconds) + " seconds");
}

void EnvironmentControl::startCO2Ramp(float targetCO2, uint32_t durationSeconds) {
    float currentCO2 = co2Sensor.read();
    co2Ramp.start(currentCO2, targetCO2, durationSeconds * 1000);
    targetParams.co2Level = targetCO2;

    Logger::info("EnvironmentControl: Starting CO2 ramp from " +
                String(currentCO2, 2) + "% to " + String(targetCO2, 2) +
                "% over " + String(durationSeconds) + " seconds");
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
    // Update temperature ramp
    if (tempRamp.active) {
        float currentTarget = tempRamp.getCurrentTarget(now);
        tempSensor.setSetpoint(currentTarget);

        if (tempRamp.isComplete(now)) {
            Logger::info("EnvironmentControl: Temperature ramp complete");
            tempRamp.stop();
        }
    }

    // Update humidity ramp
    if (humidityRamp.active) {
        float currentTarget = humidityRamp.getCurrentTarget(now);
        humiditySensor.setSetpoint(currentTarget);

        if (humidityRamp.isComplete(now)) {
            Logger::info("EnvironmentControl: Humidity ramp complete");
            humidityRamp.stop();
        }
    }

    // Update CO2 ramp
    if (co2Ramp.active) {
        float currentTarget = co2Ramp.getCurrentTarget(now);
        co2Sensor.setSetpoint(currentTarget);

        if (co2Ramp.isComplete(now)) {
            Logger::info("EnvironmentControl: CO2 ramp complete");
            co2Ramp.stop();
        }
    }
}
