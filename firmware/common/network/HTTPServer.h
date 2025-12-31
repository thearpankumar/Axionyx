/**
 * HTTPServer.h
 * HTTP REST API server for device control
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef HTTP_SERVER_H
#define HTTP_SERVER_H

#include <Arduino.h>
#include <ESPAsyncWebServer.h>
#include "../config/Config.h"
#include "../wifi/WiFiManager.h"
#include "../device/DeviceBase.h"

class HTTPServer {
public:
    HTTPServer(DeviceConfig& config, DeviceBase& device, WiFiManager& wifi);
    ~HTTPServer();

    void begin();
    void loop();

private:
    DeviceConfig& config;
    DeviceBase& device;
    WiFiManager& wifi;
    AsyncWebServer* server;

    // Setup routes
    void setupRoutes();

    // CORS and response helpers
    void enableCORS(AsyncWebServerResponse* response);
    void sendJSON(AsyncWebServerRequest* request, int code, const JsonDocument& doc);
    void sendError(AsyncWebServerRequest* request, int code, const String& error);
    void sendSuccess(AsyncWebServerRequest* request, const String& message);

    // Route handlers - Device Management
    void handleGetDeviceInfo(AsyncWebServerRequest* request);
    void handleGetDeviceStatus(AsyncWebServerRequest* request);
    void handleDeviceStart(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total);
    void handleDeviceStop(AsyncWebServerRequest* request);
    void handleDevicePause(AsyncWebServerRequest* request);
    void handleDeviceResume(AsyncWebServerRequest* request);
    void handleSetSetpoint(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total);

    // Route handlers - WiFi Configuration
    void handleGetWiFiStatus(AsyncWebServerRequest* request);
    void handleWiFiScan(AsyncWebServerRequest* request);
    void handleWiFiConfigure(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total);

    // Route handlers - Configuration
    void handleGetConfig(AsyncWebServerRequest* request);
    void handleSetConfig(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total);
    void handleFactoryReset(AsyncWebServerRequest* request);

    // Provisioning page (captive portal)
    void handleProvisioningPage(AsyncWebServerRequest* request);
};

#endif // HTTP_SERVER_H
