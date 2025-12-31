/**
 * TimeSync.cpp
 * NTP time synchronization implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "TimeSync.h"
#include "Logger.h"
#include <WiFi.h>

TimeSync::TimeSync()
    : synced(false),
      gmtOffsetSec(0),
      daylightOffsetSec(0),
      ntpServerName("pool.ntp.org") {
}

bool TimeSync::begin(const char* ntpServer, long gmtOffset, int daylightOffset) {
    Logger::info("TimeSync: Initializing NTP time synchronization");

    ntpServerName = ntpServer;
    gmtOffsetSec = gmtOffset;
    daylightOffsetSec = daylightOffset;

    // Configure time with NTP
    configTime(gmtOffsetSec, daylightOffsetSec, ntpServerName);

    Logger::info("TimeSync: NTP server: " + String(ntpServerName));
    Logger::info("TimeSync: GMT offset: " + String(gmtOffset / 3600) + " hours");

    // Wait for time to be set
    int retry = 0;
    const int maxRetries = 10;

    while (retry < maxRetries) {
        time_t now = time(nullptr);
        if (now > 1000000000) {  // Valid timestamp
            synced = true;
            Logger::info("TimeSync: Time synchronized successfully");
            Logger::info("TimeSync: Current time: " + getDateTimeString());
            return true;
        }

        delay(500);
        retry++;
    }

    Logger::warning("TimeSync: Failed to synchronize time");
    return false;
}

void TimeSync::update() {
    // NTP client runs automatically in ESP32 Arduino core
    // Just check if we're still synced
    time_t now = time(nullptr);
    if (now > 1000000000) {
        if (!synced) {
            Logger::info("TimeSync: Time synchronized");
            synced = true;
        }
    } else {
        if (synced) {
            Logger::warning("TimeSync: Lost time synchronization");
            synced = false;
        }
    }
}

time_t TimeSync::getEpochTime() const {
    return time(nullptr);
}

String TimeSync::getTimeString() const {
    if (!synced) {
        return "Not synced";
    }

    time_t now = time(nullptr);
    struct tm timeinfo;
    localtime_r(&now, &timeinfo);

    char buffer[9];
    strftime(buffer, sizeof(buffer), "%H:%M:%S", &timeinfo);

    return String(buffer);
}

String TimeSync::getDateString() const {
    if (!synced) {
        return "Not synced";
    }

    time_t now = time(nullptr);
    struct tm timeinfo;
    localtime_r(&now, &timeinfo);

    char buffer[11];
    strftime(buffer, sizeof(buffer), "%Y-%m-%d", &timeinfo);

    return String(buffer);
}

String TimeSync::getDateTimeString() const {
    if (!synced) {
        return "Not synced";
    }

    time_t now = time(nullptr);
    struct tm timeinfo;
    localtime_r(&now, &timeinfo);

    char buffer[20];
    strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S", &timeinfo);

    return String(buffer);
}

void TimeSync::setTimezone(long gmtOffset, int daylightOffset) {
    Logger::info("TimeSync: Updating timezone");

    gmtOffsetSec = gmtOffset;
    daylightOffsetSec = daylightOffset;

    configTime(gmtOffsetSec, daylightOffsetSec, ntpServerName);
}
