# REST API Overview

**ESP32 Device HTTP REST API**

Complete reference for the Axionyx device REST API.

---

## Base URL

All API requests use the following base URL:

```
http://[device-ip]/api/v1
```

**Default IPs:**
- AP Mode: `http://192.168.4.1/api/v1`
- STA Mode: Check serial monitor for assigned IP

---

## API Version

Current API version: **v1**

All endpoints are prefixed with `/api/v1/`

---

## Request Format

### Headers

```http
Content-Type: application/json
Authorization: Bearer <token>  (future - authentication)
```

### Request Body

All POST/PUT requests accept JSON:

```json
{
  "parameter": "value",
  "nested": {
    "field": "value"
  }
}
```

---

## Response Format

### Success Response

```json
{
  "success": true,
  "data": {
    "field": "value"
  },
  "message": "Operation completed successfully"
}
```

### Error Response

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": {
      "parameter": "additional info"
    }
  }
}
```

---

## HTTP Status Codes

| Code | Meaning | Usage |
|------|---------|-------|
| 200 | OK | Request successful |
| 400 | Bad Request | Invalid parameters |
| 401 | Unauthorized | Authentication required (future) |
| 404 | Not Found | Endpoint doesn't exist |
| 500 | Internal Server Error | Server-side error |

---

## API Categories

### Device Management

Control and monitor device operations.

**Endpoints:**
- `GET /device/info` - Device metadata
- `GET /device/status` - Current state and sensors
- `POST /device/start` - Start device operation
- `POST /device/stop` - Stop device
- `POST /device/pause` - Pause device
- `POST /device/resume` - Resume device
- `PUT /device/setpoint` - Adjust temperature setpoint

See [Device Endpoints](device-endpoints.md) for details.

### WiFi Configuration

Configure network connectivity.

**Endpoints:**
- `GET /wifi/status` - Connection status and RSSI
- `GET /wifi/scan` - Scan available networks
- `POST /wifi/configure` - Configure WiFi credentials

See [WiFi Endpoints](wifi-endpoints.md) for details.

### Configuration Management

Manage device configuration.

**Endpoints:**
- `GET /config` - Get device configuration
- `POST /config` - Update configuration
- `POST /config/factory-reset` - Reset to defaults

See [Config Endpoints](config-endpoints.md) for details.

### OTA Updates

Over-the-air firmware updates (future).

**Endpoints:**
- `POST /ota/update` - Trigger firmware update
- `GET /ota/status` - Update progress

See [OTA Endpoints](ota-endpoints.md) for details.

---

## CORS Support

CORS is enabled for cross-origin requests:

**Allowed Origins:** `*` (all origins)
**Allowed Methods:** `GET, POST, PUT, DELETE, OPTIONS`
**Allowed Headers:** `Content-Type, Authorization`

---

## Rate Limiting

**Current:** No rate limiting implemented

**Recommended:** Max 10 requests/second per client

---

## Common Patterns

### Checking Device Status

```bash
curl http://192.168.4.1/api/v1/device/status
```

### Starting a Device

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{"setpoint": 95.0}'
```

### Configuring WiFi

```bash
curl -X POST http://192.168.4.1/api/v1/wifi/configure \
  -H "Content-Type: application/json" \
  -d '{
    "ssid": "YourNetwork",
    "password": "YourPassword",
    "mode": 1
  }'
```

---

## Error Handling

### Common Errors

**Invalid JSON:**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_JSON",
    "message": "Request body is not valid JSON"
  }
}
```

**Parameter Out of Range:**
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

**Device Not Ready:**
```json
{
  "success": false,
  "error": {
    "code": "DEVICE_NOT_READY",
    "message": "Device must be stopped before changing configuration"
  }
}
```

See [Error Codes Reference](../../reference/error-codes.md) for complete list.

---

## Testing the API

### Using cURL

```bash
# GET request
curl http://192.168.4.1/api/v1/device/info

# POST request with JSON
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{"setpoint": 95.0}'

# Verbose output
curl -v http://192.168.4.1/api/v1/device/status
```

### Using Postman

1. Create new request
2. Set method (GET/POST/PUT)
3. Enter URL: `http://192.168.4.1/api/v1/device/info`
4. Add headers: `Content-Type: application/json`
5. Add body (for POST/PUT): Raw JSON
6. Send request

### Using Python

```python
import requests
import json

# GET request
response = requests.get('http://192.168.4.1/api/v1/device/info')
print(response.json())

# POST request
data = {'setpoint': 95.0}
response = requests.post(
    'http://192.168.4.1/api/v1/device/start',
    headers={'Content-Type': 'application/json'},
    json=data
)
print(response.json())
```

### Using JavaScript

```javascript
// GET request
fetch('http://192.168.4.1/api/v1/device/info')
  .then(response => response.json())
  .then(data => console.log(data));

// POST request
fetch('http://192.168.4.1/api/v1/device/start', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({ setpoint: 95.0 }),
})
  .then(response => response.json())
  .then(data => console.log(data));
```

---

## Best Practices

1. **Always check device state** before sending commands
2. **Handle errors gracefully** - parse error responses
3. **Use WebSocket for real-time data** - don't poll REST endpoints
4. **Validate parameters** before sending requests
5. **Implement retry logic** for network failures
6. **Set timeouts** for requests (5-10 seconds recommended)

---

## Next Steps

- [Device Endpoints](device-endpoints.md) - Complete device API reference
- [WiFi Endpoints](wifi-endpoints.md) - WiFi configuration API
- [WebSocket Protocol](../websocket/overview.md) - Real-time communication
- [Authentication](authentication.md) - API security (future)

---

[← Back to API Documentation](../README.md) | [Documentation Home](../../README.md)
