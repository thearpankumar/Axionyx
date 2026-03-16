/**
 * PCRDevice.h
 * PCR machine device - single heater + fan + NTC3950 sensor
 * ESP8266MOD hardware implementation
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef PCR_DEVICE_H
#define PCR_DEVICE_H

#include "../../common/device/DeviceBase.h"
#include "PCRCycler.h"

// ─── Hardware Pins ────────────────────────────────────────────────────────────
#define PIN_TEMP_SENSOR  A0   // NTC3950 analog input (10kΩ series resistor)
#define PIN_HEATER       14   // D5 = GPIO14 — ceramic cartridge via IRFZ44N (PWM)
#define PIN_FAN          12   // D6 = GPIO12 — fan via IRFZ44N (ON/OFF)

// ─── NTC3950 Thermistor Parameters ───────────────────────────────────────────
#define NTC_SERIES_R     10000.0f   // 10kΩ series resistor
#define NTC_NOMINAL_R    100000.0f  // 100kΩ resistance at 25°C
#define NTC_NOMINAL_T    25.0f      // Nominal temperature (°C)
#define NTC_BETA         3950.0f    // β coefficient

// ─── PID Parameters ───────────────────────────────────────────────────────────
// Tuned for ceramic cartridge heater — adjust if overshoot/undershoot is too large
#define PID_KP           50.0f
#define PID_KI           0.5f
#define PID_KD           20.0f
#define PID_INTEGRAL_MAX 200.0f   // Anti-windup clamp

class PCRDevice : public DeviceBase {
public:
    PCRDevice();

    // DeviceBase interface
    void begin()               override;
    void loop()                override;
    JsonDocument getStatus()   override;
    bool start(JsonDocument& params) override;
    bool stop()                override;
    bool pause()               override;
    bool resume()              override;
    bool setSetpoint(uint8_t zone, float value) override;

    // Diagnostic tests — called by POST /api/v1/device/test
    // Supported: {"component":"fan"}  →  fan runs for 10 s then auto-stops
    bool runTest(JsonDocument& params) override;

    // PCR-specific
    bool loadProgram(const PCRCycler::Program& program);
    PCRCycler::Program getCurrentProgram() const { return currentProgram; }

    // Live readings (accessible from status/telemetry)
    float getCurrentTemp()   const { return currentTemp; }
    float getTargetTemp()    const { return targetTemp; }
    bool  isHeaterOn()       const { return heaterOn; }
    bool  isFanOn()          const { return fanOn; }

private:
    PCRCycler          cycler;
    PCRCycler::Program currentProgram;

    // Temperature
    float currentTemp;   // °C, read from NTC3950
    float targetTemp;    // °C, from cycler phase

    // Hardware state
    bool heaterOn;
    bool fanOn;

    // PID state
    float pidIntegral;
    float pidPrevError;

    // Fan test state
    bool          testFanActive;
    unsigned long testFanEndTime;
    static const uint16_t TEST_FAN_DURATION_MS = 10000;  // 10 seconds

    // Timing
    unsigned long lastUpdate;
    unsigned long lastTempRead;
    static const unsigned long UPDATE_INTERVAL_MS = 100;  // 10 Hz
    static const unsigned long TEMP_READ_INTERVAL_MS = 50; // 20 Hz

    // Program metadata (name from app, included in status JSON)
    String currentProgramName;

    // Internal helpers
    float readTemperature();
    void  updatePID(float dt);
    void  setHeater(int pwmValue);   // 0-255
    void  setFan(bool on);
    void  allOff();
};

#endif // PCR_DEVICE_H
