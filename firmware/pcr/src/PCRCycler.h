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
    // PCR program types
    enum ProgramType {
        STANDARD_PCR,
        GRADIENT_PCR,
        TOUCHDOWN_PCR,
        TWOSTEP_PCR
    };

    // PCR cycle phases
    enum Phase {
        IDLE = 0,
        HOT_START = 1,              // Hot start enzyme activation
        INITIAL_DENATURE = 2,
        DENATURE = 3,
        ANNEAL = 4,
        EXTEND = 5,
        ANNEAL_EXTEND = 6,          // Combined anneal+extend for two-step PCR
        FINAL_EXTEND = 7,
        HOLD = 8,
        COMPLETE = 9
    };

    // Gradient PCR configuration
    struct GradientConfig {
        bool enabled;
        float tempLow;       // Lowest temperature in gradient
        float tempHigh;      // Highest temperature in gradient
        uint8_t positions;   // Number of gradient positions (e.g., 12)

        GradientConfig() :
            enabled(false),
            tempLow(55.0),
            tempHigh(65.0),
            positions(12) {}
    };

    // Touchdown PCR configuration
    struct TouchdownConfig {
        bool enabled;
        float startAnnealTemp;   // Starting annealing temperature
        float endAnnealTemp;     // Final annealing temperature
        float stepSize;          // Temperature decrease per cycle
        uint16_t touchdownCycles; // Number of cycles for touchdown

        TouchdownConfig() :
            enabled(false),
            startAnnealTemp(72.0),
            endAnnealTemp(60.0),
            stepSize(1.0),
            touchdownCycles(12) {}
    };

    // Hot start configuration
    struct HotStartConfig {
        bool enabled;
        float activationTemp;    // Enzyme activation temperature
        uint16_t activationTime; // Activation time in seconds

        HotStartConfig() :
            enabled(false),
            activationTemp(95.0),
            activationTime(600) {}  // 10 minutes default
    };

    // PCR program parameters
    struct Program {
        ProgramType type;

        // Hot start
        HotStartConfig hotStart;

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

        // Two-step PCR
        bool twoStepEnabled;
        float annealExtendTemp;      // Combined temperature for two-step
        uint16_t annealExtendTime;   // Combined time for two-step

        // Final extension
        float finalExtendTemp;
        uint16_t finalExtendTime;

        // Hold
        float holdTemp;

        // Gradient PCR
        GradientConfig gradient;

        // Touchdown PCR
        TouchdownConfig touchdown;

        Program() :
            type(STANDARD_PCR),
            initialDenatureTemp(95.0),
            initialDenatureTime(180),  // 3 minutes
            cycles(35),
            denatureTemp(95.0),
            denatureTime(30),
            annealTemp(60.0),
            annealTime(30),
            extendTemp(72.0),
            extendTime(60),
            twoStepEnabled(false),
            annealExtendTemp(65.0),
            annealExtendTime(45),
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

    // Advanced feature calculations
    float calculateTouchdownTemp() const;
    float calculateGradientTemp(uint8_t position) const;
    float getCurrentAnnealTemp() const;  // Returns actual anneal temp (touchdown or standard)

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
