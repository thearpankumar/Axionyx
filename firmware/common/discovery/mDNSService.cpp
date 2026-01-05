/**
 * mDNSService.cpp
 * mDNS service implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "mDNSService.h"
#include <WiFi.h>
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

    // Disable WiFi sleep for discovery reliability (research-backed fix)
    WiFi.setSleep(false);

    // Start mDNS with hostname
    if (!MDNS.begin(config.network.mdnsName.c_str())) {
        Logger::error("mDNSService: Failed to start mDNS responder");
        return false;
    }

    Logger::info("mDNSService: Hostname: " + config.network.mdnsName + ".local");

    // Add services (Standard underscores for maximum compatibility)
    MDNS.addService("_axionyx", "_tcp", config.network.httpPort);
    MDNS.addService("_http", "_tcp", config.network.httpPort);
    
    Logger::info("mDNSService: Services registered: _axionyx._tcp and _http._tcp on port " +
                String(config.network.httpPort));

    // Add TXT records with device information
    addTXTRecords();

    // Start UDP responder for discovery fallback
    udp.begin(30303);
    Logger::info("mDNSService: UDP discovery responder started on port 30303");

    started = true;

    Logger::info("mDNSService: mDNS and UDP services started successfully");
    Logger::info("mDNSService: Access device at: http://" +
                config.network.mdnsName + ".local");

    return true;
}

void mDNSService::loop() {
    if (!started) return;

    // --- UDP DISCOVERY RESPONDER ---
    int packetSize = udp.parsePacket();
    if (packetSize) {
        char packetBuffer[255];
        int len = udp.read(packetBuffer, 255);
        if (len > 0) {
            packetBuffer[len] = 0;
        }

        String request = String(packetBuffer);
        // Simple search for the discovery command to avoid heavy JSON parsing
        if (request.indexOf("\"cmd\":\"DISCOVER\"") != -1 && request.indexOf("\"app\":\"axionyx\"") != -1) {
            Logger::info("mDNSService: Received UDP discovery request from " + udp.remoteIP().toString());

            // Prepare response payload
            String response = "{";
            response += "\"type\":\"DISCOVER_REPLY\",";
            response += "\"id\":\"" + config.device.id + "\",";
            response += "\"name\":\"" + config.device.name + "\",";
            response += "\"device_type\":\"" + config.device.type + "\",";
            response += "\"ip\":\"" + WiFi.localIP().toString() + "\",";
            response += "\"http_port\":" + String(config.network.httpPort) + ",";
            response += "\"ws_port\":" + String(config.network.wsPort) + ",";
            response += "\"version\":\"" + config.device.firmwareVersion + "\",";
            response += "\"mac\":\"" + DeviceIdentity::getMAC() + "\"";
            response += "}";

            udp.beginPacket(udp.remoteIP(), udp.remotePort());
            udp.write((const uint8_t*)response.c_str(), response.length());
            udp.endPacket();
            
            Logger::info("mDNSService: Sent UDP discovery reply");
        }
    }

    // --- PERIODIC HEARTBEAT (Re-announce every 60s) ---
    static unsigned long lastHeartbeat = 0;
    if (millis() - lastHeartbeat > 60000) {
        lastHeartbeat = millis();
        Logger::info("mDNSService: Running heartbeat (refreshing records)");
        
        // Reset and re-register
        MDNS.end();
        if (MDNS.begin(config.network.mdnsName.c_str())) {
            addTXTRecords();
            MDNS.addService("_axionyx", "_tcp", config.network.httpPort);
            MDNS.addService("_http", "_tcp", config.network.httpPort);
        }
    }
}



void mDNSService::addTXTRecords() {
    // Add device information as TXT records
    // Add device information as TXT records to both services
    const char* serviceNames[] = {"_axionyx", "_http"};
    for (const char* service : serviceNames) {
        MDNS.addServiceTxt(service, "_tcp", "type", config.device.type.c_str());
        MDNS.addServiceTxt(service, "_tcp", "version", config.device.firmwareVersion.c_str());
        MDNS.addServiceTxt(service, "_tcp", "serial", config.device.serialNumber.c_str());
        MDNS.addServiceTxt(service, "_tcp", "id", config.device.id.c_str());
        MDNS.addServiceTxt(service, "_tcp", "name", config.device.name.c_str());
        MDNS.addServiceTxt(service, "_tcp", "api", "/api/v1");
        MDNS.addServiceTxt(service, "_tcp", "ws", String(config.network.wsPort).c_str());
        MDNS.addServiceTxt(service, "_tcp", "mac", DeviceIdentity::getMAC().c_str());
    }

    Logger::info("mDNSService: TXT records added");
}
