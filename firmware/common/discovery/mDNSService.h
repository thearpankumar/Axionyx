/**
 * mDNSService.h
 * mDNS service registration for device discovery
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef MDNS_SERVICE_H
#define MDNS_SERVICE_H

#include <Arduino.h>
#include <ESPmDNS.h>
#include <WiFiUdp.h>
#include "../config/Config.h"

class mDNSService {
public:
    mDNSService(DeviceConfig& config);

    bool begin();
    void loop();

private:
    DeviceConfig& config;
    bool started;
    WiFiUDP udp;

    void addTXTRecords();
};

#endif // MDNS_SERVICE_H
