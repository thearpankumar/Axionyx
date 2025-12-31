/**
 * SensorSimulator.cpp
 * Sensor simulation implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "SensorSimulator.h"
#include <math.h>

// ============================================================================
// PIDController Implementation
// ============================================================================

PIDController::PIDController(float kp, float ki, float kd)
    : kp(kp), ki(ki), kd(kd), setpoint(0), integral(0), previousError(0) {
}

void PIDController::setConstants(float kp_, float ki_, float kd_) {
    kp = kp_;
    ki = ki_;
    kd = kd_;
}

void PIDController::setSetpoint(float sp) {
    setpoint = sp;
}

float PIDController::compute(float input, float dt) {
    float error = setpoint - input;

    // Proportional term
    float p = kp * error;

    // Integral term (with anti-windup)
    integral += error * dt;
    integral = constrain(integral, -100, 100);
    float i = ki * integral;

    // Derivative term
    float derivative = (error - previousError) / dt;
    float d = kd * derivative;

    previousError = error;

    // Return control output (-1 to 1)
    float output = p + i + d;
    return constrain(output, -1.0, 1.0);
}

void PIDController::reset() {
    integral = 0;
    previousError = 0;
}

// ============================================================================
// TemperatureSimulator Implementation
// ============================================================================

TemperatureSimulator::TemperatureSimulator(float initialTemp)
    : currentTemp(initialTemp),
      setpoint(initialTemp),
      ambientTemp(25.0),
      heatingRate(3.0),      // 3°C per second
      coolingRate(1.5),      // 1.5°C per second
      pid(2.0, 0.5, 1.0),
      pidEnabled(true) {

    pid.setSetpoint(setpoint);
}

float TemperatureSimulator::read() const {
    // Add realistic sensor noise (±0.1°C)
    return currentTemp + getNoise();
}

void TemperatureSimulator::update(float dt) {
    if (pidEnabled) {
        simulateThermalDynamics(dt);
    } else {
        // Simple linear approach to setpoint
        float diff = setpoint - currentTemp;
        if (abs(diff) < 0.1) {
            currentTemp = setpoint;
        } else if (diff > 0) {
            currentTemp += heatingRate * dt;
        } else {
            currentTemp -= coolingRate * dt;
        }
    }
}

void TemperatureSimulator::setSetpoint(float temp) {
    setpoint = constrain(temp, 0.0, 120.0);
    pid.setSetpoint(setpoint);
}

void TemperatureSimulator::setPIDConstants(float kp, float ki, float kd) {
    pid.setConstants(kp, ki, kd);
}

void TemperatureSimulator::enablePID(bool enable) {
    pidEnabled = enable;
    if (enable) {
        pid.reset();
    }
}

float TemperatureSimulator::getNoise() const {
    // Generate realistic sensor noise using random walk
    return (random(-100, 100) / 1000.0); // ±0.1°C
}

void TemperatureSimulator::simulateThermalDynamics(float dt) {
    // Compute PID control output
    float pidOutput = pid.compute(currentTemp, dt);

    // Simulate heating/cooling based on PID output
    if (pidOutput > 0) {
        // Heating (pidOutput ranges from 0 to 1)
        float heatingPower = pidOutput * heatingRate * dt;
        currentTemp += heatingPower;
    } else if (pidOutput < 0) {
        // Cooling (pidOutput ranges from -1 to 0)
        float coolingPower = abs(pidOutput) * coolingRate * dt;
        currentTemp -= coolingPower;
    }

    // Apply ambient temperature drift (thermal loss)
    float ambientDrift = (ambientTemp - currentTemp) * 0.01 * dt;
    currentTemp += ambientDrift;

    // Apply physical constraints
    currentTemp = constrain(currentTemp, 0.0, 120.0);
}

// ============================================================================
// HumiditySimulator Implementation
// ============================================================================

HumiditySimulator::HumiditySimulator(float initialHumidity)
    : currentHumidity(initialHumidity),
      setpoint(initialHumidity),
      changeRate(2.0) {  // 2% per second
}

float HumiditySimulator::read() const {
    return constrain(currentHumidity + getNoise(), 0.0, 100.0);
}

void HumiditySimulator::update(float dt) {
    float diff = setpoint - currentHumidity;

    if (abs(diff) < 0.5) {
        currentHumidity = setpoint;
    } else if (diff > 0) {
        currentHumidity += changeRate * dt;
    } else {
        currentHumidity -= changeRate * dt;
    }

    currentHumidity = constrain(currentHumidity, 0.0, 100.0);
}

void HumiditySimulator::setSetpoint(float humidity) {
    setpoint = constrain(humidity, 0.0, 100.0);
}

float HumiditySimulator::getNoise() const {
    return (random(-50, 50) / 100.0); // ±0.5%
}

// ============================================================================
// CO2Simulator Implementation
// ============================================================================

CO2Simulator::CO2Simulator(float initialLevel)
    : currentLevel(initialLevel),
      setpoint(initialLevel),
      changeRate(0.5) {  // 0.5% per second
}

float CO2Simulator::read() const {
    return constrain(currentLevel + getNoise(), 0.0, 20.0);
}

void CO2Simulator::update(float dt) {
    float diff = setpoint - currentLevel;

    if (abs(diff) < 0.1) {
        currentLevel = setpoint;
    } else if (diff > 0) {
        currentLevel += changeRate * dt;
    } else {
        currentLevel -= changeRate * dt;
    }

    currentLevel = constrain(currentLevel, 0.0, 20.0);
}

void CO2Simulator::setSetpoint(float level) {
    setpoint = constrain(level, 0.0, 20.0);
}

float CO2Simulator::getNoise() const {
    return (random(-10, 10) / 100.0); // ±0.1%
}
