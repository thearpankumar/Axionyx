# Telemetry

Real-time device telemetry streaming.

---

## Overview

Telemetry messages are broadcast every second to all connected WebSocket clients.

**Update Frequency:** 1 Hz (1 message/second)

---

## Message Format

```json
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

---

## Device-Specific Data

### Dummy Device
```json
{
  "state": "RUNNING",
  "temperature": 94.8,
  "setpoint": 95.0
}
```

### PCR Machine
```json
{
  "state": "RUNNING",
  "temperature": [94.8, 72.1, 60.2],
  "currentPhase": "ANNEAL",
  "cycleNumber": 10,
  "totalCycles": 35,
  "progress": 28.5
}
```

### Incubator
```json
{
  "state": "RUNNING",
  "temperature": 37.2,
  "humidity": 94.8,
  "co2Level": 5.1,
  "temperatureStable": true,
  "humidityStable": true,
  "co2Stable": true,
  "environmentStable": true
}
```

---

[← Back to WebSocket Overview](overview.md)
