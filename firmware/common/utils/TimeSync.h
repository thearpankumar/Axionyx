/**
 * TimeSync.h
 * NTP time synchronization
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef TIME_SYNC_H
#define TIME_SYNC_H

#include <Arduino.h>
#include <time.h>

class TimeSync {
public:
    TimeSync();

    bool begin(const char* ntpServer = "pool.ntp.org", long gmtOffset = 0, int daylightOffset = 0);
    void update();

    // Time retrieval
    time_t getEpochTime() const;
    String getTimeString() const;
    String getDateString() const;
    String getDateTimeString() const;
    bool isSynced() const { return synced; }

    // Configuration
    void setTimezone(long gmtOffset, int daylightOffset);

private:
    bool synced;
    long gmtOffsetSec;
    int daylightOffsetSec;
    const char* ntpServerName;
};

#endif // TIME_SYNC_H
