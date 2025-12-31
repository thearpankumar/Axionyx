/**
 * SensorSimulator.h
 * Sensor simulation framework for demo firmware
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef SENSOR_SIMULATOR_H
#define SENSOR_SIMULATOR_H

#include <Arduino.h>

/**
 * Base class for sensor simulators
 */
class SensorSimulator {
public:
    virtual ~SensorSimulator() = default;
    virtual float read() = 0;
    virtual void update(float dt) = 0;
};

/**
 * PID Controller for temperature regulation
 */
class PIDController {
public:
    PIDController(float kp = 2.0, float ki = 0.5, float kd = 1.0);

    void setConstants(float kp, float ki, float kd);
    void setSetpoint(float sp);
    float compute(float input, float dt);
    void reset();

private:
    float kp, ki, kd;      // PID constants
    float setpoint;         // Target value
    float integral;         // Integral term
    float previousError;    // Previous error for derivative
};

/**
 * Temperature sensor simulator with realistic heating/cooling
 */
class TemperatureSimulator : public SensorSimulator {
public:
    TemperatureSimulator(float initialTemp = 25.0);

    // SensorSimulator interface
    float read() override;
    void update(float dt) override;

    // Temperature control
    void setSetpoint(float temp);
    float getSetpoint() const { return setpoint; }

    // PID configuration
    void setPIDConstants(float kp, float ki, float kd);
    void enablePID(bool enable);

    // Physical parameters
    void setHeatingRate(float rate) { heatingRate = rate; }
    void setCoolingRate(float rate) { coolingRate = rate; }
    void setAmbientTemp(float temp) { ambientTemp = temp; }

private:
    float currentTemp;      // Current temperature
    float setpoint;         // Target temperature
    float ambientTemp;      // Ambient temperature
    float heatingRate;      // Heating rate (°C/second)
    float coolingRate;      // Cooling rate (°C/second)

    PIDController pid;
    bool pidEnabled;

    // Noise generation
    float getNoise();

    // Thermal simulation
    void simulateThermalDynamics(float dt);
};

/**
 * Humidity sensor simulator
 */
class HumiditySimulator : public SensorSimulator {
public:
    HumiditySimulator(float initialHumidity = 50.0);

    float read() override;
    void update(float dt) override;

    void setSetpoint(float humidity);
    float getSetpoint() const { return setpoint; }

private:
    float currentHumidity;
    float setpoint;
    float changeRate;      // %/second

    float getNoise();
};

/**
 * CO2 level simulator
 */
class CO2Simulator : public SensorSimulator {
public:
    CO2Simulator(float initialLevel = 5.0);

    float read() override;
    void update(float dt) override;

    void setSetpoint(float level);
    float getSetpoint() const { return setpoint; }

private:
    float currentLevel;    // CO2 percentage
    float setpoint;
    float changeRate;      // %/second

    float getNoise();
};

#endif // SENSOR_SIMULATOR_H
