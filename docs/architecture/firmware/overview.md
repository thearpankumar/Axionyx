# Firmware Architecture Overview

ESP32 device firmware architecture and design.

---

## Overview

The Axionyx firmware provides comprehensive device control with WiFi provisioning, REST API, WebSocket communication, and sensor simulation.

**Platform:** ESP32-WROOM-32
**Framework:** Arduino
**Language:** C++

---

## Architecture Layers

### Core Layer (`firmware/common/`)

Shared components used across all devices:

- **Config** - Configuration management with SPIFFS
- **WiFi** - WiFi state machine (AP/STA/Dual modes)
- **Network** - HTTP server and WebSocket server
- **Device** - DeviceBase abstract class
- **Simulator** - PID-controlled sensor simulation
- **Utils** - Logging, time sync, helpers

### Device Layer (`firmware/*/`)

Device-specific implementations:

- **Dummy Device** - Simple test device
- **PCR Machine** - 3-zone thermal cycler
- **Incubator** - Environmental control system

---

## Component Interaction

```
┌─────────────┐
│   Device    │ (PCR, Incubator, Dummy)
│  (main.ino) │
└──────┬──────┘
       │
       ├──► WiFiManager ──► ESP32 WiFi
       ├──► HTTPServer ──► REST API
       ├──► WebSocketServer ──► Real-time telemetry
       ├──► DeviceBase ──► Sensors & Control
       └──► Config ──► SPIFFS Storage
```

---

## Key Features

- **WiFi Provisioning** - Captive portal, 3 modes
- **REST API** - 14 HTTP endpoints
- **WebSocket** - Real-time bidirectional communication
- **PID Control** - Temperature regulation
- **Configuration** - Persistent SPIFFS storage
- **Device Discovery** - mDNS (future)
- **OTA Updates** - Firmware updates (future)

---

See component-specific documentation:
- [WiFi State Machine](wifi-state-machine.md)
- [Device Abstraction](device-abstraction.md)
- [PID Control](pid-control.md)
- [Sensor Simulation](sensor-simulation.md)

---

[← Back to Architecture](../README.md)
