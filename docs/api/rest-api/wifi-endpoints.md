# WiFi Endpoints

WiFi configuration and network management endpoints.

---

## GET /wifi/status

Get WiFi connection status.

**URL:** `GET /api/v1/wifi/status`

**Response:**
```json
{
  "mode": 2,
  "state": "WIFI_CONNECTED",
  "ssid": "YourNetwork",
  "rssi": -45,
  "connected": true,
  "ipAddress": "192.168.1.100"
}
```

---

## GET /wifi/scan

Scan for available WiFi networks.

**URL:** `GET /api/v1/wifi/scan`

**Response:**
```json
{
  "networks": [
    {
      "ssid": "Network1",
      "rssi": -45,
      "encryption": "WPA2"
    },
    {
      "ssid": "Network2",
      "rssi": -67,
      "encryption": "WPA2"
    }
  ]
}
```

---

## POST /wifi/configure

Configure WiFi credentials and mode.

**URL:** `POST /api/v1/wifi/configure`

**Request Body:**
```json
{
  "ssid": "YourNetwork",
  "password": "YourPassword",
  "mode": 1
}
```

**Modes:**
- `0` - AP_ONLY
- `1` - STA_ONLY
- `2` - AP_STA_DUAL

**Response:**
```json
{
  "success": true,
  "message": "WiFi configured successfully"
}
```

---

See [REST API Overview](overview.md) for complete documentation.
