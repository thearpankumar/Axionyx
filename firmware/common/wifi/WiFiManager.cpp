/**
 * WiFiManager.cpp
 * WiFi state machine implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "WiFiManager.h"
#include "../utils/Logger.h"
#include "../device/DeviceIdentity.h"

// Reconnection delays: 1s, 2s, 4s, 8s, 16s (exponential backoff, max 30s)
const unsigned long WiFiManager::RECONNECT_DELAYS[] = {1000, 2000, 4000, 8000, 16000};

WiFiManager::WiFiManager(DeviceConfig& cfg)
    : config(cfg),
      currentState(WIFI_INIT),
      dnsServer(nullptr),
      lastReconnectAttempt(0),
      reconnectAttempts(0) {
}

WiFiManager::~WiFiManager() {
    if (dnsServer) {
        delete dnsServer;
    }
}

void WiFiManager::begin() {
    Logger::info("WiFiManager: Initializing...");

    WiFi.mode(WIFI_OFF);
    delay(100);

    setState(WIFI_INIT);
}

void WiFiManager::loop() {
    switch (currentState) {
        case WIFI_INIT:
            handleStateInit();
            break;
        case WIFI_AP_MODE:
            handleStateAPMode();
            break;
        case WIFI_CONNECTING:
            handleStateConnecting();
            break;
        case WIFI_CONNECTED:
            handleStateConnected();
            break;
        case WIFI_RECONNECT:
            handleStateReconnect();
            break;
    }

    // Process DNS requests for captive portal
    if (dnsServer) {
        dnsServer->processNextRequest();
    }
}

void WiFiManager::handleStateInit() {
    Logger::info("WiFiManager: INIT state");

    // Check if we have saved credentials
    if (config.wifi.ssid.length() > 0 && config.wifi.mode != DeviceConfig::AP_ONLY) {
        Logger::info("WiFiManager: Found saved credentials, attempting to connect");
        setState(WIFI_CONNECTING);
    } else {
        Logger::info("WiFiManager: No credentials found, starting AP mode");
        setState(WIFI_AP_MODE);
    }
}

void WiFiManager::handleStateAPMode() {
    static bool apStarted = false;

    if (!apStarted) {
        startAP();
        startCaptivePortal();
        apStarted = true;
    }

    // Stay in AP mode until credentials are received
    // (handled by HTTP server through setCredentials())
}

void WiFiManager::handleStateConnecting() {
    static unsigned long connectStartTime = 0;
    static bool connecting = false;

    if (!connecting) {
        Logger::info("WiFiManager: Connecting to " + config.wifi.ssid);
        startSTA();
        connectStartTime = millis();
        connecting = true;
    }

    // Check connection status
    if (WiFi.status() == WL_CONNECTED) {
        Logger::info("WiFiManager: Connected! IP: " + WiFi.localIP().toString());
        reconnectAttempts = 0;
        connecting = false;
        setState(WIFI_CONNECTED);
    } else if (millis() - connectStartTime > 10000) {
        // Timeout after 10 seconds
        Logger::warning("WiFiManager: Connection timeout");
        connecting = false;
        setState(WIFI_RECONNECT);
    }
}

void WiFiManager::handleStateConnected() {
    static unsigned long lastCheck = 0;

    // Check connection health every 5 seconds
    if (millis() - lastCheck > 5000) {
        if (WiFi.status() != WL_CONNECTED) {
            Logger::warning("WiFiManager: Connection lost!");
            setState(WIFI_RECONNECT);
        }
        lastCheck = millis();
    }

    // Handle AP mode based on configuration
    static bool apConfigured = false;
    if (!apConfigured) {
        if (config.wifi.mode == DeviceConfig::AP_STA_DUAL) {
            Logger::info("WiFiManager: Starting AP in dual mode");
            // Keep AP running
            if (WiFi.getMode() != WIFI_AP_STA) {
                startAP();
            }
        } else if (config.wifi.mode == DeviceConfig::STA_ONLY) {
            Logger::info("WiFiManager: Stopping AP (STA_ONLY mode)");
            stopAP();
            stopCaptivePortal();
        }
        apConfigured = true;
    }
}

void WiFiManager::handleStateReconnect() {
    unsigned long now = millis();

    if (now - lastReconnectAttempt > getReconnectDelay()) {
        Logger::info("WiFiManager: Reconnect attempt " + String(reconnectAttempts + 1));

        WiFi.disconnect();
        delay(100);

        lastReconnectAttempt = now;
        reconnectAttempts++;

        if (reconnectAttempts >= MAX_RECONNECT_ATTEMPTS) {
            Logger::error("WiFiManager: Max reconnect attempts reached, falling back to AP mode");
            reconnectAttempts = 0;
            setState(WIFI_AP_MODE);
        } else {
            setState(WIFI_CONNECTING);
        }
    }
}

void WiFiManager::startAP() {
    Logger::info("WiFiManager: Starting Access Point");

    // Generate AP SSID if not set
    if (config.wifi.apSSID.length() == 0) {
        config.wifi.apSSID = DeviceIdentity::generateAPSSID(config.device.type);
        Logger::info("WiFiManager: Generated AP SSID: " + config.wifi.apSSID);
    }

    WiFi.mode(WIFI_AP);
    delay(100);

    bool success = WiFi.softAP(config.wifi.apSSID.c_str(), config.wifi.apPassword.c_str());

    if (success) {
        IPAddress IP = WiFi.softAPIP();
        Logger::info("WiFiManager: AP started successfully");
        Logger::info("WiFiManager: AP SSID: " + config.wifi.apSSID);
        Logger::info("WiFiManager: AP IP: " + IP.toString());
    } else {
        Logger::error("WiFiManager: Failed to start AP");
    }
}

void WiFiManager::stopAP() {
    if (WiFi.getMode() == WIFI_AP || WiFi.getMode() == WIFI_AP_STA) {
        Logger::info("WiFiManager: Stopping Access Point");
        WiFi.softAPdisconnect(true);

        if (WiFi.getMode() == WIFI_AP_STA) {
            WiFi.mode(WIFI_STA);
        } else {
            WiFi.mode(WIFI_OFF);
        }
    }
}

void WiFiManager::startSTA() {
    Logger::info("WiFiManager: Starting Station mode");

    // Set mode based on configuration
    if (config.wifi.mode == DeviceConfig::AP_STA_DUAL) {
        WiFi.mode(WIFI_AP_STA);
    } else {
        WiFi.mode(WIFI_STA);
    }

    delay(100);

    // Configure static IP if enabled
    if (config.wifi.staticIP && config.wifi.ip.length() > 0) {
        IPAddress ip, gateway, subnet;
        ip.fromString(config.wifi.ip);
        gateway.fromString(config.wifi.gateway);
        subnet.fromString(config.wifi.subnet);

        if (!WiFi.config(ip, gateway, subnet)) {
            Logger::error("WiFiManager: Failed to configure static IP");
        } else {
            Logger::info("WiFiManager: Static IP configured: " + config.wifi.ip);
        }
    }

    // Connect to WiFi
    WiFi.begin(config.wifi.ssid.c_str(), config.wifi.password.c_str());
}

void WiFiManager::startCaptivePortal() {
    Logger::info("WiFiManager: Starting captive portal");

    if (!dnsServer) {
        dnsServer = new DNSServer();
    }

    // Redirect all DNS requests to the AP IP
    dnsServer->start(53, "*", WiFi.softAPIP());
}

void WiFiManager::stopCaptivePortal() {
    if (dnsServer) {
        Logger::info("WiFiManager: Stopping captive portal");
        dnsServer->stop();
        delete dnsServer;
        dnsServer = nullptr;
    }
}

void WiFiManager::setCredentials(const String& ssid, const String& password, DeviceConfig::WiFiMode mode) {
    Logger::info("WiFiManager: Setting new credentials");
    Logger::info("WiFiManager: SSID: " + ssid);
    Logger::info("WiFiManager: Mode: " + String(mode));

    config.wifi.ssid = ssid;
    config.wifi.password = password;
    config.wifi.mode = mode;

    // Save configuration
    config.save();

    // Trigger connection
    setState(WIFI_CONNECTING);
}

void WiFiManager::startProvisioning() {
    Logger::info("WiFiManager: Starting provisioning mode");
    setState(WIFI_AP_MODE);
}

void WiFiManager::factoryReset() {
    Logger::info("WiFiManager: Factory reset requested");

    // Stop everything
    stopCaptivePortal();
    stopAP();
    WiFi.disconnect(true);
    WiFi.mode(WIFI_OFF);

    // Clear WiFi configuration
    config.wifi.ssid = "";
    config.wifi.password = "";
    config.wifi.mode = DeviceConfig::AP_ONLY;

    // Restart in AP mode
    delay(500);
    setState(WIFI_INIT);
}


String WiFiManager::getIP() const {
    if (WiFi.status() == WL_CONNECTED) {
        return WiFi.localIP().toString();
    }
    return "";
}

int8_t WiFiManager::getRSSI() const {
    if (WiFi.status() == WL_CONNECTED) {
        return WiFi.RSSI();
    }
    return 0;
}

uint8_t WiFiManager::getAPClients() const {
    return WiFi.softAPgetStationNum();
}

String WiFiManager::getSSID() const {
    if (WiFi.status() == WL_CONNECTED) {
        return WiFi.SSID();
    }
    return "";
}

void WiFiManager::setState(State newState) {
    if (newState != currentState) {
        Logger::info("WiFiManager: State transition: " + String(currentState) + " -> " + String(newState));
        currentState = newState;

        // Reset state-specific variables
        if (newState == WIFI_CONNECTING) {
            reconnectAttempts = 0;
        }
    }
}

unsigned long WiFiManager::getReconnectDelay() {
    if (reconnectAttempts < 5) {
        return RECONNECT_DELAYS[reconnectAttempts];
    }
    return 30000; // Max delay: 30 seconds
}
