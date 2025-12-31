# Device Endpoints

Device control and monitoring API endpoints.

---

## GET /device/info

Get device metadata and identification.

**URL:** `GET /api/v1/device/info`

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

---

## GET /device/status

Get current device state and sensor readings.

**URL:** `GET /api/v1/device/status`

**Response (Dummy Device):**
```json
{
  "state": "RUNNING",
  "uptime": 600,
  "temperature": 94.8,
  "setpoint": 95.0,
  "errors": []
}
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

---

## POST /device/start

Start device operation.

**URL:** `POST /api/v1/device/start`

**Request Body:**
```json
{
  "setpoint": 95.0
}
```

**Response:**
```json
{
  "success": true,
  "message": "Device started successfully"
}
```

---

## POST /device/stop

Stop device operation.

**URL:** `POST /api/v1/device/stop`

**Response:**
```json
{
  "success": true,
  "message": "Device stopped successfully"
}
```

---

## PUT /device/setpoint

Update temperature setpoint.

**URL:** `PUT /api/v1/device/setpoint`

**Request Body:**
```json
{
  "zone": 0,
  "temperature": 96.0
}
```

**Response:**
```json
{
  "success": true,
  "message": "Setpoint updated"
}
```

---

See [REST API Overview](overview.md) for complete documentation.
