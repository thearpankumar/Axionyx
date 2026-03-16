/**
 * mDNSService.h
 * mDNS service registration for device discovery
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef MDNS_SERVICE_H
#define MDNS_SERVICE_H

#include <Arduino.h>
#ifdef ESP32
  #include <ESPmDNS.h>
  #include <WiFiUdp.h>
#else
  #include <ESP8266mDNS.h>
  #include <WiFiUdp.h>
#endif
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
