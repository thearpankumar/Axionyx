/**
 * pcr_demo.ino
 * Axionyx PCR Machine Demo Firmware
 * 3-zone thermal cycler with realistic PCR cycling
 *
 * ESP32-WROOM-32
 * Part of Axionyx Biotech IoT Platform
 */

#include "PCRDevice.h"
#include "../../../common/config/Config.h"
#include "../../../common/wifi/WiFiManager.h"
#include "../../../common/network/HTTPServer.h"
#include "../../../common/network/WebSocketServer.h"
#include "../../../common/device/DeviceIdentity.h"
#include "../../../common/utils/Logger.h"

// Global instances
DeviceConfig config;
WiFiManager wifiManager(config);
PCRDevice pcrDevice;
HTTPServer httpServer(config, pcrDevice, wifiManager);
WebSocketServer wsServer(pcrDevice);

void setup() {
    // Initialize serial communication
    Serial.begin(115200);
    delay(1000);

    Logger::setLevel(Logger::DEBUG);
    Logger::info("===========================================");
    Logger::info("Axionyx PCR Machine Demo");
    Logger::info("Firmware Version: " + DeviceIdentity::getFirmwareVersion());
    Logger::info("===========================================");

    // Initialize configuration
    if (!config.load()) {
        Logger::warning("No config found, using defaults");

        // Set device information
        config.device.type = "PCR";
        config.device.id = DeviceIdentity::getDeviceID("PCR");
        config.device.name = "Lab PCR #1";
        config.device.serialNumber = DeviceIdentity::generateSerialNumber("PCR");
        config.device.firmwareVersion = DeviceIdentity::getFirmwareVersion();

        // Set default WiFi configuration
        config.wifi.apSSID = DeviceIdentity::generateAPSSID("PCR");
        config.wifi.apPassword = "axionyx123";
        config.wifi.mode = DeviceConfig::AP_ONLY;

        // Set default network configuration
        config.network.httpPort = 80;
        config.network.wsPort = 81;
        config.network.mdnsEnabled = true;
        config.network.mdnsName = DeviceIdentity::generateMDNSName("PCR");

        // Save default configuration
        config.save();
    }

    // Display device information
    Logger::info("Device ID: " + config.device.id);
    Logger::info("Device Type: " + config.device.type);
    Logger::info("Device Name: " + config.device.name);
    Logger::info("Serial Number: " + config.device.serialNumber);
    Logger::info("AP SSID: " + config.wifi.apSSID);
    Logger::info("Chip ID: " + DeviceIdentity::getChipID());
    Logger::info("MAC Address: " + DeviceIdentity::getMAC());

    // Initialize PCR device
    pcrDevice.begin();
    Logger::info("PCR device initialized with 3 temperature zones");

    // Initialize WiFi
    wifiManager.begin();
    Logger::info("WiFi manager initialized");

    // Initialize HTTP server
    httpServer.begin();
    Logger::info("HTTP server initialized");

    // Initialize WebSocket server
    wsServer.begin(config.network.wsPort);
    Logger::info("WebSocket server initialized");

    Logger::info("===========================================");
    Logger::info("Setup complete!");
    Logger::info("Connect to WiFi: " + config.wifi.apSSID);
    Logger::info("Password: " + config.wifi.apPassword);
    Logger::info("HTTP API: http://192.168.4.1/api/v1/");
    Logger::info("WebSocket: ws://192.168.4.1:" + String(config.network.wsPort));
    Logger::info("===========================================");
    Logger::info("PCR Program Defaults:");
    Logger::info("  Cycles: 35");
    Logger::info("  Denature: 95°C for 30s");
    Logger::info("  Anneal: 60°C for 30s");
    Logger::info("  Extend: 72°C for 60s");
    Logger::info("===========================================");
}

void loop() {
    // Update WiFi manager
    wifiManager.loop();

    // Update PCR device
    pcrDevice.loop();

    // Update HTTP server
    httpServer.loop();

    // Update WebSocket server
    wsServer.loop();

    // Broadcast telemetry every second
    static unsigned long lastTelemetryBroadcast = 0;
    if (millis() - lastTelemetryBroadcast > 1000) {
        wsServer.broadcastTelemetry();
        lastTelemetryBroadcast = millis();
    }

    // Display status periodically
    static unsigned long lastStatusPrint = 0;
    if (millis() - lastStatusPrint > 10000) { // Every 10 seconds
        JsonDocument status = pcrDevice.getStatus();

        Logger::info("Status - WiFi: " + String(wifiManager.getState()) +
                    ", Device: " + pcrDevice.getStateString() +
                    ", Phase: " + status["currentPhase"].as<String>() +
                    ", Cycle: " + String(status["cycleNumber"].as<int>()) + "/" +
                    String(status["totalCycles"].as<int>()) +
                    ", Progress: " + String(status["progress"].as<float>(), 1) + "%");

        if (pcrDevice.getState() == DeviceBase::RUNNING) {
            Logger::info("Temperatures: [" +
                        String(status["temperature"][0].as<float>(), 1) + ", " +
                        String(status["temperature"][1].as<float>(), 1) + ", " +
                        String(status["temperature"][2].as<float>(), 1) + "] °C");
            Logger::info("Time remaining: " + String(status["totalTimeRemaining"].as<int>()) + "s");
        }

        if (wifiManager.isConnected()) {
            Logger::info("WiFi: " + wifiManager.getSSID() +
                        ", IP: " + wifiManager.getIP() +
                        ", RSSI: " + String(wifiManager.getRSSI()) + " dBm");
        }

        if (wifiManager.getAPClients() > 0) {
            Logger::info("AP Clients: " + String(wifiManager.getAPClients()));
        }

        Logger::info("Free Heap: " + String(DeviceIdentity::getFreeHeap()) + " bytes");

        lastStatusPrint = millis();
    }

    // Small delay to prevent watchdog reset
    delay(10);
}
