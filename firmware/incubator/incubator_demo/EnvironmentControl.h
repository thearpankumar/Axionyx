/**
 * EnvironmentControl.h
 * Environmental control system for incubator
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef ENVIRONMENT_CONTROL_H
#define ENVIRONMENT_CONTROL_H

#include <Arduino.h>
#include "../../common/simulator/SensorSimulator.h"

class EnvironmentControl {
public:
    // Control parameters
    struct EnvironmentParams {
        float temperature;      // Target temperature (°C)
        float humidity;         // Target humidity (%)
        float co2Level;         // Target CO2 level (%)

        EnvironmentParams() :
            temperature(37.0),  // Standard cell culture temperature
            humidity(95.0),     // High humidity for cell culture
            co2Level(5.0) {}    // Standard CO2 level
    };

    // Environmental status
    struct EnvironmentStatus {
        float currentTemperature;
        float currentHumidity;
        float currentCO2;
        float temperatureError;
        float humidityError;
        float co2Error;
        bool temperatureStable;
        bool humidityStable;
        bool co2Stable;
        bool allStable;
    };

    EnvironmentControl();

    void begin();
    void setTargets(const EnvironmentParams& targets);
    void update(float dt);

    EnvironmentStatus getStatus() const;
    EnvironmentParams getTargets() const { return targetParams; }

    // Individual parameter control
    void setTemperatureTarget(float temp);
    void setHumidityTarget(float humidity);
    void setCO2Target(float co2);

    // Stability configuration
    void setStabilityThreshold(float tempThreshold, float humidityThreshold, float co2Threshold);

private:
    TemperatureSimulator tempSensor;
    HumiditySimulator humiditySensor;
    CO2Simulator co2Sensor;

    EnvironmentParams targetParams;

    // Stability thresholds
    float tempStabilityThreshold;
    float humidityStabilityThreshold;
    float co2StabilityThreshold;

    // Helper methods
    bool isStable(float current, float target, float threshold) const;
};

#endif // ENVIRONMENT_CONTROL_H
