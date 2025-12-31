# PCR Machine Firmware

**3-Zone Thermal Cycler for DNA Amplification**

---

## Overview

This firmware implements a complete PCR (Polymerase Chain Reaction) thermal cycler with:
- **3 Independent Temperature Zones**: Denaturation, annealing, and extension
- **Programmable Cycling**: Customizable cycle count and temperatures
- **Real-Time Monitoring**: Track current phase, cycle number, and progress
- **PID Temperature Control**: Precise temperature regulation
- **Phase Tracking**: Automatic progression through PCR phases

## PCR Cycling Phases

```
1. INITIAL_DENATURE → Initial denaturation (default: 95°C for 3 min)
2. DENATURE → Cycle denaturation (default: 95°C for 30s)
3. ANNEAL → Annealing (default: 60°C for 30s)
4. EXTEND → Extension (default: 72°C for 60s)
   [Repeat steps 2-4 for specified cycles]
5. FINAL_EXTEND → Final extension (default: 72°C for 5 min)
6. HOLD → Hold at 4°C
7. COMPLETE → Program finished
```

## Default PCR Program

```json
{
  "initialDenatureTemp": 95.0,
  "initialDenatureTime": 180,
  "cycles": 35,
  "denatureTemp": 95.0,
  "denatureTime": 30,
  "annealTemp": 60.0,
  "annealTime": 30,
  "extendTemp": 72.0,
  "extendTime": 60,
  "finalExtendTemp": 72.0,
  "finalExtendTime": 300,
  "holdTemp": 4.0
}
```

## Flashing Firmware

```bash
cd firmware/pcr/pcr_demo
pio run --target upload
pio device monitor
```

## API Usage

### Start PCR with Default Program

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{}'
```

### Start PCR with Custom Program

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{
    "program": {
      "cycles": 40,
      "denatureTemp": 94.0,
      "denatureTime": 20,
      "annealTemp": 55.0,
      "annealTime": 25,
      "extendTemp": 72.0,
      "extendTime": 45
    }
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
  "uptime": 1200,
  "temperature": [94.8, 59.7, 71.9],
  "setpoint": [95.0, 60.0, 72.0],
  "currentPhase": "DENATURE",
  "cycleNumber": 15,
  "totalCycles": 35,
  "phaseTimeRemaining": 12,
  "totalTimeRemaining": 2340,
  "progress": 42.8,
  "program": {
    "cycles": 35,
    "denatureTemp": 95.0,
    "annealTemp": 60.0,
    "extendTemp": 72.0
  },
  "errors": []
}
```

### Pause/Resume

```bash
# Pause
curl -X POST http://192.168.4.1/api/v1/device/pause

# Resume
curl -X POST http://192.168.4.1/api/v1/device/resume
```

### Stop PCR

```bash
curl -X POST http://192.168.4.1/api/v1/device/stop
```

## WebSocket Real-Time Monitoring

Connect to `ws://192.168.4.1:81` to receive real-time updates:

```javascript
{
  "type": "telemetry",
  "timestamp": 1704067200,
  "data": {
    "state": "RUNNING",
    "temperature": [94.8, 59.7, 71.9],
    "currentPhase": "ANNEAL",
    "cycleNumber": 10,
    "totalCycles": 35,
    "progress": 28.5,
    "phaseTimeRemaining": 15,
    "totalTimeRemaining": 3600
  }
}
```

## Temperature Zones

| Zone | Purpose | Default Temp | Heating Rate | Cooling Rate |
|------|---------|--------------|--------------|--------------|
| 0 | Denaturation | 95°C | 5°C/s | 2°C/s |
| 1 | Annealing | 60°C | 3°C/s | 2°C/s |
| 2 | Extension | 72°C | 4°C/s | 1.5°C/s |

## Typical PCR Programs

### Standard PCR
- Cycles: 30-40
- Denaturation: 94-95°C for 20-30s
- Annealing: 50-65°C for 20-30s
- Extension: 72°C for 30-120s

### Fast PCR
- Cycles: 30
- Denaturation: 95°C for 10s
- Annealing: 60°C for 10s
- Extension: 72°C for 20s

### Long PCR
- Cycles: 25-30
- Denaturation: 94°C for 30s
- Annealing: 55-65°C for 30s
- Extension: 68-72°C for 1-15 min (1 min per kb)

## Serial Monitor Output

```
[INFO] PCRDevice: Starting PCR program
[INFO] PCRDevice: Cycles=35, Denature=95.0°C, Anneal=60.0°C, Extend=72.0°C
[INFO] PCRCycler: Total program time = 4380 seconds (73 minutes)
[INFO] PCRCycler: Initial denaturation complete
[DEBUG] PCRCycler: Cycle 1 - Denaturation complete
[DEBUG] PCRCycler: Cycle 1 - Annealing complete
[DEBUG] PCRCycler: Cycle 1 - Extension complete
...
[INFO] PCRCycler: All cycles complete, starting final extension
[INFO] PCRCycler: Final extension complete, moving to hold
[INFO] PCRCycler: PCR program complete!
```

## Features

- ✅ Programmable PCR cycling
- ✅ 3 independent temperature zones
- ✅ Real-time phase tracking
- ✅ Progress percentage calculation
- ✅ Time remaining estimation
- ✅ Pause/resume capability
- ✅ PID temperature control
- ✅ WebSocket real-time updates

---

**Firmware:** PCR Demo v1.0.0
**Device Type:** 3-Zone Thermal Cycler
**Status:** Ready for Testing
