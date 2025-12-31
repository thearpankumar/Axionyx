# Configuration Endpoints

Device configuration management endpoints.

---

## GET /config

Get device configuration.

**URL:** `GET /api/v1/config`

**Response:**
```json
{
  "device": {
    "id": "PCR-A1B2C3D4",
    "type": "PCR",
    "name": "Lab PCR #1"
  },
  "wifi": {
    "mode": 2,
    "ssid": "YourNetwork",
    "apSSID": "Axionyx-PCR-A1B2C3"
  },
  "network": {
    "httpPort": 80,
    "wsPort": 81
  }
}
```

---

## POST /config

Update device configuration.

**URL:** `POST /api/v1/config`

**Request Body:**
```json
{
  "device": {
    "name": "New Name"
  }
}
```

---

## POST /config/factory-reset

Reset device to factory defaults.

**URL:** `POST /api/v1/config/factory-reset`

**Response:**
```json
{
  "success": true,
  "message": "Factory reset initiated. Device will reboot."
}
```

---

See [REST API Overview](overview.md) for complete documentation.
