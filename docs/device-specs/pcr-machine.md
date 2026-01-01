# PCR Machine Firmware

**Professional 3-Zone Thermal Cycler for DNA Amplification**

---

## Overview

This firmware implements a professional-grade PCR (Polymerase Chain Reaction) thermal cycler with advanced features:
- **3 Independent Temperature Zones**: Denaturation, annealing, and extension
- **Programmable Cycling**: Customizable cycle count and temperatures
- **Advanced PCR Modes**: Hot start, touchdown, gradient, and two-step PCR
- **Program Validation**: Validate programs before execution
- **Pre-defined Templates**: 5 ready-to-use PCR programs
- **Real-Time Monitoring**: Track current phase, cycle number, and progress
- **PID Temperature Control**: Precise temperature regulation

## Quick Start

### Flashing Firmware

```bash
cd firmware/pcr/pcr_demo
pio run --target upload
pio device monitor
```

### Basic Usage

```bash
# Start with default PCR program
curl -X POST http://192.168.4.1/api/v1/device/start

# Check status
curl http://192.168.4.1/api/v1/device/status

# Stop PCR
curl -X POST http://192.168.4.1/api/v1/device/stop
```

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

## Standard PCR Program

### Default Configuration

```json
{
  "programType": "standard",
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

### Start Standard PCR

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{
    "programType": "standard",
    "cycles": 30,
    "denatureTemp": 95.0,
    "denatureTime": 30,
    "annealTemp": 60.0,
    "annealTime": 30,
    "extendTemp": 72.0,
    "extendTime": 60
  }'
```

## Advanced PCR Modes

### Hot Start PCR

Prevents non-specific amplification by activating polymerase at high temperature.

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{
    "programType": "standard",
    "cycles": 30,
    "denatureTemp": 95.0,
    "denatureTime": 30,
    "annealTemp": 60.0,
    "annealTime": 30,
    "extendTemp": 72.0,
    "extendTime": 60,
    "hotStart": {
      "enabled": true,
      "activationTemp": 95.0,
      "activationTime": 600
    }
  }'
```

**Parameters:**
- `activationTemp`: Temperature for polymerase activation (typically 95°C)
- `activationTime`: Duration in seconds (typically 10-15 minutes)

**Use Cases:**
- Colony PCR
- GC-rich templates
- High specificity requirements
- Reducing primer-dimer formation

### Touchdown PCR

Gradually decreases annealing temperature to improve specificity.

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{
    "programType": "touchdown",
    "cycles": 35,
    "denatureTemp": 95.0,
    "denatureTime": 30,
    "extendTemp": 72.0,
    "extendTime": 60,
    "touchdown": {
      "enabled": true,
      "startAnnealTemp": 68.0,
      "endAnnealTemp": 58.0,
      "stepSize": 1.0,
      "touchdownCycles": 10
    }
  }'
```

**Parameters:**
- `startAnnealTemp`: Initial high annealing temperature
- `endAnnealTemp`: Final annealing temperature
- `stepSize`: Temperature decrease per cycle
- `touchdownCycles`: Number of cycles for temperature reduction

**Example:** Start at 68°C, decrease by 1°C per cycle for 10 cycles, then continue at 58°C.

**Use Cases:**
- Unknown optimal annealing temperature
- Multiple primer pairs
- Reducing non-specific amplification

### Gradient PCR

Runs multiple samples at different annealing temperatures simultaneously.

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{
    "programType": "gradient",
    "cycles": 30,
    "denatureTemp": 95.0,
    "denatureTime": 30,
    "extendTemp": 72.0,
    "extendTime": 60,
    "gradient": {
      "enabled": true,
      "tempLow": 55.0,
      "tempHigh": 65.0,
      "positions": 12
    }
  }'
```

**Parameters:**
- `tempLow`: Lowest gradient temperature
- `tempHigh`: Highest gradient temperature
- `positions`: Number of temperature positions (typically 12)

**Use Cases:**
- Optimizing annealing temperature
- New primer pairs
- Multiple amplicons with different Tm values

### Two-Step PCR

Combines annealing and extension into a single step for faster cycling.

```bash
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{
    "programType": "twostep",
    "twoStepEnabled": true,
    "cycles": 30,
    "denatureTemp": 95.0,
    "denatureTime": 15,
    "annealExtendTemp": 65.0,
    "annealExtendTime": 30
  }'
