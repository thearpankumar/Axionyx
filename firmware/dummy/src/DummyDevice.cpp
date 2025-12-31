/**
 * DummyDevice.cpp
 * Simple test device implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "DummyDevice.h"
#include "../../common/utils/Logger.h"

DummyDevice::DummyDevice()
    : tempSensor(25.0),  // Start at room temperature
      lastUpdate(0) {

    // Configure temperature sensor
    tempSensor.setHeatingRate(3.0);   // 3°C/second
    tempSensor.setCoolingRate(1.5);   // 1.5°C/second
    tempSensor.setAmbientTemp(25.0);  // Room temperature
    tempSensor.enablePID(true);
}

void DummyDevice::begin() {
    Logger::info("DummyDevice: Initializing");
    setState(IDLE);
    lastUpdate = millis();
}

void DummyDevice::loop() {
    unsigned long now = millis();
    float dt = (now - lastUpdate) / 1000.0; // Convert to seconds

    if (dt >= (UPDATE_INTERVAL / 1000.0)) {
        // Update sensor simulation
        if (state == RUNNING) {
            tempSensor.update(dt);
        }

        lastUpdate = now;
    }
}

JsonDocument DummyDevice::getStatus() {
    JsonDocument doc;

    doc["state"] = getStateString();
    doc["uptime"] = getUptime();
    doc["temperature"] = tempSensor.read();
    doc["setpoint"] = tempSensor.getSetpoint();

    JsonArray errors = doc["errors"].to<JsonArray>();
    // No errors in dummy device

    return doc;
}

bool DummyDevice::start(JsonDocument& params) {
    Logger::info("DummyDevice: Starting");

    // Check if setpoint is provided
    if (params.containsKey("setpoint")) {
        float setpoint = params["setpoint"];
        tempSensor.setSetpoint(setpoint);
        Logger::info("DummyDevice: Setpoint set to " + String(setpoint) + "°C");
    }

    setState(RUNNING);
    return true;
}

bool DummyDevice::stop() {
    Logger::info("DummyDevice: Stopping");
    setState(IDLE);

    // Reset to ambient temperature
    tempSensor.setSetpoint(25.0);

    return true;
}

bool DummyDevice::pause() {
    if (state == RUNNING) {
        Logger::info("DummyDevice: Pausing");
        setState(PAUSED);
        return true;
    }
    return false;
}

bool DummyDevice::resume() {
    if (state == PAUSED) {
        Logger::info("DummyDevice: Resuming");
        setState(RUNNING);
        return true;
    }
    return false;
}

bool DummyDevice::setSetpoint(uint8_t zone, float value) {
    if (zone == 0) {
        Logger::info("DummyDevice: Setting setpoint to " + String(value) + "°C");
        tempSensor.setSetpoint(value);
        return true;
    }
    return false;
}
