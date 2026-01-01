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
