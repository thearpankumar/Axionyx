/**
 * EnvironmentControl.cpp
 * Environmental control implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "EnvironmentControl.h"
#include "../../common/utils/Logger.h"

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
