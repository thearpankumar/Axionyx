/**
 * dummy_demo.ino
 * Axionyx Dummy Device Demo Firmware
 * Minimal test device for WiFi/API testing
 *
 * ESP32-WROOM-32
 * Part of Axionyx Biotech IoT Platform
 */

#include "DummyDevice.h"
#include "../../common/config/Config.h"
#include "../../common/wifi/WiFiManager.h"
#include "../../common/network/HTTPServer.h"
#include "../../common/network/WebSocketServer.h"
#include "../../common/device/DeviceIdentity.h"
#include "../../common/utils/Logger.h"

// Global instances
DeviceConfig config;
WiFiManager wifiManager(config);
DummyDevice dummyDevice;
HTTPServer httpServer(config, dummyDevice, wifiManager);
WebSocketServer wsServer(dummyDevice);

void setup() {
    // Initialize serial communication
    Serial.begin(115200);
    delay(1000);

    Logger::setLevel(Logger::DEBUG);
    Logger::info("===========================================");
    Logger::info("Axionyx Dummy Device Demo");
    Logger::info("Firmware Version: " + DeviceIdentity::getFirmwareVersion());
    Logger::info("===========================================");

    // Initialize configuration
    if (!config.load()) {
        Logger::warning("No config found, using defaults");

        // Set device information
        config.device.type = "DUMMY";
        config.device.id = DeviceIdentity::getDeviceID("DUMMY");
        config.device.name = "Test Device";
        config.device.serialNumber = DeviceIdentity::generateSerialNumber("DUMMY");
        config.device.firmwareVersion = DeviceIdentity::getFirmwareVersion();

        // Set default WiFi configuration
        config.wifi.apSSID = DeviceIdentity::generateAPSSID("DUMMY");
        config.wifi.apPassword = "axionyx123";
        config.wifi.mode = DeviceConfig::AP_ONLY;

        // Set default network configuration
        config.network.httpPort = 80;
        config.network.wsPort = 81;
        config.network.mdnsEnabled = true;
        config.network.mdnsName = DeviceIdentity::generateMDNSName("DUMMY");

        // Save default configuration
        config.save();
    }

    // Display device information
    Logger::info("Device ID: " + config.device.id);
    Logger::info("Device Type: " + config.device.type);
    Logger::info("Serial Number: " + config.device.serialNumber);
    Logger::info("AP SSID: " + config.wifi.apSSID);
    Logger::info("Chip ID: " + DeviceIdentity::getChipID());
    Logger::info("MAC Address: " + DeviceIdentity::getMAC());

    // Initialize device
    dummyDevice.begin();
    Logger::info("Device initialized");

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
}

void loop() {
    // Update WiFi manager
    wifiManager.loop();

    // Update device
    dummyDevice.loop();

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
        Logger::info("Status - WiFi State: " + String(wifiManager.getState()) +
                    ", Device State: " + dummyDevice.getStateString() +
                    ", Temp: " + String(dummyDevice.getStatus()["temperature"].as<float>(), 1) + "°C" +
                    ", Free Heap: " + String(DeviceIdentity::getFreeHeap()));

        if (wifiManager.isConnected()) {
            Logger::info("Connected to: " + wifiManager.getSSID() +
                        ", IP: " + wifiManager.getIP() +
                        ", RSSI: " + String(wifiManager.getRSSI()) + " dBm");
        }

        if (wifiManager.getAPClients() > 0) {
            Logger::info("AP Clients: " + String(wifiManager.getAPClients()));
        }

        lastStatusPrint = millis();
    }

    // Small delay to prevent watchdog reset
    delay(10);
}
