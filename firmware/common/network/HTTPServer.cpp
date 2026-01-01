/**
 * HTTPServer.cpp
 * HTTP REST API server implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "HTTPServer.h"
#include "../utils/Logger.h"
#include "../device/DeviceIdentity.h"
#include <ArduinoJson.h>

HTTPServer::HTTPServer(DeviceConfig& cfg, DeviceBase& dev, WiFiManager& wm)
    : config(cfg), device(dev), wifi(wm), server(nullptr), serverStarted(false) {
}

HTTPServer::~HTTPServer() {
    if (server) {
        delete server;
    }
}

void HTTPServer::begin() {
    Logger::info("HTTPServer: Initializing on port " + String(config.network.httpPort));

    server = new AsyncWebServer(config.network.httpPort);
    setupRoutes();

    Logger::info("HTTPServer: Routes configured, waiting for WiFi to start server");
}

void HTTPServer::loop() {
    // Start server once WiFi is ready (either in AP or STA mode)
    if (!serverStarted && WiFi.getMode() != WIFI_OFF) {
        Logger::info("HTTPServer: WiFi ready, starting server");
        server->begin();
        serverStarted = true;
        Logger::info("HTTPServer: Started successfully");
    }

    // AsyncWebServer handles requests asynchronously
    // No need for explicit loop processing
}

void HTTPServer::setupRoutes() {
    // Enable CORS for all routes
    DefaultHeaders::Instance().addHeader("Access-Control-Allow-Origin", "*");
    DefaultHeaders::Instance().addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    DefaultHeaders::Instance().addHeader("Access-Control-Allow-Headers", "Content-Type");

    // Device Management Endpoints
    server->on("/api/v1/device/info", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleGetDeviceInfo(request); });

    server->on("/api/v1/device/status", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleGetDeviceStatus(request); });

    server->on("/api/v1/device/start", HTTP_POST,
        [this](AsyncWebServerRequest* request) {
            sendSuccess(request, "Start command received");
        },
        NULL,
        [this](AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
            handleDeviceStart(request, data, len, index, total);
        });

    server->on("/api/v1/device/stop", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleDeviceStop(request); });

    server->on("/api/v1/device/pause", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleDevicePause(request); });

    server->on("/api/v1/device/resume", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleDeviceResume(request); });

    server->on("/api/v1/device/setpoint", HTTP_PUT,
        [this](AsyncWebServerRequest* request) {
            sendSuccess(request, "Setpoint update received");
        },
        NULL,
        [this](AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
            handleSetSetpoint(request, data, len, index, total);
        });

    // Program Management Endpoints (PCR-specific features)
    server->on("/api/v1/device/program/validate", HTTP_POST,
        [this](AsyncWebServerRequest* request) {
            sendSuccess(request, "Program validation received");
        },
        NULL,
        [this](AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
            handleProgramValidate(request, data, len, index, total);
        });

    server->on("/api/v1/device/program/templates", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleProgramTemplates(request); });

    // Protocol Management Endpoints (Incubator-specific features)
    server->on("/api/v1/device/protocol/templates", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleProtocolTemplates(request); });

    server->on("/api/v1/device/protocol/start", HTTP_POST,
        [this](AsyncWebServerRequest* request) {
            sendSuccess(request, "Protocol start received");
        },
        NULL,
        [this](AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
            handleProtocolStart(request, data, len, index, total);
        });

    server->on("/api/v1/device/protocol/stop", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleProtocolStop(request); });

    server->on("/api/v1/device/protocol/pause", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleProtocolPause(request); });

    server->on("/api/v1/device/protocol/resume", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleProtocolResume(request); });

    server->on("/api/v1/device/protocol/next-stage", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleProtocolNextStage(request); });

    // Alarm Management Endpoints (Incubator-specific features)
    server->on("/api/v1/device/alarms", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleGetAlarms(request); });

    server->on("/api/v1/device/alarms/acknowledge", HTTP_POST,
        [this](AsyncWebServerRequest* request) {
            sendSuccess(request, "Alarm acknowledge received");
        },
        NULL,
        [this](AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
            handleAcknowledgeAlarm(request, data, len, index, total);
        });

    server->on("/api/v1/device/alarms/acknowledge-all", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleAcknowledgeAllAlarms(request); });

    server->on("/api/v1/device/alarms/history", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleGetAlarmHistory(request); });

    // WiFi Configuration Endpoints
    server->on("/api/v1/wifi/status", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleGetWiFiStatus(request); });

    // WiFi scan disabled - mobile app/browser handles network scanning
    // server->on("/api/v1/wifi/scan", HTTP_GET,
    //     [this](AsyncWebServerRequest* request) { handleWiFiScan(request); });

    server->on("/api/v1/wifi/configure", HTTP_POST,
        [this](AsyncWebServerRequest* request) {
            sendSuccess(request, "WiFi configuration received");
        },
        NULL,
        [this](AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
            handleWiFiConfigure(request, data, len, index, total);
        });

    // Configuration Endpoints
    server->on("/api/v1/config", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleGetConfig(request); });

    server->on("/api/v1/config", HTTP_POST,
        [this](AsyncWebServerRequest* request) {
            sendSuccess(request, "Configuration update received");
        },
        NULL,
        [this](AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
            handleSetConfig(request, data, len, index, total);
        });

    server->on("/api/v1/config/factory-reset", HTTP_POST,
        [this](AsyncWebServerRequest* request) { handleFactoryReset(request); });

    // Provisioning page (captive portal)
    server->on("/", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleProvisioningPage(request); });

    server->on("/provision", HTTP_GET,
        [this](AsyncWebServerRequest* request) { handleProvisioningPage(request); });

    // 404 handler
    server->onNotFound([](AsyncWebServerRequest* request) {
        request->send(404, "application/json", "{\"error\":\"Endpoint not found\"}");
    });

    Logger::info("HTTPServer: Routes configured");
}

// ============================================================================
// Helper Methods
// ============================================================================

void HTTPServer::enableCORS(AsyncWebServerResponse* response) {
    response->addHeader("Access-Control-Allow-Origin", "*");
    response->addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    response->addHeader("Access-Control-Allow-Headers", "Content-Type");
}

void HTTPServer::sendJSON(AsyncWebServerRequest* request, int code, const JsonDocument& doc) {
    String json;
    serializeJson(doc, json);

    AsyncWebServerResponse* response = request->beginResponse(code, "application/json", json);
    enableCORS(response);
    request->send(response);
}

void HTTPServer::sendError(AsyncWebServerRequest* request, int code, const String& error) {
    JsonDocument doc;
    doc["success"] = false;
    doc["error"] = error;
    sendJSON(request, code, doc);
}

void HTTPServer::sendSuccess(AsyncWebServerRequest* request, const String& message) {
    JsonDocument doc;
    doc["success"] = true;
    doc["message"] = message;
    sendJSON(request, 200, doc);
}

// ============================================================================
// Device Management Handlers
// ============================================================================

void HTTPServer::handleGetDeviceInfo(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET /api/v1/device/info");

    JsonDocument doc;
    doc["id"] = config.device.id;
    doc["type"] = config.device.type;
    doc["name"] = config.device.name;
    doc["serialNumber"] = config.device.serialNumber;
    doc["firmwareVersion"] = config.device.firmwareVersion;
    doc["uptime"] = device.getUptime();
    doc["freeHeap"] = DeviceIdentity::getFreeHeap();
    doc["chipId"] = DeviceIdentity::getChipID();
    doc["mac"] = DeviceIdentity::getMAC();

    sendJSON(request, 200, doc);
}

void HTTPServer::handleGetDeviceStatus(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET /api/v1/device/status");

    JsonDocument status = device.getStatus();
    sendJSON(request, 200, status);
}

void HTTPServer::handleDeviceStart(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
    // Only process when we have all data
    if (index + len != total) return;

    Logger::info("HTTPServer: POST /api/v1/device/start");

    // Parse JSON body
    JsonDocument doc;
    DeserializationError error = deserializeJson(doc, data, len);

    if (error) {
        sendError(request, 400, "Invalid JSON");
        return;
    }

    // Start device with parameters
    bool success = device.start(doc);

    if (success) {
        sendSuccess(request, "Device started successfully");
    } else {
        sendError(request, 500, "Failed to start device");
    }
}

void HTTPServer::handleDeviceStop(AsyncWebServerRequest* request) {
    Logger::info("HTTPServer: POST /api/v1/device/stop");

    bool success = device.stop();

    if (success) {
        sendSuccess(request, "Device stopped successfully");
    } else {
        sendError(request, 500, "Failed to stop device");
    }
}

void HTTPServer::handleDevicePause(AsyncWebServerRequest* request) {
    Logger::info("HTTPServer: POST /api/v1/device/pause");

    bool success = device.pause();

    if (success) {
        sendSuccess(request, "Device paused successfully");
    } else {
        sendError(request, 400, "Cannot pause device in current state");
    }
}

void HTTPServer::handleDeviceResume(AsyncWebServerRequest* request) {
    Logger::info("HTTPServer: POST /api/v1/device/resume");

    bool success = device.resume();

    if (success) {
        sendSuccess(request, "Device resumed successfully");
    } else {
        sendError(request, 400, "Cannot resume device in current state");
    }
}

void HTTPServer::handleSetSetpoint(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
    if (index + len != total) return;

    Logger::info("HTTPServer: PUT /api/v1/device/setpoint");

    JsonDocument doc;
    DeserializationError error = deserializeJson(doc, data, len);

    if (error) {
        sendError(request, 400, "Invalid JSON");
        return;
    }

    if (doc["zone"].isNull() || doc["temperature"].isNull()) {
        sendError(request, 400, "Missing required fields: zone, temperature");
        return;
    }

    uint8_t zone = doc["zone"];
    float temperature = doc["temperature"];

    bool success = device.setSetpoint(zone, temperature);

    if (success) {
        sendSuccess(request, "Setpoint updated successfully");
    } else {
        sendError(request, 400, "Invalid zone or temperature value");
    }
}

// ============================================================================
// WiFi Configuration Handlers
// ============================================================================

void HTTPServer::handleGetWiFiStatus(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET /api/v1/wifi/status");

    JsonDocument doc;

    // WiFi mode
    doc["mode"] = config.wifi.mode;

    // Station mode info
    doc["connected"] = wifi.isConnected();
    doc["ssid"] = wifi.getSSID();
    doc["ip"] = wifi.getIP();
    doc["rssi"] = wifi.getRSSI();

    // Signal quality
    int8_t rssi = wifi.getRSSI();
    String quality = "poor";
    if (rssi > -50) quality = "excellent";
    else if (rssi > -60) quality = "good";
    else if (rssi > -70) quality = "fair";
    doc["quality"] = quality;

    // Access Point info
    doc["apActive"] = (WiFi.getMode() == WIFI_AP || WiFi.getMode() == WIFI_AP_STA);
    doc["apSSID"] = config.wifi.apSSID;
    doc["apIP"] = WiFi.softAPIP().toString();
    doc["apClients"] = wifi.getAPClients();

    sendJSON(request, 200, doc);
}


void HTTPServer::handleWiFiConfigure(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
    if (index + len != total) return;

    Logger::info("HTTPServer: POST /api/v1/wifi/configure");

    JsonDocument doc;
    DeserializationError error = deserializeJson(doc, data, len);

    if (error) {
        sendError(request, 400, "Invalid JSON");
        return;
    }

    if (doc["ssid"].isNull() || doc["password"].isNull()) {
        sendError(request, 400, "Missing required fields: ssid, password");
        return;
    }

    String ssid = doc["ssid"];
    String password = doc["password"];
    DeviceConfig::WiFiMode mode = static_cast<DeviceConfig::WiFiMode>(doc["mode"] | DeviceConfig::STA_ONLY);

    // Set WiFi credentials
    wifi.setCredentials(ssid, password, mode);

    JsonDocument response;
    response["success"] = true;
    response["message"] = "WiFi configured successfully. Device will attempt to connect.";
    sendJSON(request, 200, response);
}

// ============================================================================
// Configuration Handlers
// ============================================================================

void HTTPServer::handleGetConfig(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET /api/v1/config");

    String configJSON = config.toJSON();

    AsyncWebServerResponse* response = request->beginResponse(200, "application/json", configJSON);
    enableCORS(response);
    request->send(response);
}

void HTTPServer::handleSetConfig(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
    if (index + len != total) return;

    Logger::info("HTTPServer: POST /api/v1/config");

    String jsonStr = String((char*)data);

    if (config.fromJSON(jsonStr)) {
        config.save();
        sendSuccess(request, "Configuration updated successfully");
    } else {
        sendError(request, 400, "Invalid configuration");
    }
}

void HTTPServer::handleFactoryReset(AsyncWebServerRequest* request) {
    Logger::warning("HTTPServer: POST /api/v1/config/factory-reset");

    sendSuccess(request, "Factory reset initiated. Device will restart.");

    // Delay to send response, then reset
    delay(500);

    config.reset();
    wifi.factoryReset();

    delay(1000);
    ESP.restart();
}

// ============================================================================
// Program Management Endpoints
// ============================================================================

void HTTPServer::handleProgramValidate(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
    Logger::debug("HTTPServer: POST /api/v1/device/program/validate");

    // Only process the final chunk
    if (index + len != total) {
        return;
    }

    JsonDocument doc;
    DeserializationError error = deserializeJson(doc, data, len);

    if (error) {
        sendError(request, 400, "Invalid JSON: " + String(error.c_str()));
        return;
    }

    // Validation logic for PCR programs
    JsonArray errors = doc["errors"].to<JsonArray>();
    JsonArray warnings = doc["warnings"].to<JsonArray>();
    bool isValid = true;

    // Validate cycles
    if (!doc["cycles"].isNull()) {
        int cycles = doc["cycles"];
        if (cycles < 1 || cycles > 100) {
            errors.add("Cycles must be between 1 and 100");
            isValid = false;
        }
    }

    // Validate temperatures
    if (!doc["denatureTemp"].isNull()) {
        float temp = doc["denatureTemp"];
        if (temp < 90.0 || temp > 100.0) {
            warnings.add("Denaturation temperature should be between 90-100°C");
        }
    }

    if (!doc["annealTemp"].isNull()) {
        float temp = doc["annealTemp"];
        if (temp < 45.0 || temp > 75.0) {
            warnings.add("Annealing temperature should be between 45-75°C");
        }
    }

    if (!doc["extendTemp"].isNull()) {
        float temp = doc["extendTemp"];
        if (temp < 68.0 || temp > 76.0) {
            warnings.add("Extension temperature should be between 68-76°C");
        }
    }

    // Validate touchdown parameters
    if (!doc["touchdown"].isNull() && doc["touchdown"]["enabled"]) {
        JsonObject td = doc["touchdown"];
        if (!td["startAnnealTemp"].isNull() && !td["endAnnealTemp"].isNull()) {
            float start = td["startAnnealTemp"];
            float end = td["endAnnealTemp"];
            if (start <= end) {
                errors.add("Touchdown start temperature must be higher than end temperature");
                isValid = false;
            }
        }
    }

    // Validate gradient parameters
    if (!doc["gradient"].isNull() && doc["gradient"]["enabled"]) {
        JsonObject grad = doc["gradient"];
        if (!grad["tempLow"].isNull() && !grad["tempHigh"].isNull()) {
            float low = grad["tempLow"];
            float high = grad["tempHigh"];
            if (low >= high) {
                errors.add("Gradient low temperature must be lower than high temperature");
                isValid = false;
            }
        }
        if (!grad["positions"].isNull()) {
            int positions = grad["positions"];
            if (positions < 2 || positions > 12) {
                errors.add("Gradient positions must be between 2 and 12");
                isValid = false;
            }
        }
    }

    // Send response
    JsonDocument response;
    response["valid"] = isValid;
    response["errors"] = errors;
    response["warnings"] = warnings;

    sendJSON(request, 200, response);
}

void HTTPServer::handleProgramTemplates(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET /api/v1/device/program/templates");

    JsonDocument doc;
    JsonArray templates = doc["templates"].to<JsonArray>();

    // Only provide PCR templates if device type is PCR
    if (config.device.type == "PCR") {
        // Standard PCR
        JsonObject standard = templates.add<JsonObject>();
        standard["name"] = "Standard PCR";
        standard["type"] = "standard";
        standard["description"] = "Basic PCR protocol for general amplification";
        standard["cycles"] = 35;
        standard["denatureTemp"] = 95.0;
        standard["denatureTime"] = 30;
        standard["annealTemp"] = 60.0;
        standard["annealTime"] = 30;
        standard["extendTemp"] = 72.0;
        standard["extendTime"] = 60;

        // Fast PCR (Two-Step)
        JsonObject fast = templates.add<JsonObject>();
        fast["name"] = "Fast PCR";
        fast["type"] = "twostep";
        fast["description"] = "Faster cycling for amplicons <500bp";
        fast["twoStepEnabled"] = true;
        fast["cycles"] = 30;
        fast["denatureTemp"] = 95.0;
        fast["denatureTime"] = 15;
        fast["annealExtendTemp"] = 65.0;
        fast["annealExtendTime"] = 30;

        // Gradient Optimization
        JsonObject gradient = templates.add<JsonObject>();
        gradient["name"] = "Gradient Optimization";
        gradient["type"] = "gradient";
        gradient["description"] = "Optimize annealing temperature across gradient";
        gradient["cycles"] = 25;
        gradient["denatureTemp"] = 95.0;
        gradient["denatureTime"] = 30;
        gradient["extendTemp"] = 72.0;
        gradient["extendTime"] = 60;
        JsonObject gradConfig = gradient["gradient"].to<JsonObject>();
        gradConfig["enabled"] = true;
        gradConfig["tempLow"] = 55.0;
        gradConfig["tempHigh"] = 65.0;
        gradConfig["positions"] = 12;

        // High Specificity (Touchdown)
        JsonObject touchdown = templates.add<JsonObject>();
        touchdown["name"] = "High Specificity";
        touchdown["type"] = "touchdown";
        touchdown["description"] = "Reduce non-specific amplification";
        touchdown["cycles"] = 35;
        touchdown["denatureTemp"] = 95.0;
        touchdown["denatureTime"] = 30;
        touchdown["extendTemp"] = 72.0;
        touchdown["extendTime"] = 60;
        JsonObject tdConfig = touchdown["touchdown"].to<JsonObject>();
        tdConfig["enabled"] = true;
        tdConfig["startAnnealTemp"] = 72.0;
        tdConfig["endAnnealTemp"] = 60.0;
        tdConfig["stepSize"] = 1.0;
        tdConfig["touchdownCycles"] = 12;

        // Colony PCR (Hot Start)
        JsonObject colony = templates.add<JsonObject>();
        colony["name"] = "Colony PCR";
        colony["type"] = "standard";
        colony["description"] = "For amplification from bacterial colonies";
        colony["cycles"] = 35;
        colony["denatureTemp"] = 95.0;
        colony["denatureTime"] = 30;
        colony["annealTemp"] = 60.0;
        colony["annealTime"] = 30;
        colony["extendTemp"] = 72.0;
        colony["extendTime"] = 60;
        colony["initialDenatureTime"] = 300;  // 5 minutes for colony lysis
        JsonObject hsConfig = colony["hotStart"].to<JsonObject>();
        hsConfig["enabled"] = true;
        hsConfig["activationTemp"] = 95.0;
        hsConfig["activationTime"] = 900;  // 15 minutes
    }

    sendJSON(request, 200, doc);
}

// ============================================================================
// Protocol Management Endpoints (Incubator)
// ============================================================================

void HTTPServer::handleProtocolTemplates(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET /api/v1/device/protocol/templates");

    JsonDocument doc;
    JsonArray templates = doc["templates"].to<JsonArray>();

    // Only provide incubator templates if device type is INCUBATOR
    if (config.device.type == "INCUBATOR") {
        // Mammalian Cell Culture
        JsonObject mammalian = templates.add<JsonObject>();
        mammalian["name"] = "Mammalian Cell Culture";
        mammalian["type"] = 0; // MAMMALIAN_CULTURE
        mammalian["description"] = "Standard mammalian cell culture with 30-minute pre-heat ramp";
        mammalian["stages"] = 2;

        // Bacterial Growth
        JsonObject bacterial = templates.add<JsonObject>();
        bacterial["name"] = "Bacterial Growth (E. coli)";
        bacterial["type"] = 1; // BACTERIAL_CULTURE
        bacterial["description"] = "Standard E. coli culture with 15-minute warm-up";
        bacterial["stages"] = 2;

        // Yeast Culture
        JsonObject yeast = templates.add<JsonObject>();
        yeast["name"] = "Yeast Culture";
        yeast["type"] = 2; // YEAST_CULTURE
        yeast["description"] = "Standard yeast culture at 30°C with 10-minute pre-heat";
        yeast["stages"] = 2;

        // Decontamination
        JsonObject decon = templates.add<JsonObject>();
        decon["name"] = "Decontamination Cycle";
        decon["type"] = 3; // DECONTAMINATION
        decon["description"] = "High-temperature cleaning cycle (65°C for 2 hours)";
        decon["stages"] = 3;

        // Multi-Temperature Expression
        JsonObject multiTemp = templates.add<JsonObject>();
        multiTemp["name"] = "Multi-Temperature Expression";
        multiTemp["type"] = 4; // CUSTOM_PROTOCOL
        multiTemp["description"] = "Three-stage protocol for protein expression optimization";
        multiTemp["stages"] = 3;
    }

    sendJSON(request, 200, doc);
}

void HTTPServer::handleProtocolStart(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
    Logger::debug("HTTPServer: POST /api/v1/device/protocol/start");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Protocol management only available for incubator devices");
        return;
    }

    // Only process the final chunk
    if (index + len != total) {
        return;
    }

    // Note: This is a simplified implementation
    // In a full implementation, we would parse the protocol JSON and start it
    // For now, we just acknowledge receipt
    sendSuccess(request, "Protocol start command received");
}

void HTTPServer::handleProtocolStop(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: POST /api/v1/device/protocol/stop");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Protocol management only available for incubator devices");
        return;
    }

    // Device-specific implementation would call device.stopProtocol()
    sendSuccess(request, "Protocol stopped");
}

void HTTPServer::handleProtocolPause(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: POST /api/v1/device/protocol/pause");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Protocol management only available for incubator devices");
        return;
    }

    sendSuccess(request, "Protocol paused");
}

void HTTPServer::handleProtocolResume(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: POST /api/v1/device/protocol/resume");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Protocol management only available for incubator devices");
        return;
    }

    sendSuccess(request, "Protocol resumed");
}

void HTTPServer::handleProtocolNextStage(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: POST /api/v1/device/protocol/next-stage");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Protocol management only available for incubator devices");
        return;
    }

    sendSuccess(request, "Advanced to next protocol stage");
}

// ============================================================================
// Alarm Management Endpoints (Incubator)
// ============================================================================

void HTTPServer::handleGetAlarms(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET /api/v1/device/alarms");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Alarm management only available for incubator devices");
        return;
    }

    // Get alarm data from device status
    JsonDocument statusDoc = device.getStatus();

    JsonDocument doc;
    if (statusDoc["alarms"].is<JsonObject>()) {
        doc["alarms"] = statusDoc["alarms"];
    } else {
        JsonObject alarms = doc["alarms"].to<JsonObject>();
        alarms["activeCount"] = 0;
        alarms["hasCritical"] = false;
    }

    sendJSON(request, 200, doc);
}

void HTTPServer::handleAcknowledgeAlarm(AsyncWebServerRequest* request, uint8_t* data, size_t len, size_t index, size_t total) {
    Logger::debug("HTTPServer: POST /api/v1/device/alarms/acknowledge");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Alarm management only available for incubator devices");
        return;
    }

    // Only process the final chunk
    if (index + len != total) {
        return;
    }

    JsonDocument doc;
    DeserializationError error = deserializeJson(doc, data, len);

    if (error) {
        sendError(request, 400, "Invalid JSON");
        return;
    }

    if (!doc["index"].is<uint8_t>()) {
        sendError(request, 400, "Missing or invalid 'index' field");
        return;
    }

    sendSuccess(request, "Alarm acknowledged");
}

void HTTPServer::handleAcknowledgeAllAlarms(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: POST /api/v1/device/alarms/acknowledge-all");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Alarm management only available for incubator devices");
        return;
    }

    sendSuccess(request, "All alarms acknowledged");
}

void HTTPServer::handleGetAlarmHistory(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET /api/v1/device/alarms/history");

    if (config.device.type != "INCUBATOR") {
        sendError(request, 400, "Alarm management only available for incubator devices");
        return;
    }

    JsonDocument doc;
    JsonArray history = doc["history"].to<JsonArray>();
    // Alarm history would come from device implementation

    sendJSON(request, 200, doc);
}

// ============================================================================
// Provisioning Page
// ============================================================================

void HTTPServer::handleProvisioningPage(AsyncWebServerRequest* request) {
    Logger::debug("HTTPServer: GET / (provisioning page)");

    String html = R"html(
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Axionyx Device Setup</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 400px;
            width: 100%;
            padding: 40px 30px;
        }
        h1 {
            color: #667eea;
            font-size: 28px;
            margin-bottom: 10px;
            text-align: center;
        }
        .subtitle {
            color: #666;
            text-align: center;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .device-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 25px;
        }
        .device-info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .device-info-item:last-child { margin-bottom: 0; }
        .device-info-label { color: #666; }
        .device-info-value { color: #333; font-weight: 600; }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }
        input, select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: border-color 0.3s;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }
        button:active {
            transform: translateY(0);
        }
        .message {
            padding: 12px;
            border-radius: 8px;
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
            display: none;
        }
        .message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>)html" + config.device.type + R"html( Setup</h1>
        <p class="subtitle">Configure your device's WiFi connection</p>

        <div class="device-info">
            <div class="device-info-item">
                <span class="device-info-label">Device ID:</span>
                <span class="device-info-value">)html" + config.device.id + R"html(</span>
            </div>
            <div class="device-info-item">
                <span class="device-info-label">Type:</span>
                <span class="device-info-value">)html" + config.device.type + R"html(</span>
            </div>
            <div class="device-info-item">
                <span class="device-info-label">Firmware:</span>
                <span class="device-info-value">)html" + config.device.firmwareVersion + R"html(</span>
            </div>
        </div>

        <form id="wifiForm">
            <div class="form-group">
                <label for="ssid">WiFi Network</label>
                <input type="text" id="ssid" name="ssid" placeholder="Enter WiFi network name" required>
                <small style="color: #666; font-size: 12px;">Enter the exact name of your WiFi network</small>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>

            <div class="form-group">
                <label for="mode">Connection Mode</label>
                <select id="mode" name="mode">
                    <option value="1">WiFi Only</option>
                    <option value="2">WiFi + Hotspot</option>
                </select>
            </div>

            <button type="submit">Connect to WiFi</button>
        </form>

        <div id="message" class="message"></div>
    </div>

    <script>
        document.getElementById('wifiForm').addEventListener('submit', async (e) => {
            e.preventDefault();

            const formData = {
                ssid: document.getElementById('ssid').value,
                password: document.getElementById('password').value,
                mode: parseInt(document.getElementById('mode').value)
            };

            try {
                const response = await fetch('/api/v1/wifi/configure', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(formData)
                });

                const data = await response.json();

                if (data.success) {
                    showMessage('WiFi configured! Device is connecting...', 'success');
                    setTimeout(() => {
                        showMessage('You can now close this page', 'success');
                    }, 3000);
                } else {
                    showMessage('Configuration failed: ' + data.error, 'error');
                }
            } catch (error) {
                showMessage('Failed to configure WiFi', 'error');
            }
        });

        function showMessage(text, type) {
            const messageDiv = document.getElementById('message');
            messageDiv.textContent = text;
            messageDiv.className = 'message ' + type;
            messageDiv.style.display = 'block';
        }
    </script>
</body>
</html>
)html";

    AsyncWebServerResponse* response = request->beginResponse(200, "text/html", html);
    request->send(response);
}
