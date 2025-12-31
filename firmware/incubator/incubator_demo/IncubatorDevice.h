/**
 * IncubatorDevice.h
 * Incubator device implementation
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef INCUBATOR_DEVICE_H
#define INCUBATOR_DEVICE_H

#include "../../common/device/DeviceBase.h"
#include "EnvironmentControl.h"

class IncubatorDevice : public DeviceBase {
public:
    IncubatorDevice();

    // DeviceBase interface implementation
    void begin() override;
    void loop() override;
    JsonDocument getStatus() override;
    bool start(JsonDocument& params) override;
    bool stop() override;
    bool pause() override;
    bool resume() override;
    bool setSetpoint(uint8_t zone, float value) override;

    // Incubator-specific methods
    bool setEnvironmentParams(const EnvironmentControl::EnvironmentParams& params);
    EnvironmentControl::EnvironmentParams getEnvironmentParams() const;
    bool setTemperature(float temp);
    bool setHumidity(float humidity);
    bool setCO2(float co2);

private:
    EnvironmentControl envControl;

    // Update tracking
    unsigned long lastUpdate;
    unsigned long stabilityAchievedTime;
    bool wasStable;
    static const unsigned long UPDATE_INTERVAL = 100; // 100ms = 10 Hz

    // Helper methods
    void checkStabilityTransition();
};

#endif // INCUBATOR_DEVICE_H
