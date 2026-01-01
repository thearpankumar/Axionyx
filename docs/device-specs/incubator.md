# Incubator Firmware

**Professional Environmental Control System for Cell Culture**

---

## Overview

This firmware implements a professional-grade incubator with advanced multi-parameter environmental control:
- **Temperature Control**: Precise regulation (4-50°C range)
- **Humidity Control**: 0-100% RH control
- **CO2 Control**: 0-20% CO2 level regulation
- **Multi-Stage Protocols**: Automated timed programs
- **Alarm System**: Comprehensive environmental monitoring
- **Parameter Ramping**: Smooth environmental transitions
- **Stability Monitoring**: Real-time stability tracking

## Quick Start

### Flashing Firmware

```bash
cd firmware/incubator/incubator_demo
pio run --target upload
pio device monitor
```

### Basic Usage

```bash
# Start with default cell culture settings
curl -X POST http://192.168.4.1/api/v1/device/start

# Check status
curl http://192.168.4.1/api/v1/device/status

# Stop incubation
curl -X POST http://192.168.4.1/api/v1/device/stop
```

## Environmental Control

### Default Settings (Mammalian Cell Culture)

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

### Environmental Specifications

#### Temperature Control
- **Range**: 4-50°C
- **Heating Rate**: 1.0°C/second
- **Cooling Rate**: 0.5°C/second
- **PID Constants**: Kp=1.5, Ki=0.3, Kd=0.8
- **Stability**: ±0.5°C

#### Humidity Control
- **Range**: 0-100%
- **Change Rate**: 2.0% per second
- **Noise**: ±0.5%
- **Stability**: ±2.0%

#### CO2 Control
- **Range**: 0-20%
- **Change Rate**: 0.5% per second
- **Noise**: ±0.1%
- **Stability**: ±0.3%

## Multi-Stage Protocols

### Protocol Types

The incubator supports 5 pre-defined protocol templates:

1. **Mammalian Cell Culture** - 37°C, 95% RH, 5% CO2
2. **Bacterial Growth** - 37°C, variable humidity
3. **Yeast Culture** - 30°C optimized
4. **Decontamination Cycle** - 65°C cleaning
5. **Multi-Temperature Expression** - 3-stage protein expression

### Get Available Protocols

```bash
curl http://192.168.4.1/api/v1/device/protocol/templates
```

**Response:**
```json
{
  "templates": [
    {
      "name": "Mammalian Cell Culture",
      "type": 0,
      "description": "Standard mammalian cell culture with 30-minute pre-heat ramp",
      "stages": 2
    },
    {
      "name": "Bacterial Growth (E. coli)",
      "type": 1,
      "description": "Standard E. coli culture with 15-minute warm-up",
      "stages": 2
    }
    // ... more templates
  ]
}
```

### Protocol Control

```bash
# Pause active protocol
curl -X POST http://192.168.4.1/api/v1/device/protocol/pause

# Resume paused protocol
curl -X POST http://192.168.4.1/api/v1/device/protocol/resume

# Manually advance to next stage
curl -X POST http://192.168.4.1/api/v1/device/protocol/next-stage

# Stop protocol
curl -X POST http://192.168.4.1/api/v1/device/protocol/stop
```

### Protocol Status

Protocol information is included in device status when a protocol is active:

```json
{
  "state": "RUNNING",
  "protocol": {
    "state": "RUNNING",
    "name": "Mammalian Cell Culture",
    "type": 0,
    "currentStage": 2,
    "totalStages": 2,
    "stageName": "Culture",
    "stageTimeRemaining": 0,
    "progress": 100.0
  }
}
```

## Alarm System

### Alarm Types

The incubator monitors environmental conditions and raises alarms for:

- **TEMP_HIGH** - Temperature above threshold
- **TEMP_LOW** - Temperature below threshold
- **HUMIDITY_LOW** - Humidity below threshold
- **CO2_HIGH** - CO2 above threshold
- **CO2_LOW** - CO2 below threshold
- **DOOR_OPEN** - Door open too long
- **POWER_FAILURE** - Power interruption
- **SENSOR_FAULT** - Sensor malfunction

