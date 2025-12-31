/**
 * OTAManager.cpp
 * OTA update implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "OTAManager.h"
#include "../utils/Logger.h"

OTAManager::OTAManager()
    : updating(false), progress(0), progressCallback(nullptr) {
}

void OTAManager::begin() {
    Logger::info("OTAManager: Initializing OTA updates");

    // Set up ArduinoOTA
    ArduinoOTA.setHostname("axionyx-device");

    // Set callbacks
    ArduinoOTA.onStart([this]() { onStart(); });
    ArduinoOTA.onEnd([this]() { onEnd(); });
    ArduinoOTA.onProgress([this](unsigned int current, unsigned int total) {
        onProgress(current, total);
    });
    ArduinoOTA.onError([this](ota_error_t error) {
        onError(error);
    });

    // Start OTA service
    ArduinoOTA.begin();

    Logger::info("OTAManager: OTA service started");
    Logger::info("OTAManager: Ready for network-based firmware updates");
}

void OTAManager::loop() {
    // Handle ArduinoOTA
    ArduinoOTA.handle();
}

bool OTAManager::startUpdate(const String& url) {
    Logger::info("OTAManager: Starting HTTP OTA update from " + url);

    // HTTP-based OTA would be implemented here
    // For now, we support network OTA via ArduinoOTA
    // HTTP OTA requires additional implementation with HTTPUpdate library

    error = "HTTP OTA not yet implemented. Use network OTA via Arduino IDE or PlatformIO.";
    Logger::warning("OTAManager: " + error);

    return false;
}

void OTAManager::setProgressCallback(std::function<void(uint8_t)> callback) {
    progressCallback = callback;
}

void OTAManager::onStart() {
    String type;
    if (ArduinoOTA.getCommand() == U_FLASH) {
        type = "sketch";
    } else { // U_SPIFFS
        type = "filesystem";
    }

    Logger::info("OTAManager: Starting update (" + type + ")");
    updating = true;
    progress = 0;
    error = "";
}

void OTAManager::onEnd() {
    Logger::info("OTAManager: Update complete!");
    updating = false;
    progress = 100;
}

void OTAManager::onProgress(unsigned int current, unsigned int total) {
    progress = (current * 100) / total;

    // Log every 10%
    static uint8_t lastReportedProgress = 0;
    if (progress - lastReportedProgress >= 10) {
        Logger::info("OTAManager: Progress: " + String(progress) + "%");
        lastReportedProgress = progress;
    }

    // Call user callback if set
    if (progressCallback) {
        progressCallback(progress);
    }
}

void OTAManager::onError(ota_error_t err) {
    updating = false;
    progress = 0;

    switch (err) {
        case OTA_AUTH_ERROR:
            error = "Auth Failed";
            break;
        case OTA_BEGIN_ERROR:
            error = "Begin Failed";
            break;
        case OTA_CONNECT_ERROR:
            error = "Connect Failed";
            break;
        case OTA_RECEIVE_ERROR:
            error = "Receive Failed";
            break;
        case OTA_END_ERROR:
            error = "End Failed";
            break;
        default:
            error = "Unknown Error";
            break;
    }

    Logger::error("OTAManager: Update failed - " + error);
}
