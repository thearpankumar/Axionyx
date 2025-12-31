/**
 * DeviceBase.h
 * Abstract base class for all device types
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef DEVICE_BASE_H
#define DEVICE_BASE_H

#include <Arduino.h>
#include <ArduinoJson.h>

class DeviceBase {
public:
    // Device operational states
    enum State {
        IDLE = 0,       // Device is idle, ready to start
        STARTING = 1,   // Device is starting up
        RUNNING = 2,    // Device is actively running
        PAUSED = 3,     // Device is paused
        STOPPING = 4,   // Device is stopping
        ERROR = 5       // Device encountered an error
    };

    virtual ~DeviceBase() = default;

    // Pure virtual methods - must be implemented by device-specific classes
    virtual void begin() = 0;
    virtual void loop() = 0;
    virtual JsonDocument getStatus() = 0;
    virtual bool start(JsonDocument& params) = 0;
    virtual bool stop() = 0;
    virtual bool pause() = 0;
    virtual bool resume() = 0;
    virtual bool setSetpoint(uint8_t zone, float value) = 0;

    // Common functionality
    State getState() const {
        return state;
    }

    String getStateString() const {
        switch (state) {
            case IDLE:     return "IDLE";
            case STARTING: return "STARTING";
            case RUNNING:  return "RUNNING";
            case PAUSED:   return "PAUSED";
            case STOPPING: return "STOPPING";
            case ERROR:    return "ERROR";
            default:       return "UNKNOWN";
        }
    }

    unsigned long getUptime() const {
        if (startTime == 0) return 0;
        return (millis() - startTime) / 1000; // Return uptime in seconds
    }

protected:
    State state = IDLE;
    unsigned long startTime = 0;

    void setState(State newState) {
        state = newState;
        if (newState == RUNNING && startTime == 0) {
            startTime = millis();
        } else if (newState == IDLE || newState == ERROR) {
            startTime = 0;
        }
    }
};

#endif // DEVICE_BASE_H
