/**
 * AlarmManager.h
 * Alarm system for environmental deviation monitoring
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef ALARM_MANAGER_H
#define ALARM_MANAGER_H

#include <Arduino.h>
#include <vector>
#include "../../../common/simulator/SensorSimulator.h"
#include "EnvironmentControl.h"

class AlarmManager {
public:
    // Alarm types
    enum AlarmType {
        TEMP_HIGH,
        TEMP_LOW,
        HUMIDITY_LOW,
        CO2_HIGH,
        CO2_LOW,
        DOOR_OPEN,
        POWER_FAILURE,
        SENSOR_FAULT
    };

    // Alarm severity levels
    enum AlarmSeverity {
        WARNING,      // Deviation detected but within acceptable range
        CRITICAL      // Immediate action required
    };

    // Alarm record
    struct Alarm {
        AlarmType type;
        AlarmSeverity severity;
        String message;
        uint32_t timestamp;
        bool active;
        bool acknowledged;
        float currentValue;
        float threshold;

        Alarm() :
            type(TEMP_HIGH),
            severity(WARNING),
            message(""),
            timestamp(0),
            active(false),
            acknowledged(false),
            currentValue(0.0),
            threshold(0.0) {}

        Alarm(AlarmType t, AlarmSeverity sev, const String& msg,
             float current, float thresh) :
            type(t),
            severity(sev),
            message(msg),
            timestamp(millis() / 1000),
            active(true),
            acknowledged(false),
            currentValue(current),
            threshold(thresh) {}
    };

    // Alarm thresholds configuration
    struct AlarmThresholds {
        float tempWarningHigh;
        float tempWarningLow;
        float tempCriticalHigh;
        float tempCriticalLow;
        float humidityWarningLow;
        float humidityCriticalLow;
        float co2WarningHigh;
        float co2WarningLow;
        float co2CriticalHigh;
        float co2CriticalLow;
        uint32_t doorOpenWarningTime;   // seconds
        uint32_t doorOpenCriticalTime;  // seconds

        AlarmThresholds() :
            tempWarningHigh(38.0),
            tempWarningLow(36.0),
            tempCriticalHigh(39.0),
            tempCriticalLow(35.0),
            humidityWarningLow(90.0),
            humidityCriticalLow(85.0),
            co2WarningHigh(5.3),
            co2WarningLow(4.7),
            co2CriticalHigh(5.5),
            co2CriticalLow(4.5),
            doorOpenWarningTime(30),
            doorOpenCriticalTime(120) {}
    };

    AlarmManager();

    // Configuration
    void setThresholds(const AlarmThresholds& thresholds);
    AlarmThresholds getThresholds() const { return thresholds; }

    // Alarm checking
    void checkAlarms(const EnvironmentControl::EnvironmentStatus& status,
                    float tempSetpoint, float humiditySetpoint, float co2Setpoint);

    // Alarm management
    void acknowledgeAlarm(uint8_t alarmIndex);
    void acknowledgeAll();
    void clearInactive();

    // Status queries
    std::vector<Alarm> getActiveAlarms() const;
    std::vector<Alarm> getAlarmHistory() const;
    uint8_t getActiveAlarmCount() const;
    bool hasActiveAlarms() const;
    bool hasCriticalAlarms() const;

    // Alarm history management
    void clearHistory();
    void setMaxHistorySize(uint16_t size) { maxHistorySize = size; }

private:
    AlarmThresholds thresholds;
    std::vector<Alarm> activeAlarms;
    std::vector<Alarm> alarmHistory;
    uint16_t maxHistorySize;

    // Debouncing - alarms must persist for this many consecutive checks
    static const uint8_t DEBOUNCE_COUNT = 3;
    uint8_t tempHighDebounce;
    uint8_t tempLowDebounce;
    uint8_t humidityLowDebounce;
    uint8_t co2HighDebounce;
    uint8_t co2LowDebounce;

    // Helper methods
    void raiseAlarm(AlarmType type, AlarmSeverity severity,
                   const String& message, float currentValue, float threshold);
    void clearAlarm(AlarmType type);
    bool isAlarmActive(AlarmType type) const;
    int findAlarmIndex(AlarmType type) const;
    String getAlarmTypeName(AlarmType type) const;
};

#endif // ALARM_MANAGER_H
