/**
 * AlarmManager.cpp
 * Alarm system implementation for environmental deviation monitoring
 * Part of Axionyx Biotech IoT Platform
 */

#include "AlarmManager.h"
#include "../../../common/utils/Logger.h"

AlarmManager::AlarmManager()
    : maxHistorySize(100),
      tempHighDebounce(0),
      tempLowDebounce(0),
      humidityLowDebounce(0),
      co2HighDebounce(0),
      co2LowDebounce(0) {
}

void AlarmManager::setThresholds(const AlarmThresholds& newThresholds) {
    thresholds = newThresholds;
    Logger::info("AlarmManager: Thresholds updated");
}

void AlarmManager::checkAlarms(const EnvironmentControl::EnvironmentStatus& status,
                              float tempSetpoint, float humiditySetpoint, float co2Setpoint) {
    float tempDev = abs(status.currentTemperature - tempSetpoint);
    float humidityDev = status.currentHumidity - humiditySetpoint;
    float co2Dev = abs(status.currentCO2 - co2Setpoint);

    // Temperature High Alarms
    if (status.currentTemperature > thresholds.tempCriticalHigh) {
        tempHighDebounce++;
        if (tempHighDebounce >= DEBOUNCE_COUNT && !isAlarmActive(TEMP_HIGH)) {
            raiseAlarm(TEMP_HIGH, CRITICAL,
                      "Critical: Temperature exceeds maximum",
                      status.currentTemperature, thresholds.tempCriticalHigh);
        }
    } else if (status.currentTemperature > thresholds.tempWarningHigh) {
        tempHighDebounce++;
        if (tempHighDebounce >= DEBOUNCE_COUNT && !isAlarmActive(TEMP_HIGH)) {
            raiseAlarm(TEMP_HIGH, WARNING,
                      "Warning: Temperature above setpoint",
                      status.currentTemperature, thresholds.tempWarningHigh);
        }
    } else {
        tempHighDebounce = 0;
        if (isAlarmActive(TEMP_HIGH)) {
            clearAlarm(TEMP_HIGH);
        }
    }

    // Temperature Low Alarms
    if (status.currentTemperature < thresholds.tempCriticalLow) {
        tempLowDebounce++;
        if (tempLowDebounce >= DEBOUNCE_COUNT && !isAlarmActive(TEMP_LOW)) {
            raiseAlarm(TEMP_LOW, CRITICAL,
                      "Critical: Temperature below minimum",
                      status.currentTemperature, thresholds.tempCriticalLow);
        }
    } else if (status.currentTemperature < thresholds.tempWarningLow) {
        tempLowDebounce++;
        if (tempLowDebounce >= DEBOUNCE_COUNT && !isAlarmActive(TEMP_LOW)) {
            raiseAlarm(TEMP_LOW, WARNING,
                      "Warning: Temperature below setpoint",
                      status.currentTemperature, thresholds.tempWarningLow);
        }
    } else {
        tempLowDebounce = 0;
        if (isAlarmActive(TEMP_LOW)) {
            clearAlarm(TEMP_LOW);
        }
    }

    // Humidity Low Alarms
    if (status.currentHumidity < thresholds.humidityCriticalLow) {
        humidityLowDebounce++;
        if (humidityLowDebounce >= DEBOUNCE_COUNT && !isAlarmActive(HUMIDITY_LOW)) {
            raiseAlarm(HUMIDITY_LOW, CRITICAL,
                      "Critical: Humidity critically low",
                      status.currentHumidity, thresholds.humidityCriticalLow);
        }
    } else if (status.currentHumidity < thresholds.humidityWarningLow) {
        humidityLowDebounce++;
        if (humidityLowDebounce >= DEBOUNCE_COUNT && !isAlarmActive(HUMIDITY_LOW)) {
            raiseAlarm(HUMIDITY_LOW, WARNING,
                      "Warning: Humidity below setpoint",
                      status.currentHumidity, thresholds.humidityWarningLow);
        }
    } else {
        humidityLowDebounce = 0;
        if (isAlarmActive(HUMIDITY_LOW)) {
            clearAlarm(HUMIDITY_LOW);
        }
    }

    // CO2 High Alarms
    if (status.currentCO2 > thresholds.co2CriticalHigh) {
        co2HighDebounce++;
        if (co2HighDebounce >= DEBOUNCE_COUNT && !isAlarmActive(CO2_HIGH)) {
            raiseAlarm(CO2_HIGH, CRITICAL,
                      "Critical: CO2 level too high",
                      status.currentCO2, thresholds.co2CriticalHigh);
        }
    } else if (status.currentCO2 > thresholds.co2WarningHigh) {
        co2HighDebounce++;
        if (co2HighDebounce >= DEBOUNCE_COUNT && !isAlarmActive(CO2_HIGH)) {
            raiseAlarm(CO2_HIGH, WARNING,
                      "Warning: CO2 level above setpoint",
                      status.currentCO2, thresholds.co2WarningHigh);
        }
    } else {
        co2HighDebounce = 0;
        if (isAlarmActive(CO2_HIGH)) {
            clearAlarm(CO2_HIGH);
        }
    }

    // CO2 Low Alarms
    if (status.currentCO2 < thresholds.co2CriticalLow) {
        co2LowDebounce++;
        if (co2LowDebounce >= DEBOUNCE_COUNT && !isAlarmActive(CO2_LOW)) {
            raiseAlarm(CO2_LOW, CRITICAL,
                      "Critical: CO2 level too low",
                      status.currentCO2, thresholds.co2CriticalLow);
        }
    } else if (status.currentCO2 < thresholds.co2WarningLow) {
        co2LowDebounce++;
        if (co2LowDebounce >= DEBOUNCE_COUNT && !isAlarmActive(CO2_LOW)) {
            raiseAlarm(CO2_LOW, WARNING,
                      "Warning: CO2 level below setpoint",
                      status.currentCO2, thresholds.co2WarningLow);
        }
    } else {
        co2LowDebounce = 0;
        if (isAlarmActive(CO2_LOW)) {
            clearAlarm(CO2_LOW);
        }
    }
}

