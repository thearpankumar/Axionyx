/**
 * OTAManager.h
 * Over-the-air firmware update manager
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef OTA_MANAGER_H
#define OTA_MANAGER_H

#include <Arduino.h>
#include <ArduinoOTA.h>
#include <Update.h>
#include <functional>

class OTAManager {
public:
    OTAManager();

    void begin();
    void loop();

    // HTTP-based OTA update
    bool startUpdate(const String& url);
    bool isUpdating() const { return updating; }
    uint8_t getProgress() const { return progress; }
    String getError() const { return error; }

    // Progress callback
    void setProgressCallback(std::function<void(uint8_t)> callback);

private:
    bool updating;
    uint8_t progress;
    String updateURL;
    String error;
    std::function<void(uint8_t)> progressCallback;

    // ArduinoOTA callbacks
    void onStart();
    void onEnd();
    void onProgress(unsigned int current, unsigned int total);
    void onError(ota_error_t error);
};

#endif // OTA_MANAGER_H