```

**Parameters:**
- `annealExtendTemp`: Combined annealing/extension temperature
- `annealExtendTime`: Duration of combined step

**Use Cases:**
- Short amplicons (<500 bp)
- Fast cycling requirements
- High-throughput applications

## Program Management

### Get Available Templates

```bash
curl http://192.168.4.1/api/v1/device/program/templates
```

**Response:**
```json
{
  "templates": [
    {
      "name": "Standard PCR",
      "type": "standard",
      "description": "Basic PCR protocol for general amplification",
      "cycles": 35,
      "denatureTemp": 95.0,
      "annealTemp": 60.0,
      "extendTemp": 72.0
    },
    {
      "name": "Fast PCR",
      "type": "twostep",
      "description": "Faster cycling for amplicons <500bp",
      "cycles": 30
    },
    {
      "name": "Gradient Optimization",
      "type": "gradient",
      "description": "Optimize annealing temperature across gradient"
    },
    {
      "name": "High Specificity",
      "type": "touchdown",
      "description": "Reduce non-specific amplification"
    },
    {
      "name": "Colony PCR",
      "type": "standard",
      "description": "For amplification from bacterial colonies"
    }
  ]
}
```

### Validate Program

Validate a program before running to check for errors:

```bash
curl -X POST http://192.168.4.1/api/v1/device/program/validate \
  -H "Content-Type: application/json" \
  -d '{
    "cycles": 35,
    "denatureTemp": 95.0,
    "annealTemp": 60.0,
    "extendTemp": 72.0
  }'
```

**Response:**
```json
{
  "valid": true,
  "errors": [],
  "warnings": [
    "Consider using hot start for improved specificity"
  ]
}
```

**Validation Checks:**
- Cycle count (1-100)
- Temperature ranges (4-99°C)
- Time durations (1-3600 seconds)
- Gradient temperature order
- Touchdown parameter consistency
- Two-step compatibility

### Get Current Status

```bash
curl http://192.168.4.1/api/v1/device/status
```

**Enhanced Response:**
```json
{
  "state": "RUNNING",
  "uptime": 1200,
  "temperature": [94.8, 59.7, 71.9],
  "setpoint": [95.0, 60.0, 72.0],
  "currentPhase": "ANNEAL",
  "cycleNumber": 15,
  "totalCycles": 35,
  "phaseTimeRemaining": 12,
  "totalTimeRemaining": 2340,
  "progress": 42.8,
  "program": {
    "programType": "touchdown",
    "cycles": 35,
    "denatureTemp": 95.0,
    "extendTemp": 72.0,
    "touchdown": {
      "enabled": true,
      "startAnnealTemp": 68.0,
      "endAnnealTemp": 58.0,
      "currentAnnealTemp": 62.0,
      "stepSize": 1.0,
      "touchdownCycles": 10
    }
  },
  "errors": []
}
```

## Temperature Zones

| Zone | Purpose | Default Temp | Heating Rate | Cooling Rate |
|------|---------|--------------|--------------|--------------|
| 0 | Denaturation | 95°C | 5°C/s | 2°C/s |
| 1 | Annealing | 60°C | 3°C/s | 2°C/s |
| 2 | Extension | 72°C | 4°C/s | 1.5°C/s |

## API Reference

### Device Control
- `GET /api/v1/device/info` - Device information
- `GET /api/v1/device/status` - Current status
- `POST /api/v1/device/start` - Start PCR program
- `POST /api/v1/device/stop` - Stop PCR
- `POST /api/v1/device/pause` - Pause cycling
- `POST /api/v1/device/resume` - Resume cycling

### Program Management
- `GET /api/v1/device/program/templates` - Get program templates
- `POST /api/v1/device/program/validate` - Validate program

## WebSocket Real-Time Monitoring

Connect to `ws://192.168.4.1:81` for real-time updates:

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

## Typical PCR Programs

### Standard PCR
```json
{
  "cycles": 30-40,
  "denatureTemp": 94-95,
  "denatureTime": 20-30,
  "annealTemp": 50-65,
  "annealTime": 20-30,
  "extendTemp": 72,
  "extendTime": 30-120
}
```

