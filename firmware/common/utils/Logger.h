/**
 * Logger.h
 * Serial logging utility for ESP32 firmware
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef LOGGER_H
#define LOGGER_H

#include <Arduino.h>

class Logger {
public:
    enum Level {
        DEBUG = 0,
        INFO = 1,
        WARNING = 2,
        ERROR = 3
    };

    static void setLevel(Level level) {
        currentLevel = level;
    }

    static void debug(const String& msg) {
        log(DEBUG, "DEBUG", msg);
    }

    static void info(const String& msg) {
        log(INFO, "INFO", msg);
    }

    static void warning(const String& msg) {
        log(WARNING, "WARNING", msg);
    }

    static void error(const String& msg) {
        log(ERROR, "ERROR", msg);
    }

private:
    static Level currentLevel;

    static void log(Level level, const char* levelStr, const String& msg) {
        if (level >= currentLevel) {
            unsigned long timestamp = millis();
            Serial.print("[");
            Serial.print(timestamp);
            Serial.print("] [");
            Serial.print(levelStr);
            Serial.print("] ");
            Serial.println(msg);
        }
    }
};

#endif // LOGGER_H
