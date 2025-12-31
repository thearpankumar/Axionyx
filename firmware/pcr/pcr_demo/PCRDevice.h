/**
 * PCRDevice.h
 * PCR machine device implementation
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef PCR_DEVICE_H
#define PCR_DEVICE_H

#include "../../common/device/DeviceBase.h"
#include "../../common/simulator/SensorSimulator.h"
#include "PCRCycler.h"

class PCRDevice : public DeviceBase {
public:
    static const uint8_t NUM_ZONES = 3;  // Denaturation, annealing, extension zones

    PCRDevice();

    // DeviceBase interface implementation
    void begin() override;
    void loop() override;
    JsonDocument getStatus() override;
    bool start(JsonDocument& params) override;
    bool stop() override;
    bool pause() override;
    bool resume() override;
    bool setSetpoint(uint8_t zone, float value) override;

    // PCR-specific methods
    bool loadProgram(const PCRCycler::Program& program);
    PCRCycler::Program getCurrentProgram() const { return currentProgram; }

private:
    // Temperature zones
    TemperatureSimulator tempZones[NUM_ZONES];

    // PCR cycling control
    PCRCycler cycler;
    PCRCycler::Program currentProgram;

    // Update tracking
    unsigned long lastUpdate;
    static const unsigned long UPDATE_INTERVAL = 100; // 100ms = 10 Hz

    // Helper methods
    void updateTemperatures(float dt);
    void syncTemperaturesToCycler();
    String getZoneName(uint8_t zone) const;
};

#endif // PCR_DEVICE_H