### Fast PCR (Two-Step)
```json
{
  "programType": "twostep",
  "cycles": 30,
  "denatureTemp": 95,
  "denatureTime": 10,
  "annealExtendTemp": 65,
  "annealExtendTime": 20
}
```

### Long PCR
```json
{
  "cycles": 25-30,
  "denatureTemp": 94,
  "denatureTime": 30,
  "annealTemp": 55-65,
  "annealTime": 30,
  "extendTemp": 68-72,
  "extendTime": 60-900
}
```
**Extension time:** 1 minute per kb of amplicon

### Colony PCR (Hot Start)
```json
{
  "cycles": 35,
  "denatureTemp": 95,
  "annealTemp": 60,
  "extendTemp": 72,
  "hotStart": {
    "enabled": true,
    "activationTemp": 95,
    "activationTime": 900
  }
}
```

### Gradient Optimization
```json
{
  "programType": "gradient",
  "cycles": 25,
  "gradient": {
    "enabled": true,
    "tempLow": 55,
    "tempHigh": 65,
    "positions": 12
  }
}
```

### High Specificity (Touchdown)
```json
{
  "programType": "touchdown",
  "cycles": 35,
  "touchdown": {
    "enabled": true,
    "startAnnealTemp": 72,
    "endAnnealTemp": 60,
    "stepSize": 1,
    "touchdownCycles": 12
  }
}
```

## Testing

Run the comprehensive test suite:

```bash
cd firmware/api-test/pcr

# Run all tests (including advanced features)
python test_pcr.py --ip 192.168.4.1

# Run only basic PCR tests
python test_pcr.py --ip 192.168.4.1 --basic-only
```

Test coverage:
- ✅ Standard PCR cycling
- ✅ Program validation (valid & invalid)
- ✅ Program templates
- ✅ Hot start PCR
- ✅ Touchdown PCR
- ✅ Gradient PCR
- ✅ Two-step PCR
- ✅ Pause/resume
- ✅ Temperature monitoring

## Serial Monitor Output

```
[INFO] PCRDevice: Starting PCR program
[INFO] PCRDevice: Program Type: Touchdown PCR
[INFO] PCRDevice: Cycles=35, Denature=95.0°C, Extend=72.0°C
[INFO] PCRDevice: Touchdown: 68.0°C → 58.0°C over 10 cycles
[INFO] PCRCycler: Total program time = 4620 seconds (77 minutes)
[INFO] PCRCycler: Initial denaturation complete
[DEBUG] PCRCycler: Cycle 1 - Denaturation complete (95.0°C)
[DEBUG] PCRCycler: Cycle 1 - Annealing complete (68.0°C)
[DEBUG] PCRCycler: Cycle 1 - Extension complete (72.0°C)
[DEBUG] PCRCycler: Cycle 2 - Annealing at 67.0°C (touchdown)
...
[DEBUG] PCRCycler: Cycle 10 - Annealing at 58.0°C (final)
[DEBUG] PCRCycler: Touchdown phase complete, continuing at 58.0°C
...
[INFO] PCRCycler: All cycles complete, starting final extension
[INFO] PCRCycler: Final extension complete, moving to hold
[INFO] PCRCycler: PCR program complete!
```

## Features

### Core Features
- ✅ Programmable PCR cycling
- ✅ 3 independent temperature zones
- ✅ Real-time phase tracking
- ✅ Progress percentage calculation
- ✅ Time remaining estimation
- ✅ Pause/resume capability
- ✅ PID temperature control

### Advanced PCR Modes
- ✅ **Hot Start PCR** - Polymerase activation step
- ✅ **Touchdown PCR** - Gradual annealing temperature reduction
- ✅ **Gradient PCR** - Multiple annealing temperatures
- ✅ **Two-Step PCR** - Combined annealing/extension

### Program Management
- ✅ Program validation
- ✅ 5 pre-defined templates
- ✅ Error detection
- ✅ Parameter warnings

### Connectivity
- ✅ REST API (10+ endpoints)
- ✅ WebSocket real-time updates (1 Hz)
- ✅ WiFi provisioning with captive portal
- ✅ mDNS device discovery
- ✅ Configuration persistence (SPIFFS)

---

**Firmware:** PCR Demo v2.0.0
**Device Type:** Professional 3-Zone Thermal Cycler
**Status:** Production Ready
**Last Updated:** January 2026
