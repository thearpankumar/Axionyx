/**
 * EnvironmentControl.h
 * Environmental control system for incubator
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef ENVIRONMENT_CONTROL_H
#define ENVIRONMENT_CONTROL_H

#include <Arduino.h>
#include "../../../common/simulator/SensorSimulator.h"

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

        // Ramping status
        bool temperatureRamping;
        bool humidityRamping;
        bool co2Ramping;
        float temperatureTarget;
        float humidityTarget;
        float co2Target;
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

    // Parameter ramping
    void startTemperatureRamp(float targetTemp, uint32_t durationSeconds);
    void startHumidityRamp(float targetHumidity, uint32_t durationSeconds);
    void startCO2Ramp(float targetCO2, uint32_t durationSeconds);
    void stopAllRamps();

    // Check if ramping
    bool isRamping() const;

    // Stability configuration
    void setStabilityThreshold(float tempThreshold, float humidityThreshold, float co2Threshold);

private:
    // Parameter ramping structure
    struct ParameterRamp {
        bool active;
        float startValue;
        float targetValue;
        uint32_t durationMs;
        uint32_t startTime;

        ParameterRamp() : active(false), startValue(0), targetValue(0),
                         durationMs(0), startTime(0) {}

        void start(float start, float target, uint32_t duration) {
            active = true;
            startValue = start;
            targetValue = target;
            durationMs = duration;
            startTime = millis();
        }

        void stop() {
            active = false;
        }

        bool isComplete(uint32_t now) const {
            return active && (now - startTime >= durationMs);
        }

        float getCurrentTarget(uint32_t now) const {
            if (!active) return targetValue;

            uint32_t elapsed = now - startTime;
            if (elapsed >= durationMs) return targetValue;

            // Linear interpolation
            float progress = (float)elapsed / (float)durationMs;
            return startValue + (targetValue - startValue) * progress;
        }
    };

    TemperatureSimulator tempSensor;
    HumiditySimulator humiditySensor;
    CO2Simulator co2Sensor;

    EnvironmentParams targetParams;

    // Stability thresholds
    float tempStabilityThreshold;
    float humidityStabilityThreshold;
    float co2StabilityThreshold;

    // Ramping state
    ParameterRamp tempRamp;
    ParameterRamp humidityRamp;
    ParameterRamp co2Ramp;

    // Helper methods
    bool isStable(float current, float target, float threshold) const;
    void updateRamps(uint32_t now);
};

#endif // ENVIRONMENT_CONTROL_H
