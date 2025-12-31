/**
 * WebSocketServer.cpp
 * WebSocket server implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "WebSocketServer.h"
#include "../utils/Logger.h"
#include <ArduinoJson.h>

// Static instance for callback
WebSocketServer* WebSocketServer::instance = nullptr;

WebSocketServer::WebSocketServer(DeviceBase& dev)
    : device(dev),
      ws(nullptr),
      lastTelemetryBroadcast(0),
      telemetryInterval(1000) {  // 1 second default

    instance = this;
}

WebSocketServer::~WebSocketServer() {
    if (ws) {
        delete ws;
    }
    instance = nullptr;
}

void WebSocketServer::begin(uint16_t port) {
    Logger::info("WebSocketServer: Starting on port " + String(port));

    ws = new WebSocketsServer(port);
    ws->begin();
    ws->onEvent(staticEventHandler);

    Logger::info("WebSocketServer: Started successfully");
}

void WebSocketServer::loop() {
    if (ws) {
        ws->loop();
    }
}

void WebSocketServer::broadcastTelemetry() {
    if (!ws) return;

    unsigned long now = millis();
    if (now - lastTelemetryBroadcast < telemetryInterval) {
        return;
    }

    // Get device status
    JsonDocument status = device.getStatus();

    // Create telemetry message
    JsonDocument telemetry;
    telemetry["type"] = "telemetry";
    telemetry["timestamp"] = now / 1000;
    telemetry["data"] = status;

    broadcast(telemetry);

    lastTelemetryBroadcast = now;
}

void WebSocketServer::sendEvent(const String& event, const String& message) {
    if (!ws) return;

    JsonDocument doc;
    doc["type"] = "event";
    doc["event"] = event;
    doc["message"] = message;
    doc["timestamp"] = millis() / 1000;

    broadcast(doc);

    Logger::info("WebSocketServer: Event sent - " + event + ": " + message);
}

void WebSocketServer::onWebSocketEvent(uint8_t clientNum, WStype_t type, uint8_t* payload, size_t length) {
    switch (type) {
        case WStype_DISCONNECTED:
            Logger::info("WebSocketServer: Client " + String(clientNum) + " disconnected");
            break;

        case WStype_CONNECTED: {
            IPAddress ip = ws->remoteIP(clientNum);
            Logger::info("WebSocketServer: Client " + String(clientNum) + " connected from " + ip.toString());

            // Send welcome message
            JsonDocument welcome;
            welcome["type"] = "connected";
            welcome["message"] = "Connected to Axionyx device";
            welcome["clientId"] = clientNum;
            sendToClient(clientNum, welcome);
            break;
        }

        case WStype_TEXT: {
            Logger::debug("WebSocketServer: Received message from client " + String(clientNum));

            // Parse JSON message
            JsonDocument doc;
            DeserializationError error = deserializeJson(doc, payload, length);

            if (error) {
                Logger::error("WebSocketServer: JSON parse error: " + String(error.c_str()));
                sendResponse(clientNum, false, "Invalid JSON");
                return;
            }

            // Handle different message types
            if (doc.containsKey("type")) {
                String type = doc["type"];

                if (type == "command") {
                    handleCommand(clientNum, doc);
                } else if (type == "ping") {
                    JsonDocument pong;
                    pong["type"] = "pong";
                    pong["timestamp"] = millis() / 1000;
                    sendToClient(clientNum, pong);
                } else {
                    sendResponse(clientNum, false, "Unknown message type");
                }
            } else {
                sendResponse(clientNum, false, "Missing message type");
            }
            break;
        }

        case WStype_BIN:
            Logger::warning("WebSocketServer: Binary data not supported");
            break;

        case WStype_ERROR:
            Logger::error("WebSocketServer: Error occurred");
            break;

        case WStype_FRAGMENT_TEXT_START:
        case WStype_FRAGMENT_BIN_START:
        case WStype_FRAGMENT:
        case WStype_FRAGMENT_FIN:
            Logger::warning("WebSocketServer: Fragmented messages not supported");
            break;

        default:
            break;
    }
}

void WebSocketServer::handleCommand(uint8_t clientNum, JsonDocument& doc) {
    if (!doc.containsKey("command")) {
        sendResponse(clientNum, false, "Missing command field");
        return;
    }

    String command = doc["command"];
    String requestId = doc["requestId"] | "";

    Logger::info("WebSocketServer: Command received - " + command);

    bool success = false;
    String message = "";

    if (command == "start") {
        JsonDocument params = doc["params"];
        success = device.start(params);
        message = success ? "Device started" : "Failed to start device";

    } else if (command == "stop") {
        success = device.stop();
        message = success ? "Device stopped" : "Failed to stop device";

    } else if (command == "pause") {
        success = device.pause();
        message = success ? "Device paused" : "Failed to pause device";

    } else if (command == "resume") {
        success = device.resume();
        message = success ? "Device resumed" : "Failed to resume device";

    } else if (command == "setpoint") {
        if (doc.containsKey("params")) {
            JsonObject params = doc["params"];
            uint8_t zone = params["zone"] | 0;
            float temperature = params["temperature"] | 0.0;

            success = device.setSetpoint(zone, temperature);
            message = success ? "Setpoint updated" : "Failed to update setpoint";
        } else {
            message = "Missing parameters";
        }

    } else if (command == "get_status") {
        JsonDocument status = device.getStatus();

        JsonDocument response;
        response["type"] = "response";
        response["success"] = true;
        response["requestId"] = requestId;
        response["data"] = status;

        sendToClient(clientNum, response);
        return;

    } else {
        message = "Unknown command: " + command;
    }

    // Send command response
    JsonDocument response;
    response["type"] = "response";
    response["success"] = success;
    response["message"] = message;
    response["requestId"] = requestId;

    sendToClient(clientNum, response);
}

void WebSocketServer::sendResponse(uint8_t clientNum, bool success, const String& message) {
    JsonDocument doc;
    doc["type"] = "response";
    doc["success"] = success;
    doc["message"] = message;

    sendToClient(clientNum, doc);
}

void WebSocketServer::sendToClient(uint8_t clientNum, const JsonDocument& doc) {
    if (!ws) return;

    String json;
    serializeJson(doc, json);
    ws->sendTXT(clientNum, json);
}

void WebSocketServer::broadcast(const JsonDocument& doc) {
    if (!ws) return;

    String json;
    serializeJson(doc, json);
    ws->broadcastTXT(json);
}

void WebSocketServer::staticEventHandler(uint8_t clientNum, WStype_t type, uint8_t* payload, size_t length) {
    if (instance) {
        instance->onWebSocketEvent(clientNum, type, payload, length);
    }
}
