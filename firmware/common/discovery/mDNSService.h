/**
 * mDNSService.h
 * mDNS service registration for device discovery
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef MDNS_SERVICE_H
#define MDNS_SERVICE_H

#include <Arduino.h>
#include <ESPmDNS.h>
#include "../config/Config.h"

class mDNSService {
public:
    mDNSService(DeviceConfig& config);

    bool begin();
    void loop();
    void update();  // Update TXT records if config changes

private:
    DeviceConfig& config;
    bool started;

    void addTXTRecords();
};

#endif // MDNS_SERVICE_H