void AlarmManager::raiseAlarm(AlarmType type, AlarmSeverity severity,
                             const String& message, float currentValue, float threshold) {
    // Check if alarm already exists
    int existingIndex = findAlarmIndex(type);
    if (existingIndex >= 0) {
        // Update existing alarm
        activeAlarms[existingIndex].severity = severity;
        activeAlarms[existingIndex].currentValue = currentValue;
        activeAlarms[existingIndex].threshold = threshold;
        activeAlarms[existingIndex].timestamp = millis() / 1000;
    } else {
        // Create new alarm
        Alarm alarm(type, severity, message, currentValue, threshold);
        activeAlarms.push_back(alarm);

        String severityStr = (severity == CRITICAL) ? "CRITICAL" : "WARNING";
        Logger::error("AlarmManager: " + severityStr + " - " + message +
                     " (Current: " + String(currentValue, 2) +
                     ", Threshold: " + String(threshold, 2) + ")");
    }
}

void AlarmManager::clearAlarm(AlarmType type) {
    int index = findAlarmIndex(type);
    if (index >= 0) {
        // Move to history before removing
        Alarm clearedAlarm = activeAlarms[index];
        clearedAlarm.active = false;
        alarmHistory.push_back(clearedAlarm);

        // Limit history size
        while (alarmHistory.size() > maxHistorySize) {
            alarmHistory.erase(alarmHistory.begin());
        }

        // Remove from active alarms
        activeAlarms.erase(activeAlarms.begin() + index);

        Logger::info("AlarmManager: Alarm cleared - " + getAlarmTypeName(type));
    }
}

bool AlarmManager::isAlarmActive(AlarmType type) const {
    return findAlarmIndex(type) >= 0;
}

int AlarmManager::findAlarmIndex(AlarmType type) const {
    for (size_t i = 0; i < activeAlarms.size(); i++) {
        if (activeAlarms[i].type == type) {
            return i;
        }
    }
    return -1;
}

String AlarmManager::getAlarmTypeName(AlarmType type) const {
    switch (type) {
        case TEMP_HIGH: return "Temperature High";
        case TEMP_LOW: return "Temperature Low";
        case HUMIDITY_LOW: return "Humidity Low";
        case CO2_HIGH: return "CO2 High";
        case CO2_LOW: return "CO2 Low";
        case DOOR_OPEN: return "Door Open";
        case POWER_FAILURE: return "Power Failure";
        case SENSOR_FAULT: return "Sensor Fault";
        default: return "Unknown";
    }
}

void AlarmManager::acknowledgeAlarm(uint8_t alarmIndex) {
    if (alarmIndex < activeAlarms.size()) {
        activeAlarms[alarmIndex].acknowledged = true;
        Logger::info("AlarmManager: Alarm acknowledged - " +
                    getAlarmTypeName(activeAlarms[alarmIndex].type));
    }
}

void AlarmManager::acknowledgeAll() {
    for (auto& alarm : activeAlarms) {
        alarm.acknowledged = true;
    }
    if (activeAlarms.size() > 0) {
        Logger::info("AlarmManager: All " + String(activeAlarms.size()) +
                    " active alarms acknowledged");
    }
}

void AlarmManager::clearInactive() {
    // Move inactive alarms to history
    auto it = activeAlarms.begin();
    while (it != activeAlarms.end()) {
        if (!it->active) {
            alarmHistory.push_back(*it);
            it = activeAlarms.erase(it);
        } else {
            ++it;
        }
    }

    // Limit history size
    while (alarmHistory.size() > maxHistorySize) {
        alarmHistory.erase(alarmHistory.begin());
    }
}

std::vector<AlarmManager::Alarm> AlarmManager::getActiveAlarms() const {
    return activeAlarms;
}

std::vector<AlarmManager::Alarm> AlarmManager::getAlarmHistory() const {
    return alarmHistory;
}

uint8_t AlarmManager::getActiveAlarmCount() const {
    return activeAlarms.size();
}

bool AlarmManager::hasActiveAlarms() const {
    return !activeAlarms.empty();
}

bool AlarmManager::hasCriticalAlarms() const {
    for (const auto& alarm : activeAlarms) {
        if (alarm.severity == CRITICAL) {
            return true;
        }
    }
    return false;
}

void AlarmManager::clearHistory() {
    alarmHistory.clear();
    Logger::info("AlarmManager: Alarm history cleared");
}
