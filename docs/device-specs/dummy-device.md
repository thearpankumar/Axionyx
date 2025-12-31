# Dummy Device Firmware

**Simple Test Device for WiFi and API Testing**

---

## Overview

The dummy device firmware provides a minimal implementation for testing the Axionyx platform without complex device logic. Perfect for:
- WiFi provisioning testing
- REST API development
- WebSocket integration
- Multi-device management testing
- Mobile app development

## Features

- ✅ Single temperature zone with PID control
- ✅ Simple start/stop/pause/resume operations
- ✅ Real-time telemetry via WebSocket
- ✅ Complete REST API support
- ✅ WiFi provisioning (AP/STA/Dual modes)
- ✅ Minimal complexity for easy understanding

## Flashing Firmware

```bash
cd firmware/dummy/dummy_demo
pio run --target upload
pio device monitor
```

## API Usage

### Start Device

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{"setpoint": 95.0}'
```

### Get Status

```bash
curl http://192.168.4.1/api/v1/device/status
```

**Response:**
```json
{
  "state": "RUNNING",
  "uptime": 600,
  "temperature": 94.8,
  "setpoint": 95.0,
  "errors": []
}
```

### Change Setpoint

```bash
curl -X PUT http://192.168.4.1/api/v1/device/setpoint \
  -H "Content-Type: application/json" \
  -d '{"zone": 0, "temperature": 80.0}'
```

### Stop Device

```bash
curl -X POST http://192.168.4.1/api/v1/device/stop
```

## WebSocket

Connect to `ws://192.168.4.1:81`:

```javascript
{
  "type": "telemetry",
  "timestamp": 1704067200,
  "data": {
    "state": "RUNNING",
    "temperature": 94.8,
    "setpoint": 95.0
  }
}
```

## Temperature Control

- **Heating Rate**: 3°C/second
- **Cooling Rate**: 1.5°C/second
- **Range**: 0-120°C
- **PID Control**: Kp=2.0, Ki=0.5, Kd=1.0
- **Sensor Noise**: ±0.1°C

## Use Cases

### 1. WiFi Testing
Test all three WiFi modes:
```bash
# Test AP_ONLY mode
# Test STA_ONLY mode
# Test AP_STA_DUAL mode
```

### 2. API Development
Use dummy device as API reference:
- All endpoints supported
- Simple response structure
- Fast iteration

### 3. App Development
Build mobile app features:
- Device discovery
- WiFi provisioning UI
- Control interface
- Real-time monitoring
- Multi-device management

### 4. Load Testing
Test multiple simultaneous connections:
- Deploy multiple dummy devices
- Simulate production environment
- Test WebSocket scalability

## Serial Monitor Output

```
===========================================
Axionyx Dummy Device Demo
Firmware Version: 1.0.0
===========================================
[INFO] Device ID: DUMMY-A1B2C3D4
[INFO] WiFi manager initialized
[INFO] HTTPServer: Started successfully
[INFO] WebSocketServer: Started successfully
===========================================
Setup complete!
Connect to WiFi: Axionyx-DUMMY-A1B2C3
Password: axionyx123
===========================================
[INFO] Status - WiFi State: 1, Device State: IDLE, Temp: 25.0°C
[INFO] DummyDevice: Starting
[INFO] DummyDevice: Setpoint set to 95.0°C
[INFO] Status - WiFi State: 3, Device State: RUNNING, Temp: 94.8°C
```

## Code Structure

Simple and easy to understand:
- `DummyDevice.h/cpp`: Device implementation
- `dummy_demo.ino`: Main sketch
- Uses all common components (Config, WiFi, HTTP, WebSocket)

## Extending the Dummy Device

The dummy device serves as a template for creating new device types:

1. **Copy the structure**
2. **Add your device-specific logic**
3. **Implement required DeviceBase methods**
4. **Test with existing infrastructure**

---

**Firmware:** Dummy Device v1.0.0
**Device Type:** Test Device
**Purpose:** WiFi/API Testing & App Development
**Status:** Production Ready
