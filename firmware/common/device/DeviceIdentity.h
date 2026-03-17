/**
 * DeviceIdentity.h
 * Device identification and metadata generation
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef DEVICE_IDENTITY_H
#define DEVICE_IDENTITY_H

#include <Arduino.h>
#ifdef ESP32
  #include <esp_system.h>
  #include <WiFi.h>
#else
  #include <ESP8266WiFi.h>
#endif

class DeviceIdentity {
public:
    /**
     * Get the ESP32 chip ID as a hex string
     * @return Chip ID (e.g., "A1B2C3D4")
     */
    static String getChipID() {
#ifdef ESP32
        uint64_t chipid = ESP.getEfuseMac();
        char chipidStr[9];
        snprintf(chipidStr, sizeof(chipidStr), "%08X", (uint32_t)chipid);
        return String(chipidStr);
#else
        char chipidStr[9];
        snprintf(chipidStr, sizeof(chipidStr), "%08X", ESP.getChipId());
        return String(chipidStr);
#endif
    }

    /**
     * Generate a unique device ID
     * @param type Device type (e.g., "PCR", "INCUBATOR")
     * @return Device ID (e.g., "PCR-A1B2C3D4")
     */
    static String getDeviceID(const String& type) {
        return type + "-" + getChipID();
    }

    /**
     * Generate a serial number for the device
     * @param type Device type
     * @return Serial number (e.g., "AXN-PCR-2025-00000001")
     */
    static String generateSerialNumber(const String& type) {
        // In production, this would use a database or counter
        // For demo, we use chip ID as unique identifier
        String chipID = getChipID();
        return "AXN-" + type + "-2025-" + chipID;
    }

    /**
     * Get firmware version
     * @return Firmware version string
     */
    static String getFirmwareVersion() {
        return "1.2.1";
    }

    /**
     * Get MAC address
     * @return MAC address as string
     */
    static String getMAC() {
        return WiFi.macAddress();
    }

    /**
     * Generate Access Point SSID
     * @param type Device type
     * @return AP SSID (e.g., "Axionyx-PCR-A1B2C3")
     */
    static String generateAPSSID(const String& type) {
        String chipID = getChipID();
        // Use last 6 characters of chip ID for brevity
        String shortID = chipID.substring(chipID.length() - 6);
        return "Axionyx-" + type + "-" + shortID;
    }

    /**
     * Generate mDNS hostname
     * @param type Device type
     * @return mDNS hostname (e.g., "axionyx-pcr-a1b2c3")
     */
    static String generateMDNSName(const String& type) {
        String chipID = getChipID();
        String shortID = chipID.substring(chipID.length() - 6);
        String name = "axionyx-" + type + "-" + shortID;
        name.toLowerCase();
        return name;
    }

    /**
     * Get free heap memory
     * @return Free heap in bytes
     */
    static uint32_t getFreeHeap() {
        return ESP.getFreeHeap();
    }

    /**
     * Get total heap size
     * @return Total heap in bytes
     */
    static uint32_t getHeapSize() {
#ifdef ESP32
        return ESP.getHeapSize();
#else
        return 81920; // ESP8266 typical heap size
#endif
    }
};

#endif // DEVICE_IDENTITY_H
