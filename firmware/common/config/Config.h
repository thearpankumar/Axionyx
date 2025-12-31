/**
 * Config.h
 * Configuration management for ESP32 devices
 * Part of Axionyx Biotech IoT Platform
 */

#ifndef CONFIG_H
#define CONFIG_H

#include <Arduino.h>
#include <IPAddress.h>
#include <vector>

class DeviceConfig {
public:
    // WiFi operation modes
    enum WiFiMode {
        AP_ONLY = 0,      // Access Point only
        STA_ONLY = 1,     // Station only
        AP_STA_DUAL = 2   // Both AP and Station
    };

    // Device information structure
    struct Device {
        String id;              // Unique device ID (e.g., "PCR-A1B2C3D4")
        String type;            // Device type ("PCR", "INCUBATOR", "DUMMY")
        String name;            // User-friendly name
        String serialNumber;    // Serial number
        String firmwareVersion; // Firmware version

        Device() : firmwareVersion("1.0.0") {}
    };

    // WiFi configuration structure
    struct WiFi {
        WiFiMode mode;          // WiFi operation mode
        String ssid;            // Station mode SSID
        String password;        // Station mode password
        String apSSID;          // Access Point SSID
        String apPassword;      // Access Point password
        bool staticIP;          // Use static IP for station mode
        String ip;              // Static IP address
        String gateway;         // Gateway address
        String subnet;          // Subnet mask

        WiFi() : mode(AP_ONLY), staticIP(false),
                 apPassword("axionyx123") {}
    };

    // Network services configuration
    struct Network {
        uint16_t httpPort;      // HTTP server port
        uint16_t wsPort;        // WebSocket server port
        bool mdnsEnabled;       // Enable mDNS discovery
        String mdnsName;        // mDNS hostname

        Network() : httpPort(80), wsPort(81), mdnsEnabled(true) {}
    };

    // Authentication configuration
    struct Auth {
        bool pairingEnabled;    // Enable device pairing
        String pairingToken;    // Current pairing token
        std::vector<String> allowedDevices; // List of paired device IDs

        Auth() : pairingEnabled(true) {}
    };

    // Device-specific configuration
    struct DeviceSettings {
        uint16_t updateInterval;      // Telemetry update interval (ms)
        uint16_t sensorPollingRate;   // Sensor polling rate (ms)

        DeviceSettings() : updateInterval(1000), sensorPollingRate(500) {}
    };

    // Configuration data
    Device device;
    WiFi wifi;
    Network network;
    Auth auth;
    DeviceSettings deviceSettings;

    // Configuration management methods
    DeviceConfig();
    bool load();                  // Load from SPIFFS
    bool save();                  // Save to SPIFFS
    void reset();                 // Factory reset to defaults
    String toJSON() const;        // Serialize to JSON
    bool fromJSON(const String& json); // Deserialize from JSON

private:
    static const char* CONFIG_FILE;
    void setDefaults();
};

#endif // CONFIG_H
