/**
 * DummyDevice.h
 * Simple test device for WiFi and API testing
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef DUMMY_DEVICE_H
#define DUMMY_DEVICE_H

#include "../common/device/DeviceBase.h"
#include "../common/simulator/SensorSimulator.h"

class DummyDevice : public DeviceBase {
public:
    DummyDevice();

    // DeviceBase interface implementation
    void begin() override;
    void loop() override;
    JsonDocument getStatus() override;
    bool start(JsonDocument& params) override;
    bool stop() override;
    bool pause() override;
    bool resume() override;
    bool setSetpoint(uint8_t zone, float value) override;

private:
    TemperatureSimulator tempSensor;
    unsigned long lastUpdate;
    static const unsigned long UPDATE_INTERVAL = 100; // 100ms = 10 Hz
};

#endif // DUMMY_DEVICE_H
