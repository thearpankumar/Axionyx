/**
 * DeviceAuth.cpp
 * Device authentication implementation
 * Part of Axionyx Biotech IoT Platform
 */

#include "DeviceAuth.h"
#include "../utils/Logger.h"
#include "../device/DeviceIdentity.h"
#include <mbedtls/md.h>

DeviceAuth::DeviceAuth(DeviceConfig& cfg)
    : config(cfg), pairingCodeExpiry(0) {
}

String DeviceAuth::generatePairingCode() {
    if (!config.auth.pairingEnabled) {
        Logger::warning("DeviceAuth: Pairing is disabled");
        return "";
    }

    // Generate a 6-digit pairing code
    currentPairingCode = generateRandomCode(6);
    pairingCodeExpiry = millis() + PAIRING_CODE_VALIDITY;

    Logger::info("DeviceAuth: Generated pairing code: " + currentPairingCode);
    Logger::info("DeviceAuth: Code expires in " + String(PAIRING_CODE_VALIDITY / 1000) + " seconds");

    return currentPairingCode;
}

bool DeviceAuth::validatePairingCode(const String& code) {
    // Check if pairing is enabled
    if (!config.auth.pairingEnabled) {
        Logger::warning("DeviceAuth: Pairing is disabled");
        return false;
    }

    // Check if code has expired
    if (millis() > pairingCodeExpiry) {
        Logger::warning("DeviceAuth: Pairing code expired");
        currentPairingCode = "";
        return false;
    }

    // Validate code
    bool valid = (code == currentPairingCode);

    if (valid) {
        Logger::info("DeviceAuth: Pairing code validated successfully");
        currentPairingCode = "";  // Clear code after successful use
    } else {
        Logger::warning("DeviceAuth: Invalid pairing code");
    }

    return valid;
}

String DeviceAuth::generateAuthToken(const String& appId) {
    Logger::info("DeviceAuth: Generating auth token for app: " + appId);

    // Create a simple token (in production, use JWT)
    String tokenData = appId + ":" + config.device.id + ":" + String(millis());
    String token = hashString(tokenData);

    // Store the paired device
    if (!isPaired(appId)) {
        config.auth.allowedDevices.push_back(appId);
        config.save();
        Logger::info("DeviceAuth: App paired successfully");
    }

    return token;
}

bool DeviceAuth::validateAuthToken(const String& token) {
    // Simple token validation (in production, use proper JWT validation)
    if (token.length() == 0) {
        return false;
    }

    // For demo purposes, accept any non-empty token
    // In production, verify JWT signature and expiry
    return true;
}

void DeviceAuth::unpair(const String& appId) {
    Logger::info("DeviceAuth: Unpairing app: " + appId);

    // Remove from allowed devices
    auto it = std::find(config.auth.allowedDevices.begin(),
                       config.auth.allowedDevices.end(),
                       appId);

    if (it != config.auth.allowedDevices.end()) {
        config.auth.allowedDevices.erase(it);
        config.save();
        Logger::info("DeviceAuth: App unpaired successfully");
    } else {
        Logger::warning("DeviceAuth: App not found in paired devices");
    }
}

bool DeviceAuth::isPaired(const String& appId) const {
    return std::find(config.auth.allowedDevices.begin(),
                    config.auth.allowedDevices.end(),
                    appId) != config.auth.allowedDevices.end();
}

void DeviceAuth::clearAllTokens() {
    Logger::warning("DeviceAuth: Clearing all paired devices");
    config.auth.allowedDevices.clear();
    config.save();
}

std::vector<String> DeviceAuth::getPairedDevices() const {
    return config.auth.allowedDevices;
}

String DeviceAuth::generateRandomCode(uint8_t length) {
    String code = "";
    for (uint8_t i = 0; i < length; i++) {
        code += String(random(0, 10));
    }
    return code;
}

String DeviceAuth::hashString(const String& input) {
    // Simple hash using mbedtls SHA256
    byte hash[32];
    mbedtls_md_context_t ctx;
    mbedtls_md_type_t md_type = MBEDTLS_MD_SHA256;

    mbedtls_md_init(&ctx);
    mbedtls_md_setup(&ctx, mbedtls_md_info_from_type(md_type), 0);
    mbedtls_md_starts(&ctx);
    mbedtls_md_update(&ctx, (const unsigned char*)input.c_str(), input.length());
    mbedtls_md_finish(&ctx, hash);
    mbedtls_md_free(&ctx);

    // Convert to hex string
    String hashStr = "";
    for (int i = 0; i < 32; i++) {
        char hex[3];
        sprintf(hex, "%02x", hash[i]);
        hashStr += hex;
    }

    return hashStr;
}
