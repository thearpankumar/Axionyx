/**
 * Config.cpp
 * Configuration management implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "Config.h"
#include "../utils/Logger.h"
#include <ArduinoJson.h>
#include <SPIFFS.h>

const char* DeviceConfig::CONFIG_FILE = "/config.json";

DeviceConfig::DeviceConfig() {
    setDefaults();
}

void DeviceConfig::setDefaults() {
    // Device defaults will be set by specific device implementations
    device = Device();
    wifi = WiFi();
    network = Network();
    auth = Auth();
    deviceSettings = DeviceSettings();
}

bool DeviceConfig::load() {
    if (!SPIFFS.begin(true)) {
        Logger::error("Failed to mount SPIFFS");
        return false;
    }

    if (!SPIFFS.exists(CONFIG_FILE)) {
        Logger::warning("Config file does not exist, using defaults");
        return false;
    }

    File file = SPIFFS.open(CONFIG_FILE, "r");
    if (!file) {
        Logger::error("Failed to open config file for reading");
        return false;
    }

    String jsonStr = file.readString();
    file.close();

    bool result = fromJSON(jsonStr);
    if (result) {
        Logger::info("Configuration loaded successfully");
    } else {
        Logger::error("Failed to parse configuration");
    }

    return result;
}

bool DeviceConfig::save() {
    if (!SPIFFS.begin(true)) {
        Logger::error("Failed to mount SPIFFS");
        return false;
    }

    String jsonStr = toJSON();

    File file = SPIFFS.open(CONFIG_FILE, "w");
    if (!file) {
        Logger::error("Failed to open config file for writing");
        return false;
    }

    size_t bytesWritten = file.print(jsonStr);
    file.close();

    if (bytesWritten > 0) {
        Logger::info("Configuration saved successfully");
        return true;
    } else {
        Logger::error("Failed to write configuration");
        return false;
    }
}

void DeviceConfig::reset() {
    Logger::info("Performing factory reset");

    if (SPIFFS.begin(true)) {
        if (SPIFFS.exists(CONFIG_FILE)) {
            SPIFFS.remove(CONFIG_FILE);
        }
    }

    setDefaults();
}

String DeviceConfig::toJSON() const {
    JsonDocument doc;

    // Device information
    JsonObject deviceObj = doc["device"].to<JsonObject>();
    deviceObj["id"] = device.id;
    deviceObj["type"] = device.type;
    deviceObj["name"] = device.name;
    deviceObj["serialNumber"] = device.serialNumber;
    deviceObj["firmwareVersion"] = device.firmwareVersion;

    // WiFi configuration
    JsonObject wifiObj = doc["wifi"].to<JsonObject>();
    wifiObj["mode"] = static_cast<int>(wifi.mode);
    wifiObj["ssid"] = wifi.ssid;
    wifiObj["password"] = wifi.password; // TODO: Encrypt in production
    wifiObj["apSSID"] = wifi.apSSID;
    wifiObj["apPassword"] = wifi.apPassword;
    wifiObj["staticIP"] = wifi.staticIP;
    wifiObj["ip"] = wifi.ip;
    wifiObj["gateway"] = wifi.gateway;
    wifiObj["subnet"] = wifi.subnet;

    // Network configuration
    JsonObject networkObj = doc["network"].to<JsonObject>();
    networkObj["httpPort"] = network.httpPort;
    networkObj["wsPort"] = network.wsPort;
    networkObj["mdnsEnabled"] = network.mdnsEnabled;
    networkObj["mdnsName"] = network.mdnsName;

    // Auth configuration
    JsonObject authObj = doc["auth"].to<JsonObject>();
    authObj["pairingEnabled"] = auth.pairingEnabled;
    authObj["pairingToken"] = auth.pairingToken;
    JsonArray allowedDevicesArr = authObj["allowedDevices"].to<JsonArray>();
    for (const String& deviceId : auth.allowedDevices) {
        allowedDevicesArr.add(deviceId);
    }

    // Device settings
    JsonObject settingsObj = doc["device_config"].to<JsonObject>();
    settingsObj["updateInterval"] = deviceSettings.updateInterval;
    settingsObj["sensorPollingRate"] = deviceSettings.sensorPollingRate;

    String jsonStr;
    serializeJsonPretty(doc, jsonStr);
    return jsonStr;
}

bool DeviceConfig::fromJSON(const String& json) {
    JsonDocument doc;
    DeserializationError error = deserializeJson(doc, json);

    if (error) {
        Logger::error("JSON parse error: " + String(error.c_str()));
        return false;
    }

    // Device information
    if (doc.containsKey("device")) {
        JsonObject deviceObj = doc["device"];
        device.id = deviceObj["id"] | "";
        device.type = deviceObj["type"] | "";
        device.name = deviceObj["name"] | "";
        device.serialNumber = deviceObj["serialNumber"] | "";
        device.firmwareVersion = deviceObj["firmwareVersion"] | "1.0.0";
    }

    // WiFi configuration
    if (doc.containsKey("wifi")) {
        JsonObject wifiObj = doc["wifi"];
        wifi.mode = static_cast<WiFiMode>(wifiObj["mode"] | AP_ONLY);
        wifi.ssid = wifiObj["ssid"] | "";
        wifi.password = wifiObj["password"] | "";
        wifi.apSSID = wifiObj["apSSID"] | "";
        wifi.apPassword = wifiObj["apPassword"] | "axionyx123";
        wifi.staticIP = wifiObj["staticIP"] | false;
        wifi.ip = wifiObj["ip"] | "";
        wifi.gateway = wifiObj["gateway"] | "";
        wifi.subnet = wifiObj["subnet"] | "";
    }

    // Network configuration
    if (doc.containsKey("network")) {
        JsonObject networkObj = doc["network"];
        network.httpPort = networkObj["httpPort"] | 80;
        network.wsPort = networkObj["wsPort"] | 81;
        network.mdnsEnabled = networkObj["mdnsEnabled"] | true;
        network.mdnsName = networkObj["mdnsName"] | "";
    }

    // Auth configuration
    if (doc.containsKey("auth")) {
        JsonObject authObj = doc["auth"];
        auth.pairingEnabled = authObj["pairingEnabled"] | true;
        auth.pairingToken = authObj["pairingToken"] | "";

        auth.allowedDevices.clear();
        if (authObj.containsKey("allowedDevices")) {
            JsonArray allowedDevicesArr = authObj["allowedDevices"];
            for (JsonVariant deviceId : allowedDevicesArr) {
                auth.allowedDevices.push_back(deviceId.as<String>());
            }
        }
    }

    // Device settings
    if (doc.containsKey("device_config")) {
        JsonObject settingsObj = doc["device_config"];
        deviceSettings.updateInterval = settingsObj["updateInterval"] | 1000;
        deviceSettings.sensorPollingRate = settingsObj["sensorPollingRate"] | 500;
    }

    return true;
}
