# API Documentation

Complete API reference for Axionyx device communication and backend services.

---

## Overview

The Axionyx platform provides two primary APIs:

1. **Device API** (REST + WebSocket) - Direct communication with ESP32 devices
2. **Backend API** (REST) - Cloud services and user management (future)

This section covers all API endpoints, protocols, authentication, and usage examples.

---

## Quick Navigation

### REST API
- **[REST API Overview](rest-api/overview.md)** - Introduction and basics
- **[Authentication](rest-api/authentication.md)** - Device pairing and auth
- **[Device Endpoints](rest-api/device-endpoints.md)** - Control and status
- **[WiFi Endpoints](rest-api/wifi-endpoints.md)** - Network configuration
- **[Config Endpoints](rest-api/config-endpoints.md)** - Device configuration
- **[OTA Endpoints](rest-api/ota-endpoints.md)** - Firmware updates

### WebSocket
- **[WebSocket Overview](websocket/overview.md)** - Real-time protocol
- **[Telemetry](websocket/telemetry.md)** - Device telemetry streams
- **[Events](websocket/events.md)** - Event notifications
- **[Commands](websocket/commands.md)** - Bidirectional commands

### Backend API
- **[Backend Overview](backend-api/overview.md)** - Backend service API (future)
- **[Endpoints](backend-api/endpoints.md)** - Backend endpoints (future)

---

## Device API

### Connection Information

**Base URL:** `http://[device-ip]`

**Default Ports:**
- REST API: Port 80 (HTTP)
- WebSocket: Port 81

**Device Discovery:**
- Use mDNS to discover devices: `_axionyx._tcp.local`
- Access via IP address or hostname: `pcr-lab1.local`

### API Version

Current API version: **v1**

All endpoints use `/api/v1` prefix.

---

## REST API Quick Reference

### Device Management

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/device/info` | Get device metadata |
| GET | `/api/v1/device/status` | Get current status |
| POST | `/api/v1/device/start` | Start device operation |
| POST | `/api/v1/device/stop` | Stop device |
| POST | `/api/v1/device/pause` | Pause operation |
| POST | `/api/v1/device/resume` | Resume operation |
| PUT | `/api/v1/device/setpoint` | Update temperature setpoint |

### WiFi Configuration

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/wifi/status` | WiFi connection status |
| GET | `/api/v1/wifi/scan` | Scan available networks |
| POST | `/api/v1/wifi/configure` | Configure WiFi credentials |

### Configuration

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/config` | Get device configuration |
| POST | `/api/v1/config` | Update configuration |
| POST | `/api/v1/config/factory-reset` | Factory reset |

### OTA Updates

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/ota/update` | Trigger OTA update |
| GET | `/api/v1/ota/status` | OTA update status |

### Authentication

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/auth/pair` | Pair device with app |
| DELETE | `/api/v1/auth/unpair` | Unpair device |

---

## WebSocket Protocol

### Connection

**Endpoint:** `ws://[device-ip]:81`

**Connection Example:**
```javascript
const ws = new WebSocket('ws://192.168.1.100:81');

ws.onopen = () => {
  console.log('Connected to device');
};

ws.onmessage = (event) => {
  const data = JSON.parse(event.data);
  console.log('Received:', data);
};
```

### Message Types

**Server → Client:**
- `telemetry` - Real-time device data (1 Hz)
- `event` - Event notifications
- `response` - Command responses

**Client → Server:**
- `command` - Control commands
- `ping` - Keepalive ping

---

## Quick Examples

### Get Device Info

```bash
curl http://192.168.1.100/api/v1/device/info
```

**Response:**
```json
{
  "id": "PCR-A1B2C3D4",
  "type": "PCR",
  "name": "Lab PCR #1",
  "serialNumber": "AXN-PCR-2025-0001",
  "firmwareVersion": "1.0.0",
  "hardwareVersion": "1.0",
  "manufacturer": "Axionyx"
}
```

### Start Device

```bash
curl -X POST http://192.168.1.100/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{"setpoint": 95.0}'
```

**Response:**
```json
{
  "success": true,
  "message": "Device started successfully"
}
```

### Get Status

```bash
curl http://192.168.1.100/api/v1/device/status
```

