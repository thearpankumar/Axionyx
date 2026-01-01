/**
 * WebSocketServer.h
 * WebSocket server for real-time device telemetry
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef WEBSOCKET_SERVER_H
#define WEBSOCKET_SERVER_H

#include <Arduino.h>
#include <WebSocketsServer.h>
#include "../device/DeviceBase.h"

class WebSocketServer {
public:
    WebSocketServer(DeviceBase& device);
    ~WebSocketServer();

    void begin(uint16_t port);
    void loop();

    // Broadcast methods
    void broadcastTelemetry();
    void sendEvent(const String& event, const String& message);

private:
    DeviceBase& device;
    WebSocketsServer* ws;
    unsigned long lastTelemetryBroadcast;
    uint16_t telemetryInterval;
    uint16_t port;
    bool serverStarted;

    // WebSocket event handler
    void onWebSocketEvent(uint8_t clientNum, WStype_t type, uint8_t* payload, size_t length);

    // Message handlers
    void handleCommand(uint8_t clientNum, JsonDocument& doc);
    void sendResponse(uint8_t clientNum, bool success, const String& message);
    void sendToClient(uint8_t clientNum, const JsonDocument& doc);
    void broadcast(const JsonDocument& doc);

    // Static wrapper for event handler (required for callback)
    static WebSocketServer* instance;
    static void staticEventHandler(uint8_t clientNum, WStype_t type, uint8_t* payload, size_t length);
};

#endif // WEBSOCKET_SERVER_H