### Alarm Severity

- **WARNING** - Deviation detected but within acceptable range
- **CRITICAL** - Immediate action required

### Default Alarm Thresholds

| Alarm Type | Warning | Critical |
|------------|---------|----------|
| Temperature High | 38.0°C | 39.0°C |
| Temperature Low | 36.0°C | 35.0°C |
| Humidity Low | 90.0% | 85.0% |
| CO2 High | 5.3% | 5.5% |
| CO2 Low | 4.7% | 4.5% |
| Door Open | 30 seconds | 2 minutes |

### Get Active Alarms

```bash
curl http://192.168.4.1/api/v1/device/alarms
```

**Response:**
```json
{
  "alarms": {
    "activeCount": 1,
    "hasCritical": false,
    "active": [
      {
        "type": 0,
        "severity": 0,
        "message": "Warning: Temperature above setpoint",
        "timestamp": 1704067200,
        "acknowledged": false,
        "currentValue": 38.2,
        "threshold": 38.0
      }
    ]
  }
}
```

### Acknowledge Alarms

```bash
# Acknowledge specific alarm by index
curl -X POST http://192.168.4.1/api/v1/device/alarms/acknowledge \
  -H "Content-Type: application/json" \
  -d '{"index": 0}'

# Acknowledge all active alarms
curl -X POST http://192.168.4.1/api/v1/device/alarms/acknowledge-all
```

### Alarm History

```bash
curl http://192.168.4.1/api/v1/device/alarms/history
```

**Response:**
```json
{
  "history": [
    {
      "type": 0,
      "severity": 0,
      "message": "Warning: Temperature above setpoint",
      "timestamp": 1704067100,
      "active": false,
      "acknowledged": true,
      "currentValue": 38.3,
      "threshold": 38.0
    }
  ]
}
```

## Parameter Ramping

The incubator supports gradual parameter changes to avoid thermal shock:

### Ramping Status

Check if parameters are ramping in device status:

```json
{
  "ramping": {
    "temperature": true,
    "humidity": false,
    "co2": false
  }
}
```

### How Ramping Works

When a protocol stage specifies `rampToTarget: true`:
- Parameters transition gradually over `rampTime` seconds
- Uses linear interpolation
- Prevents sudden environmental changes
- Automatically completes when target reached

## Basic API Endpoints

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

**Enhanced Response:**
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
  "ramping": {
    "temperature": false,
    "humidity": false,
    "co2": false
  },
  "protocol": {
    "state": "RUNNING",
    "name": "Mammalian Cell Culture",
    "currentStage": 2,
    "totalStages": 2,
    "progress": 100.0
  },
  "alarms": {
    "activeCount": 0,
    "hasCritical": false
  },
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
  -d '{"zone": 1, "humidity": 92.0}'

# Change CO2 (zone 2)
curl -X PUT http://192.168.4.1/api/v1/device/setpoint \
  -H "Content-Type: application/json" \
  -d '{"zone": 2, "co2": 6.0}'
```

### Pause/Resume

```bash
# Pause (maintains conditions)
curl -X POST http://192.168.4.1/api/v1/device/pause

# Resume
curl -X POST http://192.168.4.1/api/v1/device/resume
```

### Stop Incubation

```bash
curl -X POST http://192.168.4.1/api/v1/device/stop
```

## Complete API Reference

### Device Control
- `GET /api/v1/device/info` - Device information
- `GET /api/v1/device/status` - Current status
- `POST /api/v1/device/start` - Start incubation
- `POST /api/v1/device/stop` - Stop incubation
- `POST /api/v1/device/pause` - Pause (maintain conditions)
- `POST /api/v1/device/resume` - Resume operation
- `PUT /api/v1/device/setpoint` - Adjust parameter

### Protocol Management
- `GET /api/v1/device/protocol/templates` - Get protocol templates
- `POST /api/v1/device/protocol/start` - Start protocol
- `POST /api/v1/device/protocol/stop` - Stop protocol
- `POST /api/v1/device/protocol/pause` - Pause protocol
- `POST /api/v1/device/protocol/resume` - Resume protocol
- `POST /api/v1/device/protocol/next-stage` - Advance stage

### Alarm Management
- `GET /api/v1/device/alarms` - Get active alarms
- `GET /api/v1/device/alarms/history` - Get alarm history
- `POST /api/v1/device/alarms/acknowledge` - Acknowledge alarm
- `POST /api/v1/device/alarms/acknowledge-all` - Acknowledge all

## WebSocket Real-Time Monitoring

Connect to `ws://192.168.4.1:81` for real-time telemetry:

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
    "timeStable": 1200,
    "ramping": {
      "temperature": false,
      "humidity": false,
      "co2": false
    },
    "alarms": {
      "activeCount": 0,
      "hasCritical": false
    }
  }
}
```

## Testing

Run the comprehensive test suite:

```bash
cd firmware/api-test/incubator

