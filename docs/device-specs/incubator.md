# Incubator Firmware

**Environmental Control System for Cell Culture**

---

## Overview

This firmware implements a complete incubator with multi-parameter environmental control:
- **Temperature Control**: Precise regulation (4-50°C range)
- **Humidity Control**: 0-100% RH control
- **CO2 Control**: 0-20% CO2 level regulation
- **Stability Monitoring**: Real-time stability tracking
- **Multi-Sensor System**: Independent control of each parameter

## Environmental Control

### Default Settings (Cell Culture)

```json
{
  "temperature": 37.0,   // °C (human cell culture standard)
  "humidity": 95.0,      // % (prevents evaporation)
  "co2Level": 5.0        // % (maintains pH balance)
}
```

### Stability Thresholds

| Parameter | Threshold | Meaning |
|-----------|-----------|---------|
| Temperature | ±0.5°C | Within 0.5°C of setpoint |
| Humidity | ±2.0% | Within 2% of setpoint |
| CO2 | ±0.3% | Within 0.3% of setpoint |

## Flashing Firmware

```bash
cd firmware/incubator/incubator_demo
pio run --target upload
pio device monitor
```

## API Usage

### Start Incubation (Default Settings)

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{}'
```

### Start with Custom Settings

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{
    "temperature": 37.5,
    "humidity": 90.0,
    "co2Level": 5.5
  }'
```

### Get Current Status

```bash
curl http://192.168.4.1/api/v1/device/status
```

**Response:**
```json
{
  "state": "RUNNING",
  "uptime": 3600,
  "temperature": 37.2,
  "humidity": 94.8,
  "co2Level": 5.1,
  "temperatureSetpoint": 37.0,
  "humiditySetpoint": 95.0,
  "co2Setpoint": 5.0,
  "temperatureError": -0.2,
  "humidityError": 0.2,
  "co2Error": -0.1,
  "temperatureStable": true,
  "humidityStable": true,
  "co2Stable": true,
  "environmentStable": true,
  "timeStable": 1200,
  "doorOpen": false,
  "errors": []
}
```

### Adjust Individual Parameters

```bash
# Change temperature (zone 0)
curl -X PUT http://192.168.4.1/api/v1/device/setpoint \
  -H "Content-Type: application/json" \
  -d '{"zone": 0, "temperature": 38.0}'

# Change humidity (zone 1)
curl -X PUT http://192.168.4.1/api/v1/device/setpoint \
  -H "Content-Type: application/json" \
  -d '{"zone": 1, "temperature": 92.0}'

# Change CO2 (zone 2)
curl -X PUT http://192.168.4.1/api/v1/device/setpoint \
  -H "Content-Type: application/json" \
  -d '{"zone": 2, "temperature": 6.0}'
```

### Stop Incubation

```bash
curl -X POST http://192.168.4.1/api/v1/device/stop
```

## WebSocket Real-Time Monitoring

Connect to `ws://192.168.4.1:81`:

```javascript
{
  "type": "telemetry",
  "timestamp": 1704067200,
  "data": {
    "state": "RUNNING",
    "temperature": 37.2,
    "humidity": 94.8,
    "co2Level": 5.1,
    "temperatureStable": true,
    "humidityStable": true,
    "co2Stable": true,
    "environmentStable": true,
    "timeStable": 1200
  }
}
```

## Common Applications

### Mammalian Cell Culture
```json
{
  "temperature": 37.0,
  "humidity": 95.0,
  "co2Level": 5.0
}
```

### Bacterial Culture
```json
{
  "temperature": 37.0,
  "humidity": 70.0,
  "co2Level": 0.04
}
```

### Yeast Culture
```json
{
  "temperature": 30.0,
  "humidity": 80.0,
  "co2Level": 0.04
}
```

### Insect Cell Culture
```json
{
  "temperature": 27.0,
  "humidity": 90.0,
  "co2Level": 0.04
}
```

## Environmental Control System

### Temperature Control
- **Range**: 4-50°C
- **Heating Rate**: 1.0°C/second
- **Cooling Rate**: 0.5°C/second
- **PID Constants**: Kp=1.5, Ki=0.3, Kd=0.8
- **Stability**: ±0.5°C

### Humidity Control
- **Range**: 0-100%
- **Change Rate**: 2.0% per second
- **Noise**: ±0.5%
- **Stability**: ±2.0%

### CO2 Control
- **Range**: 0-20%
- **Change Rate**: 0.5% per second
- **Noise**: ±0.1%
- **Stability**: ±0.3%

## Serial Monitor Output

```
[INFO] IncubatorDevice: Starting incubation
[INFO] EnvironmentControl: Setting new targets
[INFO]   Temperature: 37.0°C
[INFO]   Humidity: 95.0%
[INFO]   CO2: 5.0%
[INFO] EnvironmentControl: Stability thresholds updated
[INFO] IncubatorDevice: Environmental conditions stabilized
[INFO] Environment: Temp=37.0°C (37.0°C), Humidity=95.1% (95.0%), CO2=5.0% (5.0%)
[INFO] Environment STABLE for 1200 seconds
```

## Stability Tracking

The incubator tracks environmental stability:

1. **Approaching Setpoint**: Parameters moving toward targets
2. **Stabilized**: All parameters within thresholds
3. **Time at Stable**: Duration of stable conditions
4. **Unstable Alert**: If any parameter drifts outside threshold

## Features

- ✅ Multi-parameter environmental control
- ✅ Real-time stability monitoring
- ✅ Independent PID control for each parameter
- ✅ Stability threshold configuration
- ✅ Time-at-stable tracking
- ✅ Pause/resume capability
- ✅ WebSocket real-time updates
- ✅ Pre-configured application profiles

---

**Firmware:** Incubator Demo v1.0.0
**Device Type:** Environmental Control System
**Status:** Ready for Testing
