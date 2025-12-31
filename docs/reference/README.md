# Reference Documentation

Complete API references, configuration options, error codes, and technical glossary.

---

## Overview

This section provides detailed reference documentation for all APIs, configurations, and technical specifications. Use this as a quick lookup guide for specific parameters, error codes, and technical terms.

---

## Quick Navigation

### API References
- **[Firmware API Reference](firmware-api.md)** - Complete firmware API
- **[Backend API Reference](backend-api.md)** - Backend service API

### Configuration
- **[Configuration Reference](configuration.md)** - All configuration options

### Troubleshooting
- **[Error Codes](error-codes.md)** - Error codes and solutions

### Glossary
- **[Technical Glossary](glossary.md)** - Terms and definitions

---

## Firmware API Reference

### DeviceBase Class

**[Complete Firmware API](firmware-api.md)**

Base class for all devices providing common interface.

**Methods:**
```cpp
virtual bool begin() = 0;
virtual void loop() = 0;
virtual JsonDocument getStatus() const = 0;
virtual bool start(const JsonDocument& params) = 0;
virtual bool stop() = 0;
virtual bool pause() = 0;
virtual bool resume() = 0;
virtual bool setSetpoint(uint8_t zone, float temperature) = 0;
```

### REST API Endpoints

**Device Control:**
- `GET /api/v1/device/info` - Device information
- `GET /api/v1/device/status` - Current status
- `POST /api/v1/device/start` - Start device
- `POST /api/v1/device/stop` - Stop device
- `POST /api/v1/device/pause` - Pause device
- `POST /api/v1/device/resume` - Resume device
- `PUT /api/v1/device/setpoint` - Set temperature

**WiFi:**
- `GET /api/v1/wifi/status` - WiFi status
- `GET /api/v1/wifi/scan` - Scan networks
- `POST /api/v1/wifi/configure` - Configure WiFi

**Configuration:**
- `GET /api/v1/config` - Get configuration
- `POST /api/v1/config` - Update configuration
- `POST /api/v1/config/factory-reset` - Factory reset

See [Firmware API Reference](firmware-api.md) for complete details.

---

## Backend API Reference

**[Complete Backend API](backend-api.md)**

Backend service endpoints (future implementation).

**Planned Endpoints:**
- User authentication
- Device registration
- Historical data queries
- Fleet management

---

## Configuration Reference

**[Complete Configuration](configuration.md)**

All configuration options for devices and applications.

### Device Configuration (config.json)

```json
{
  "device": {
    "id": "PCR-A1B2C3D4",
    "type": "PCR",
    "name": "Lab PCR #1",
    "serialNumber": "AXN-PCR-2025-0001",
    "firmwareVersion": "1.0.0"
  },
  "wifi": {
    "mode": 2,
    "ssid": "LabNetwork",
    "password": "[encrypted]",
    "apSSID": "Axionyx-PCR-A1B2C3",
    "apPassword": "axionyx123"
  },
  "network": {
    "httpPort": 80,
    "wsPort": 81,
    "mdnsEnabled": true,
    "mdnsName": "pcr-lab1"
  }
}
```

**Configuration Fields:**

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `device.id` | string | Auto-generated | Unique device ID |
| `device.type` | string | Required | Device type |
| `device.name` | string | Generated | User-friendly name |
| `wifi.mode` | int | 2 | WiFi mode (0=AP, 1=STA, 2=Dual) |
| `wifi.ssid` | string | "" | WiFi network SSID |
| `network.httpPort` | int | 80 | HTTP server port |
| `network.wsPort` | int | 81 | WebSocket port |

See [Configuration Reference](configuration.md) for all options.

---

## Error Codes

**[Complete Error Code List](error-codes.md)**

All error codes with descriptions and solutions.

### Common Error Codes

| Code | Message | Solution |
|------|---------|----------|
| `WIFI_CONNECT_FAILED` | Failed to connect to WiFi | Check SSID/password |
| `INVALID_PARAMETER` | Parameter out of range | Check value limits |
| `DEVICE_NOT_READY` | Device not in correct state | Stop and restart |
| `AUTH_REQUIRED` | Authentication needed | Pair device first |
| `PAIRING_EXPIRED` | Pairing code expired | Generate new code |

### HTTP Status Codes

| Code | Meaning | Common Causes |
|------|---------|---------------|
| 200 | Success | Request completed |
| 400 | Bad Request | Invalid parameters |
| 401 | Unauthorized | Auth required |
| 404 | Not Found | Invalid endpoint |
| 500 | Server Error | Internal error |

See [Error Codes](error-codes.md) for complete list with troubleshooting steps.

---

## Technical Glossary

**[Complete Glossary](glossary.md)**

Definitions of technical terms used in Axionyx.

### Key Terms

**AP Mode (Access Point):** ESP32 acts as WiFi hotspot that other devices connect to.

**Captive Portal:** Automatic redirect to provisioning page when connecting to device WiFi.

