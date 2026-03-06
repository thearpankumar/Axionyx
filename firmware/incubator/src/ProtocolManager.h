/**
 * ProtocolManager.h
 * Multi-stage protocol management for incubator
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef PROTOCOL_MANAGER_H
#define PROTOCOL_MANAGER_H

#include <Arduino.h>
#include <vector>

class ProtocolManager {
public:
    // Protocol types
    enum ProtocolType {
        MAMMALIAN_CULTURE,      // 37°C, 95% RH, 5% CO2
        BACTERIAL_CULTURE,      // 37°C, variable RH, 5% CO2
        YEAST_CULTURE,          // 30°C, variable RH
        DECONTAMINATION,        // 65°C cleaning cycle
        CUSTOM_PROTOCOL
    };

    // Protocol stage definition
    struct ProtocolStage {
        String name;
        float temperature;
        float humidity;
        float co2Level;
        uint32_t duration;      // seconds (0 = indefinite)
        bool rampToTarget;      // Gradual transition vs instant
        uint16_t rampTime;      // Ramp duration in seconds

        ProtocolStage() :
            name(""),
            temperature(25.0),
            humidity(50.0),
            co2Level(0.04),
            duration(0),
            rampToTarget(false),
            rampTime(0) {}

        ProtocolStage(const String& n, float temp, float hum, float co2,
                     uint32_t dur = 0, bool ramp = false, uint16_t rampT = 0) :
            name(n), temperature(temp), humidity(hum), co2Level(co2),
            duration(dur), rampToTarget(ramp), rampTime(rampT) {}
    };

    // Complete protocol definition
    struct Protocol {
        ProtocolType type;
        String name;
        String description;
        std::vector<ProtocolStage> stages;
        uint8_t currentStage;
        uint32_t stageStartTime;

        // Alarm settings
        float tempAlarmHigh;
        float tempAlarmLow;
        float humidityAlarmLow;
        float co2AlarmHigh;
        float co2AlarmLow;

        Protocol() :
            type(CUSTOM_PROTOCOL),
            name(""),
            description(""),
            currentStage(0),
            stageStartTime(0),
            tempAlarmHigh(40.0),
            tempAlarmLow(35.0),
            humidityAlarmLow(85.0),
            co2AlarmHigh(5.5),
            co2AlarmLow(4.5) {}
    };

    // Protocol manager state
    enum State {
        IDLE,
        PREHEATING,
        RUNNING,
        PAUSED,
        COMPLETE
    };

    ProtocolManager();

    // Control methods
    void startProtocol(const Protocol& protocol);
    void stopProtocol();
    void pauseProtocol();
    void resumeProtocol();
    void nextStage();  // Manual stage advancement
    void update(uint32_t now);

    // Status methods
    State getState() const { return currentState; }
    String getStateString() const;
    Protocol& getCurrentProtocol() { return currentProtocol; }
    const Protocol& getCurrentProtocol() const { return currentProtocol; }
    ProtocolStage getCurrentStage() const;
    uint8_t getCurrentStageNumber() const { return currentProtocol.currentStage; }
    uint8_t getTotalStages() const { return currentProtocol.stages.size(); }
    uint32_t getStageTimeRemaining() const;
    float getProgress() const;
    bool isRunning() const { return currentState == RUNNING; }
    bool isPaused() const { return currentState == PAUSED; }
    bool isComplete() const { return currentState == COMPLETE; }

private:
    Protocol currentProtocol;
    State currentState;
    uint32_t pauseStartTime;
    uint32_t totalPausedTime;

    void transitionToNextStage();
    uint32_t getStageElapsedTime(uint32_t now) const;
};

#endif // PROTOCOL_MANAGER_H
