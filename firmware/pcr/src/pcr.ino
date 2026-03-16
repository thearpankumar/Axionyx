/**
 * pcr.ino
 * Axionyx PCR Machine Firmware
 * ESP8266MOD — single heater (D5) + fan (D6) + NTC3950 (A0)
 * Part of Axionyx Biotech IoT Platform
 */

#include "PCRDevice.h"
#include "../../common/config/Config.h"
#include "../../common/wifi/WiFiManager.h"
#include "../../common/network/HTTPServer.h"
#include "../../common/network/WebSocketServer.h"
#include "../../common/discovery/mDNSService.h"
#include "../../common/device/DeviceIdentity.h"
#include "../../common/utils/Logger.h"

#define PIN_LED  2   // GPIO2 / D4 — NodeMCU v2 onboard LED (active LOW)

// Global instances
DeviceConfig    config;
WiFiManager     wifiManager(config);
PCRDevice       pcrDevice;
HTTPServer      httpServer(config, pcrDevice, wifiManager);
WebSocketServer wsServer(pcrDevice);
mDNSService     mdnsService(config);

void setup() {
    pinMode(PIN_LED, OUTPUT);
    digitalWrite(PIN_LED, HIGH);  // LED off until WiFi is up (active LOW)

    Serial.begin(115200);
    delay(1000);

    Logger::setLevel(Logger::DEBUG);
    Logger::info("===========================================");
    Logger::info("Axionyx PCR Machine");
    Logger::info("Hardware: ESP8266MOD");
    Logger::info("Firmware: " + DeviceIdentity::getFirmwareVersion());
    Logger::info("===========================================");

    // Load or initialise configuration
    if (!config.load()) {
        Logger::warning("No config found, using defaults");

        config.device.type           = "PCR";
        config.device.id             = DeviceIdentity::getDeviceID("PCR");
        config.device.name           = "Lab PCR #1";
        config.device.serialNumber   = DeviceIdentity::generateSerialNumber("PCR");
        config.device.firmwareVersion = DeviceIdentity::getFirmwareVersion();

        config.wifi.apSSID           = DeviceIdentity::generateAPSSID("PCR");
        config.wifi.apPassword       = "axionyx123";
        config.wifi.mode             = DeviceConfig::AP_ONLY;

        config.network.httpPort      = 80;
        config.network.wsPort        = 81;
        config.network.mdnsEnabled   = true;
        config.network.mdnsName      = DeviceIdentity::generateMDNSName("PCR");

        config.save();
    }

    Logger::info("Device ID:   " + config.device.id);
    Logger::info("Device Name: " + config.device.name);
    Logger::info("AP SSID:     " + config.wifi.apSSID);
    Logger::info("MAC:         " + DeviceIdentity::getMAC());

    // Boot hardware
    pcrDevice.begin();
    Logger::info("PCR device ready");

    wifiManager.begin();
    wifiManager.setMDNSService(&mdnsService);
    Logger::info("WiFi manager started");

    httpServer.begin();
    Logger::info("HTTP server on port " + String(config.network.httpPort));

    wsServer.begin(config.network.wsPort);
    Logger::info("WebSocket server on port " + String(config.network.wsPort));

    Logger::info("===========================================");
    Logger::info("Connect to WiFi: " + config.wifi.apSSID);
    Logger::info("Password: "        + config.wifi.apPassword);
    Logger::info("AP IP:  192.168.4.1");
    Logger::info("API:  http://192.168.4.1/api/v1/");
    Logger::info("WS:   ws://192.168.4.1:" + String(config.network.wsPort));
    Logger::info("---");
    Logger::info("Default PCR program:");
    Logger::info("  Initial denature: 70°C x 3 min");
    Logger::info("  35 cycles — denature: 70°C/30s  anneal: 50°C/30s  extend: 70°C/60s");
    Logger::info("  Final extend: 70°C x 5 min");
    Logger::info("===========================================");
}

void loop() {
    wifiManager.loop();
    pcrDevice.loop();
    httpServer.loop();
    wsServer.loop();
    mdnsService.loop();

    // Broadcast telemetry every second
    static unsigned long lastTelemetry = 0;
    if (millis() - lastTelemetry >= 1000) {
        wsServer.broadcastTelemetry();
        lastTelemetry = millis();
    }

    // Serial status every 10 seconds
    static unsigned long lastStatus = 0;
    if (millis() - lastStatus >= 10000) {
        JsonDocument status = pcrDevice.getStatus();

        Logger::info("── Status ──────────────────────────────");
        Logger::info("WiFi:    " + String(wifiManager.getState()));
        Logger::info("Device:  " + pcrDevice.getStateString() +
                     "  Phase: " + status["currentPhase"].as<String>() +
                     "  Cycle: " + String(status["cycleNumber"].as<int>()) +
                     "/" + String(status["totalCycles"].as<int>()));
        Logger::info("Temp:    " + String(pcrDevice.getCurrentTemp(), 1) + " °C" +
                     "  →  " + String(pcrDevice.getTargetTemp(), 1) + " °C (target)");
        Logger::info("Heater: " + String(pcrDevice.isHeaterOn() ? "ON" : "OFF") +
                     "  Fan: "  + String(pcrDevice.isFanOn()    ? "ON" : "OFF"));

        if (pcrDevice.getState() == DeviceBase::RUNNING) {
            Logger::info("Progress: " + String(status["progress"].as<float>(), 1) + "%" +
                         "  Remaining: " + String(status["totalTimeRemaining"].as<int>()) + "s");
        }

        Logger::info("AP IP:   192.168.4.1  Clients: " + String(wifiManager.getAPClients()));
        if (wifiManager.isConnected()) {
            Logger::info("STA:     " + wifiManager.getSSID() +
                         "  IP: " + wifiManager.getIP() +
                         "  RSSI: " + String(wifiManager.getRSSI()) + " dBm");
        }

        Logger::info("Free heap: " + String(DeviceIdentity::getFreeHeap()) + " bytes");
        Logger::info("────────────────────────────────────────");

        lastStatus = millis();
    }

    // Blink onboard LED every 500 ms while WiFi is active (AP or connected)
    static unsigned long lastBlink = 0;
    WiFiManager::State wifiState = wifiManager.getState();
    bool wifiActive = (wifiState == WiFiManager::WIFI_AP_MODE ||
                       wifiState == WiFiManager::WIFI_CONNECTED);
    if (wifiActive) {
        if (millis() - lastBlink >= 500) {
            digitalWrite(PIN_LED, !digitalRead(PIN_LED));
            lastBlink = millis();
        }
    } else {
        digitalWrite(PIN_LED, HIGH);  // LED off when WiFi not ready
    }

    yield();  // Service WiFi stack without blocking PID timing
}