# Run all tests
python test_incubator.py --ip 192.168.4.1

# Run only basic environmental control tests
python test_incubator.py --ip 192.168.4.1 --basic-only
```

Test coverage:
- ✅ Environmental control (temperature, humidity, CO2)
- ✅ Parameter ramping
- ✅ Stability monitoring
- ✅ Protocol templates
- ✅ Protocol control (start, stop, pause, resume, next-stage)
- ✅ Alarm monitoring
- ✅ Alarm acknowledgment
- ✅ Alarm history

## Serial Monitor Output

```
[INFO] IncubatorDevice: Initializing
[INFO] EnvironmentControl: Initializing environmental control
[INFO] ProtocolManager: Starting protocol: Mammalian Cell Culture
[INFO] ProtocolManager: Total stages: 2
[INFO] ProtocolManager: Starting stage 1: Pre-heat
[INFO] ProtocolManager: Target - Temp: 37.0°C, Humidity: 95.0%, CO2: 5.0%
[INFO] ProtocolManager: Ramping to target over 1800 seconds
[INFO] EnvironmentControl: Starting temperature ramp from 25.0°C to 37.0°C
[INFO] EnvironmentControl: Starting humidity ramp from 50.0% to 95.0%
[INFO] EnvironmentControl: Starting CO2 ramp from 0.04% to 5.0%
[INFO] IncubatorDevice: Environmental conditions stabilized
[INFO] ProtocolManager: Pre-heating complete, entering running state
[INFO] ProtocolManager: Stage 1 (Pre-heat) complete
[INFO] ProtocolManager: Starting stage 2: Culture
[INFO] AlarmManager: WARNING - Temperature above setpoint (Current: 38.2, Threshold: 38.0)
```

## Common Applications

### Mammalian Cell Culture (37°C)
```json
{
  "temperature": 37.0,
  "humidity": 95.0,
  "co2Level": 5.0
}
```

### Bacterial Culture (E. coli)
```json
{
  "temperature": 37.0,
  "humidity": 70.0,
  "co2Level": 5.0
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

## Features

### Environmental Control
- ✅ Multi-parameter environmental control
- ✅ Real-time stability monitoring
- ✅ Independent PID control for each parameter
- ✅ Stability threshold configuration
- ✅ Time-at-stable tracking
- ✅ Parameter ramping for smooth transitions

### Protocol Management
- ✅ Multi-stage protocol support
- ✅ 5 pre-defined protocol templates
- ✅ Automatic stage transitions
- ✅ Time-based and indefinite stages
- ✅ Pause/resume capability
- ✅ Manual stage advancement
- ✅ Progress tracking

### Alarm System
- ✅ 8 alarm types
- ✅ WARNING and CRITICAL severity levels
- ✅ Debouncing (3-second persistence)
- ✅ Alarm history tracking
- ✅ Individual and bulk acknowledgment
- ✅ Configurable thresholds per protocol

### Connectivity
- ✅ REST API (14+ endpoints)
- ✅ WebSocket real-time updates (1 Hz)
- ✅ WiFi provisioning with captive portal
- ✅ mDNS device discovery
- ✅ Configuration persistence (SPIFFS)

---

**Firmware:** Incubator Demo v2.0.0
**Device Type:** Professional Environmental Control System
**Status:** Production Ready
**Last Updated:** January 2026
