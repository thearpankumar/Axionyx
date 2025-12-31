/**
 * PCRCycler.h
 * PCR thermal cycling state machine
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef PCR_CYCLER_H
#define PCR_CYCLER_H

#include <Arduino.h>

class PCRCycler {
public:
    // PCR cycle phases
    enum Phase {
        IDLE = 0,
        INITIAL_DENATURE = 1,
        DENATURE = 2,
        ANNEAL = 3,
        EXTEND = 4,
        FINAL_EXTEND = 5,
        HOLD = 6,
        COMPLETE = 7
    };

    // PCR program parameters
    struct Program {
        // Initial denaturation
        float initialDenatureTemp;
        uint16_t initialDenatureTime;

        // Cycling parameters
        uint16_t cycles;
        float denatureTemp;
        uint16_t denatureTime;
        float annealTemp;
        uint16_t annealTime;
        float extendTemp;
        uint16_t extendTime;

        // Final extension
        float finalExtendTemp;
        uint16_t finalExtendTime;

        // Hold
        float holdTemp;

        Program() :
            initialDenatureTemp(95.0),
            initialDenatureTime(180),  // 3 minutes
            cycles(35),
            denatureTemp(95.0),
            denatureTime(30),
            annealTemp(60.0),
            annealTime(30),
            extendTemp(72.0),
            extendTime(60),
            finalExtendTemp(72.0),
            finalExtendTime(300),  // 5 minutes
            holdTemp(4.0) {}
    };

    PCRCycler();

    // Control methods
    void start(const Program& program);
    void stop();
    void pause();
    void resume();
    void update(unsigned long now);

    // Status methods
    Phase getCurrentPhase() const { return currentPhase; }
    String getPhaseString() const;
    uint16_t getCurrentCycle() const { return currentCycle; }
    uint16_t getTotalCycles() const { return programParams.cycles; }
    uint16_t getPhaseTimeRemaining() const;
    uint16_t getTotalTimeRemaining() const;
    float getProgress() const;
    bool isRunning() const { return running && !paused; }
    bool isPaused() const { return paused; }
    bool isComplete() const { return currentPhase == COMPLETE; }

    // Temperature targets
    float getCurrentTargetTemp() const;

private:
    Program programParams;
    Phase currentPhase;
    uint16_t currentCycle;
    unsigned long phaseStartTime;
    unsigned long pauseStartTime;
    unsigned long totalPausedTime;
    bool running;
    bool paused;

    // Phase transitions
    void transitionToNextPhase();
    uint16_t getCurrentPhaseDuration() const;
    void calculateTotalTime();

    uint32_t totalProgramTime;  // Total time in seconds
};

#endif // PCR_CYCLER_H