**Response (PCR):**
```json
{
  "state": "RUNNING",
  "uptime": 1200,
  "temperature": [94.8, 72.1, 60.2],
  "setpoint": [95.0, 72.0, 60.0],
  "currentPhase": "DENATURE",
  "cycleNumber": 10,
  "totalCycles": 35,
  "progress": 28.5,
  "errors": []
}
```

### WebSocket Telemetry

**Server → Client:**
```json
{
  "type": "telemetry",
  "timestamp": 1704067200,
  "data": {
    "state": "RUNNING",
    "temperature": [94.8, 72.1, 60.2],
    "currentPhase": "ANNEAL",
    "cycleNumber": 10,
    "progress": 28.5
  }
}
```

---

## Authentication

### Pairing Workflow

1. **Generate pairing code** on device
2. **Request pairing** via API with code
3. **Receive JWT token** for authenticated access
4. **Include token** in subsequent requests

**Example:**
```bash
curl -X POST http://192.168.1.100/api/v1/auth/pair \
  -H "Content-Type: application/json" \
  -d '{"pairingCode": "123456"}'
```

**Response:**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "expiresIn": 86400
}
```

**Using Token (Future):**
```bash
curl http://192.168.1.100/api/v1/device/status \
  -H "Authorization: Token <your-auth-token>"
```

---

## Error Handling

### HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | Success |
| 400 | Bad Request - Invalid parameters |
| 401 | Unauthorized - Authentication required |
| 404 | Not Found - Endpoint doesn't exist |
| 500 | Internal Server Error |

### Error Response Format

```json
{
  "success": false,
  "error": {
    "code": "INVALID_PARAMETER",
    "message": "Temperature setpoint out of range",
    "details": {
      "parameter": "setpoint",
      "value": 150.0,
      "min": 0,
      "max": 120
    }
  }
}
```

### Common Error Codes

- `INVALID_PARAMETER` - Parameter validation failed
- `DEVICE_NOT_READY` - Device not in correct state
- `AUTH_REQUIRED` - Authentication needed
- `PAIRING_EXPIRED` - Pairing code expired
- `WIFI_ERROR` - WiFi configuration failed

See [Error Codes Reference](../reference/error-codes.md) for complete list.

---

## Rate Limiting

**REST API:**
- No rate limiting currently implemented
- Recommended: Max 10 requests/second per client

**WebSocket:**
- Telemetry: 1 Hz (1 message/second)
- Commands: Max 5/second recommended

---

## CORS Support

CORS is enabled for all origins by default during development.

**Allowed Headers:**
- `Content-Type`
- `Authorization`

**Allowed Methods:**
- `GET`, `POST`, `PUT`, `DELETE`, `OPTIONS`

---

## Testing Tools

### cURL
Command-line HTTP client for testing REST endpoints.

```bash
curl -v http://192.168.1.100/api/v1/device/info
```

### Postman
GUI tool for API testing with collections and environments.

### wscat
WebSocket testing tool:

```bash
npm install -g wscat
wscat -c ws://192.168.1.100:81
```

### Python Examples

```python
import requests
import websocket

# REST API
response = requests.get('http://192.168.1.100/api/v1/device/info')
print(response.json())

# WebSocket
ws = websocket.create_connection('ws://192.168.1.100:81')
while True:
    message = ws.recv()
    print(message)
```

---

## API Best Practices

1. **Use WebSocket for real-time data** - Don't poll REST endpoints
2. **Handle connection failures gracefully** - Implement reconnection logic
3. **Validate parameters** - Check ranges before sending
4. **Use authentication** - Pair devices for secure access
5. **Check device state** - Verify device is ready before commands
6. **Handle errors** - Parse error responses and show user-friendly messages

---

## Detailed Documentation

For comprehensive endpoint documentation:

- **[REST API](rest-api/overview.md)** - All REST endpoints with examples
- **[WebSocket](websocket/overview.md)** - WebSocket protocol details
- **[Authentication](rest-api/authentication.md)** - Security and pairing

---

## Backend API (Future)

The backend API will provide:
- User authentication and management
- Device fleet management
- Historical data storage
- Cloud-based monitoring
- API key management

Documentation coming soon.

---

[← Back to Documentation Home](../README.md)
