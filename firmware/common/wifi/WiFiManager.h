/**
 * WiFiManager.h
 * WiFi state machine manager for ESP32
 * Handles AP, STA, and Dual mode operations
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef WIFI_MANAGER_H
#define WIFI_MANAGER_H

#include <Arduino.h>
#include <WiFi.h>
#include <DNSServer.h>
#include "../config/Config.h"

class WiFiManager {
public:
    // WiFi connection states
    enum State {
        WIFI_INIT = 0,        // Initializing WiFi
        WIFI_AP_MODE = 1,     // Access Point mode (provisioning)
        WIFI_CONNECTING = 2,  // Attempting to connect to WiFi
        WIFI_CONNECTED = 3,   // Connected to WiFi
        WIFI_RECONNECT = 4    // Reconnecting after connection loss
    };

    // WiFi network information
    struct NetworkInfo {
        String ssid;
        int32_t rssi;
        wifi_auth_mode_t encryption;
    };

    WiFiManager(DeviceConfig& config);
    ~WiFiManager();

    void begin();
    void loop();

    // State management
    State getState() const { return currentState; }
    bool isConnected() const { return WiFi.status() == WL_CONNECTED; }

    // Network information
    String getIP() const;
    int8_t getRSSI() const;
    uint8_t getAPClients() const;
    String getSSID() const;

    // WiFi configuration
    void setCredentials(const String& ssid, const String& password, DeviceConfig::WiFiMode mode);
    void startProvisioning();
    void factoryReset();

    // Network scanning
    std::vector<NetworkInfo> scanNetworks();

private:
    DeviceConfig& config;
    State currentState;
    DNSServer* dnsServer;

    unsigned long lastReconnectAttempt;
    uint8_t reconnectAttempts;
    static const uint8_t MAX_RECONNECT_ATTEMPTS = 5;
    static const unsigned long RECONNECT_DELAYS[];

    // State handlers
    void handleStateInit();
    void handleStateAPMode();
    void handleStateConnecting();
    void handleStateConnected();
    void handleStateReconnect();

    // WiFi operations
    void startAP();
    void stopAP();
    void startSTA();
    void startCaptivePortal();
    void stopCaptivePortal();

    // Helpers
    void setState(State newState);
    unsigned long getReconnectDelay();
};

#endif // WIFI_MANAGER_H
