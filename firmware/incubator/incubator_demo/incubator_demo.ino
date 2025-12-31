/**
 * incubator_demo.ino
 * Axionyx Incubator Demo Firmware
 * Environmental control system (temperature, humidity, CO2)
 *
 * ESP32-WROOM-32
 * Part of Axionyx Biotech IoT Platform
 */

#include "IncubatorDevice.h"
#include "../../common/config/Config.h"
#include "../../common/wifi/WiFiManager.h"
#include "../../common/network/HTTPServer.h"
#include "../../common/network/WebSocketServer.h"
#include "../../common/device/DeviceIdentity.h"
#include "../../common/utils/Logger.h"

// Global instances
DeviceConfig config;
WiFiManager wifiManager(config);
IncubatorDevice incubatorDevice;
HTTPServer httpServer(config, incubatorDevice, wifiManager);
WebSocketServer wsServer(incubatorDevice);

void setup() {
    // Initialize serial communication
    Serial.begin(115200);
    delay(1000);

    Logger::setLevel(Logger::DEBUG);
    Logger::info("===========================================");
    Logger::info("Axionyx Incubator Demo");
    Logger::info("Firmware Version: " + DeviceIdentity::getFirmwareVersion());
    Logger::info("===========================================");

    // Initialize configuration
    if (!config.load()) {
        Logger::warning("No config found, using defaults");

        // Set device information
        config.device.type = "INCUBATOR";
        config.device.id = DeviceIdentity::getDeviceID("INCUBATOR");
        config.device.name = "Lab Incubator #1";
        config.device.serialNumber = DeviceIdentity::generateSerialNumber("INCUBATOR");
        config.device.firmwareVersion = DeviceIdentity::getFirmwareVersion();

        // Set default WiFi configuration
        config.wifi.apSSID = DeviceIdentity::generateAPSSID("INCUBATOR");
        config.wifi.apPassword = "axionyx123";
        config.wifi.mode = DeviceConfig::AP_ONLY;

        // Set default network configuration
        config.network.httpPort = 80;
        config.network.wsPort = 81;
        config.network.mdnsEnabled = true;
        config.network.mdnsName = DeviceIdentity::generateMDNSName("INCUBATOR");

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

    // Initialize incubator device
    incubatorDevice.begin();
    Logger::info("Incubator device initialized");

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
    Logger::info("Default Environment:");
    Logger::info("  Temperature: 37°C (cell culture standard)");
    Logger::info("  Humidity: 95%");
    Logger::info("  CO2: 5%");
    Logger::info("===========================================");
}

void loop() {
    // Update WiFi manager
    wifiManager.loop();

    // Update incubator device
    incubatorDevice.loop();

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
        JsonDocument status = incubatorDevice.getStatus();

        Logger::info("Status - WiFi: " + String(wifiManager.getState()) +
                    ", Device: " + incubatorDevice.getStateString());

        if (incubatorDevice.getState() == DeviceBase::RUNNING) {
            Logger::info("Environment: Temp=" +
                        String(status["temperature"].as<float>(), 1) + "°C (" +
                        String(status["temperatureSetpoint"].as<float>(), 1) + "°C), " +
                        "Humidity=" + String(status["humidity"].as<float>(), 1) + "% (" +
                        String(status["humiditySetpoint"].as<float>(), 1) + "%), " +
                        "CO2=" + String(status["co2Level"].as<float>(), 2) + "% (" +
                        String(status["co2Setpoint"].as<float>(), 1) + "%)");

            if (status["environmentStable"].as<bool>()) {
                Logger::info("Environment STABLE for " +
                            String(status["timeStable"].as<int>()) + " seconds");
            } else {
                String unstable = "Unstable: ";
                if (!status["temperatureStable"].as<bool>()) unstable += "Temp ";
                if (!status["humidityStable"].as<bool>()) unstable += "Humidity ";
                if (!status["co2Stable"].as<bool>()) unstable += "CO2";
                Logger::info(unstable);
            }
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
