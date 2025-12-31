/**
 * mDNSService.cpp
 * mDNS service implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "mDNSService.h"
#include "../utils/Logger.h"
#include "../device/DeviceIdentity.h"

mDNSService::mDNSService(DeviceConfig& cfg)
    : config(cfg), started(false) {
}

bool mDNSService::begin() {
    if (!config.network.mdnsEnabled) {
        Logger::info("mDNSService: Disabled in configuration");
        return false;
    }

    Logger::info("mDNSService: Starting mDNS responder");

    // Start mDNS with hostname
    if (!MDNS.begin(config.network.mdnsName.c_str())) {
        Logger::error("mDNSService: Failed to start mDNS responder");
        return false;
    }

    Logger::info("mDNSService: Hostname: " + config.network.mdnsName + ".local");

    // Add service
    MDNS.addService("_axionyx", "_tcp", config.network.httpPort);
    Logger::info("mDNSService: Service registered: _axionyx._tcp on port " +
                String(config.network.httpPort));

    // Add TXT records with device information
    addTXTRecords();

    started = true;

    Logger::info("mDNSService: mDNS service started successfully");
    Logger::info("mDNSService: Access device at: http://" +
                config.network.mdnsName + ".local");

    return true;
}

void mDNSService::loop() {
    // mDNS requires periodic update calls (ESP32 Arduino core handles this internally)
    // Just check if we need to restart in case WiFi reconnected
}

void mDNSService::update() {
    if (!started || !config.network.mdnsEnabled) {
        return;
    }

    Logger::info("mDNSService: Updating TXT records");

    // Remove old service
    MDNS.end();

    // Restart with new settings
    begin();
}

void mDNSService::addTXTRecords() {
    // Add device information as TXT records
    MDNS.addServiceTxt("_axionyx", "_tcp", "type", config.device.type.c_str());
    MDNS.addServiceTxt("_axionyx", "_tcp", "version", config.device.firmwareVersion.c_str());
    MDNS.addServiceTxt("_axionyx", "_tcp", "serial", config.device.serialNumber.c_str());
    MDNS.addServiceTxt("_axionyx", "_tcp", "id", config.device.id.c_str());
    MDNS.addServiceTxt("_axionyx", "_tcp", "name", config.device.name.c_str());
    MDNS.addServiceTxt("_axionyx", "_tcp", "api", "/api/v1");
    MDNS.addServiceTxt("_axionyx", "_tcp", "ws", String(config.network.wsPort).c_str());
    MDNS.addServiceTxt("_axionyx", "_tcp", "mac", DeviceIdentity::getMAC().c_str());

    Logger::info("mDNSService: TXT records added");
}