**DeviceBase:** Abstract base class that all device types inherit from.

**Dual Mode:** ESP32 operates as both AP and Station simultaneously.

**mDNS (Multicast DNS):** Protocol for zero-configuration device discovery on local networks.

**OTA (Over-The-Air):** Wireless firmware update mechanism.

**PID Control:** Proportional-Integral-Derivative control algorithm for temperature regulation.

**SPIFFS (SPI Flash File System):** Flash-based filesystem for configuration storage.

**STA Mode (Station):** ESP32 connects to existing WiFi network as a client.

**Telemetry:** Real-time device data broadcast via WebSocket.

**WebSocket:** Protocol for bidirectional real-time communication.

See [Glossary](glossary.md) for all terms.

---

## Quick Reference Tables

### WiFi Modes

| Mode | Value | Description |
|------|-------|-------------|
| AP_ONLY | 0 | Access Point only (local control) |
| STA_ONLY | 1 | Station only (connected to WiFi) |
| AP_STA_DUAL | 2 | Both AP and Station (dual mode) |

### Device States

| State | Description |
|-------|-------------|
| IDLE | Device ready, not running |
| STARTING | Device initializing |
| RUNNING | Device actively running |
| PAUSED | Device paused, can resume |
| STOPPING | Device shutting down |
| ERROR | Device in error state |

### WiFi States

| State | Description |
|-------|-------------|
| WIFI_INIT | Initializing WiFi |
| WIFI_AP_MODE | Running as access point |
| WIFI_CONNECTING | Connecting to network |
| WIFI_CONNECTED | Connected to WiFi |
| WIFI_RECONNECT | Reconnecting after failure |

### PCR Phases

| Phase | Temperature | Duration |
|-------|-------------|----------|
| INITIAL_DENATURE | 95°C | 180s |
| DENATURE | 95°C | 30s |
| ANNEAL | 60°C | 30s |
| EXTEND | 72°C | 60s |
| FINAL_EXTEND | 72°C | 300s |
| HOLD | 4°C | Indefinite |

### Temperature Ranges

| Device | Min | Max | Precision |
|--------|-----|-----|-----------|
| PCR Machine | 4°C | 120°C | ±0.5°C |
| Incubator | 4°C | 50°C | ±0.5°C |
| Dummy Device | 0°C | 120°C | ±0.1°C |

---

## Data Types

### Common JSON Structures

**Device Info:**
```json
{
  "id": "string",
  "type": "string",
  "name": "string",
  "serialNumber": "string",
  "firmwareVersion": "string"
}
```

**Device Status:**
```json
{
  "state": "string",
  "uptime": number,
  "temperature": number | number[],
  "errors": string[]
}
```

**WiFi Status:**
```json
{
  "mode": number,
  "state": string,
  "ssid": "string",
  "rssi": number,
  "connected": boolean
}
```

---

## Performance Metrics

### Timing Specifications

| Operation | Target | Typical |
|-----------|--------|---------|
| API Response | <100ms | 20-50ms |
| WiFi Connect | <10s | 2-5s |
| WebSocket Latency | <50ms | 10-20ms |
| mDNS Discovery | <1s | 200-500ms |
| Temperature Update | 100ms | 100ms |
| Telemetry Broadcast | 1s | 1s |

### Resource Limits

| Resource | Limit | Current Usage |
|----------|-------|---------------|
| RAM (ESP32) | 520 KB | ~200 KB |
| Flash | 4 MB | ~1 MB |
| WebSocket Clients | 4 | - |
| API Requests/sec | 10 | - |
| Config File Size | 16 KB | ~2 KB |

---

## Version Information

### Current Versions

- **Firmware:** 1.0.0
- **API Version:** v1
- **Backend:** (Future)
- **Frontend:** (In development)
- **Mobile:** (In development)

### Version Compatibility

| Firmware | API | App Version |
|----------|-----|-------------|
| 1.0.0 | v1 | 1.0.0+ |
| 1.1.0 | v1 | 1.0.0+ |
| 2.0.0 | v2 | 2.0.0+ |

---

## Standards and Compliance

### Network Protocols

- **HTTP:** RFC 7230-7235
- **WebSocket:** RFC 6455
- **mDNS:** RFC 6762
- **DNS-SD:** RFC 6763
- **JSON:** RFC 8259

### WiFi Standards

- **802.11b:** 1999
- **802.11g:** 2003
- **802.11n:** 2009

### Security

- **WPA2:** IEEE 802.11i
- **JWT:** RFC 7519
- **SHA256:** FIPS 180-4

---

## Additional Resources

- **[API Documentation](../api/README.md)** - Complete API guides
- **[Architecture](../architecture/README.md)** - System architecture
- **[User Guide](../user-guide/README.md)** - End-user documentation
- **[Development](../development/README.md)** - Development guides

---

[← Back to Documentation Home](../README.md)
