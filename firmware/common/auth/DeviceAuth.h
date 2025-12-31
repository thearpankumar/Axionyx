/**
 * DeviceAuth.h
 * Device pairing and authentication system
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef DEVICE_AUTH_H
#define DEVICE_AUTH_H

#include <Arduino.h>
#include <vector>
#include "../config/Config.h"

class DeviceAuth {
public:
    DeviceAuth(DeviceConfig& config);

    // Pairing methods
    String generatePairingCode();
    bool validatePairingCode(const String& code);
    String generateAuthToken(const String& appId);
    bool validateAuthToken(const String& token);
    void unpair(const String& appId);
    bool isPaired(const String& appId) const;

    // Token management
    void clearAllTokens();
    std::vector<String> getPairedDevices() const;

private:
    DeviceConfig& config;
    String currentPairingCode;
    unsigned long pairingCodeExpiry;
    static const unsigned long PAIRING_CODE_VALIDITY = 300000; // 5 minutes

    // Helper methods
    String generateRandomCode(uint8_t length);
    String hashString(const String& input);
};

#endif // DEVICE_AUTH_H
