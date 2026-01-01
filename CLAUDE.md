# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Axionyx is an IoT platform for biotech laboratories with four main components:
- **firmware/** - ESP32 device firmware (C++/Arduino)
- **mobile/** - Flutter cross-platform app (iOS & Android)
- **frontend/** - Next.js web dashboard (TypeScript/React)
- **backend/** - Python FastAPI server (future development)

## Common Commands

### Firmware (ESP32)

All firmware projects use PlatformIO. Navigate to specific device directory first.

```bash
# Build firmware
cd firmware/dummy/dummy_demo  # or pcr/pcr_demo or incubator/incubator_demo
pio run

# Upload to device
pio run --target upload

# Monitor serial output
pio device monitor

# Build, upload, and monitor in one command
pio run --target upload && pio device monitor
```

**PlatformIO Configuration:**
- Platform: `espressif32`
- Board: `esp32dev` (ESP32-WROOM-32)
- Framework: `arduino`
- Monitor speed: `115200`

**Build Flags:**
- `-DDEVICE_TYPE_DUMMY` (or `_PCR`, `_INCUBATOR`)
- `-DCORE_DEBUG_LEVEL=3` for debugging

### Frontend (Next.js)

```bash
cd frontend

# Install dependencies
npm install

# Development server
npm run dev

# Lint
npm run lint

# Type check
npm run typecheck

# Build for production
npm run build

# Start production server
npm start
```

**Frontend Stack:**
- Next.js 16.1 with App Router
- React 19.2
- TypeScript 5
- Tailwind CSS v4
- ESLint + Next.js config

### Mobile (Flutter)

```bash
cd mobile

# Install dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test
```

**Mobile Stack:**
- Flutter SDK (Dart 3.2.6+)
- Material Design 3
- Package: `axionyx_mobile`

### Backend (Python)

```bash
cd backend

# Install dependencies with uv
uv sync

# Run tests
uv run pytest

# Lint with ruff
uv run ruff check .

# Format with ruff
uv run ruff format .

# Lint with auto-fix
uv run ruff check --fix .
```

**Backend Stack:**
- Python 3.12+
- FastAPI (future)
- uv package manager
- Ruff for linting/formatting
- pytest for testing

### Git Hooks

Install pre-commit hooks that run component-specific checks:

```bash
./.githooks/install-hooks.sh
```

The pre-commit hook runs:
- **Backend**: Ruff linting + formatting (when `backend/` files change)
- **Frontend**: ESLint + TypeScript checking (when `frontend/` files change)
- **Mobile**: Dart formatting + Flutter analyze (when `mobile/` files change)
- **Security**: Detects API keys, secrets, private keys (blocks commit if found)

### CI/CD

GitHub Actions workflows in `.github/workflows/`:

**Firmware CI (`firmware-ci.yml`):**
- Automatically discovers all PlatformIO projects in `firmware/` (excluding `.pio` build directories)
- Builds all projects in parallel using matrix strategy
- Runs on push/PR to master/main/develop when `firmware/**` changes
- Verifies all projects compile successfully
- Caches PlatformIO dependencies for faster builds

**Currently builds:**
- `firmware/dummy/` (dummy device)
- `firmware/pcr/pcr_demo/` (PCR machine)
- `firmware/incubator/incubator_demo/` (incubator)

**Adding new firmware projects:**
Just create a new directory with `platformio.ini` anywhere under `firmware/` and the CI will automatically discover and build it.

**Other CI workflows:**
- `backend-ci.yml` - Backend linting and testing
- `frontend-ci.yml` - Frontend linting and type checking
- `mobile-ci.yml` - Mobile app building and testing

## Architecture Overview

### Firmware Architecture

**Common Library (`firmware/common/`):**
Shared components used across all device types:
- `wifi/WiFiManager.h` - 5-state WiFi state machine (INIT, PROVISIONING, CONNECTING, CONNECTED, ERROR)
- `network/HTTPServer.h` - REST API server (14 endpoints)
- `network/WebSocketServer.h` - Real-time telemetry broadcast
- `device/DeviceBase.h` - Abstract base class for all devices
- `config/Config.h` - SPIFFS-based configuration storage
- `auth/DeviceAuth.h` - Device pairing and authentication
- `discovery/mDNSService.h` - mDNS device discovery
- `simulator/` - Mock sensor implementations for testing
- `utils/Logger.h` - Logging utilities
- `utils/TimeSync.h` - NTP time synchronization

**Device Implementations:**
Each device type extends `DeviceBase` and implements device-specific logic:
- `firmware/dummy/` - Test device with basic temperature control
- `firmware/pcr/` - PCR thermal cycler with 3-zone control and state machine
- `firmware/incubator/` - Environmental control (temperature, humidity, CO2)

**Key Patterns:**
- Object-oriented design with inheritance
- State machines for WiFi and PCR cycling
- PID control loops for temperature regulation
- Event-driven architecture for WebSocket communication
- Singleton patterns for managers (WiFi, Config, etc.)

**Device Communication:**
- REST API: HTTP on port 80, endpoints prefixed with `/api/v1`
- WebSocket: Port 81, broadcasts telemetry every 1 second
- mDNS: Service type `_axionyx._tcp.local`

### Frontend/Mobile Architecture

Both applications communicate directly with ESP32 devices over local network:
- Device discovery via mDNS
- REST API for control commands
- WebSocket for real-time telemetry updates
- No backend dependency for device control (currently)

### Backend Architecture (Future)

The backend will provide cloud services:
- User authentication and authorization
- Device registration and management
- Historical data storage
- Analytics and reporting

## Important Implementation Details

### WiFi State Machine

The WiFi manager implements a 5-state machine in `firmware/common/wifi/WiFiManager.h`:
1. **INIT** - Initial state on boot
2. **PROVISIONING** - Captive portal mode for WiFi credentials
3. **CONNECTING** - Attempting to connect to configured network
4. **CONNECTED** - Successfully connected
5. **ERROR** - Connection failed, will retry or fall back to provisioning

### Device Abstraction

All devices inherit from `DeviceBase` (`firmware/common/device/DeviceBase.h`) and must implement:
- `init()` - Device initialization
- `update()` - Called in main loop for device logic
- `getStatus()` - Return current device state as JSON
- Device-specific control methods

### REST API Structure

REST endpoints in `firmware/common/network/HTTPServer.h`:
- `/api/v1/device/*` - Device control (start, stop, pause, resume, setpoint)
- `/api/v1/wifi/*` - WiFi configuration (status, scan, configure)
- `/api/v1/config/*` - Device configuration (get, set, factory-reset)
- `/api/v1/ota/*` - OTA firmware updates (future)

All responses use JSON format with ArduinoJson v7.

### WebSocket Telemetry

WebSocket server broadcasts device telemetry every 1 second:
```json
{
  "timestamp": 1234567890,
  "state": "RUNNING",
  "temperature": 25.5,
  "setpoint": 95.0,
  // device-specific fields
}
```

### Configuration Storage

Device configuration stored in SPIFFS filesystem (`firmware/common/config/Config.h`):
- WiFi credentials (encrypted)
- Device identity (name, location)
- Device-specific settings
- Accessed via `Config::getInstance()`

### PID Control

Temperature control uses PID algorithm (`firmware/common/simulator/PIDController.h`):
- Proportional, Integral, Derivative gains
- Anti-windup for integral term
- Output clamping to valid range
- Tuned per-device type

## Testing Guidelines

### Firmware Testing

**Serial Monitor Testing:**
```bash
cd firmware/dummy/dummy_demo
pio device monitor
```
Monitor debug output, check state transitions, verify sensor readings.

**Hardware Requirements:**
- ESP32-WROOM-32 development board
- USB cable for programming and power
- WiFi network for connectivity testing

**Testing Flow:**
1. Flash firmware
2. Device boots into PROVISIONING mode (if no WiFi configured)
3. Connect to AP "Axionyx-[DeviceType]-XXXX"
4. Configure WiFi via captive portal
5. Device connects to network
6. Test REST API endpoints with curl/Postman
7. Connect WebSocket client to monitor telemetry

### Frontend/Mobile Testing

Both require a running ESP32 device on the same network.

**mDNS Discovery:**
Ensure device is advertising `_axionyx._tcp.local` service.

**API Testing:**
Use browser DevTools or Flutter DevTools to monitor network requests.

## Documentation Structure

Comprehensive documentation in `docs/`:
- `docs/getting-started/` - Installation and quick start guides
- `docs/architecture/` - System architecture and design decisions
- `docs/api/` - REST API and WebSocket protocol reference
- `docs/device-specs/` - Device-specific specifications (PCR, Incubator, Dummy)
- `docs/development/` - Component-specific development guides
- `docs/contributing/` - Contribution guidelines

**Always refer to the docs/** when:
- Understanding system architecture
- Learning API protocols
- Adding new device types
- Implementing new features

## Key Files to Review

When working on specific components, review these files:

**Adding a new device type:**
- `firmware/common/device/DeviceBase.h` - Base class interface
- `firmware/dummy/dummy_demo/src/DummyDevice.h` - Example implementation
- `docs/development/firmware/adding-devices.md` - Guide

**Modifying WiFi behavior:**
- `firmware/common/wifi/WiFiManager.h` - WiFi state machine
- `docs/architecture/firmware/wifi-state-machine.md` - Architecture

**Adding REST endpoints:**
- `firmware/common/network/HTTPServer.h` - HTTP server
- `firmware/common/network/HTTPServer.cpp` - Endpoint handlers
- `docs/api/rest-api/device-endpoints.md` - API documentation

**Working with configuration:**
- `firmware/common/config/Config.h` - Config manager
- `firmware/common/device/DeviceIdentity.h` - Device identity

**WebSocket communication:**
- `firmware/common/network/WebSocketServer.h` - WebSocket server
- `docs/api/websocket/telemetry.md` - Telemetry protocol

## Code Style

### Firmware (C++)
- Google C++ Style Guide
- 4-space indentation
- CamelCase for classes (`WiFiManager`)
- camelCase for methods (`getStatus()`)
- UPPER_CASE for constants (`MAX_TEMPERATURE`)

### Frontend (TypeScript)
- ESLint + Next.js config
- 2-space indentation
- camelCase for variables/functions
- PascalCase for components/types
- Functional components with hooks

### Mobile (Dart)
- Effective Dart guidelines
- 2-space indentation
- camelCase for variables/methods
- PascalCase for classes
- Trailing commas for formatting

### Backend (Python)
- PEP 8 + Ruff
- 4-space indentation
- snake_case for functions/variables
- PascalCase for classes
- Type hints required

## Common Pitfalls

### Firmware

**Memory Management:**
- ESP32 has limited RAM (520 KB). Avoid large allocations in loops.
- Use `const` references for parameters to avoid copying.
- Monitor stack usage with serial output.

**ArduinoJson v7:**
- Use `JsonDocument` with appropriate size (use Assistant to calculate).
- Access with `.as<T>()` pattern, not bracket operator for type safety.
- Example: `doc["temperature"].as<float>()` not `doc["temperature"]`

**State Machine Updates:**
- Always call `update()` in main loop for state transitions.
- WiFi state machine handles reconnection automatically.

**SPIFFS:**
- Must initialize before use with `SPIFFS.begin()`.
- File paths must start with `/` (e.g., `/config.json`).
- Limited storage (~1.5 MB typically).

### Frontend/Mobile

**mDNS Discovery:**
- May not work on all networks (corporate/guest WiFi).
- Fallback to manual IP entry should be available.
- iOS requires Bonjour entitlement for mDNS.

**WebSocket Connections:**
- Use `ws://` not `wss://` (devices don't have TLS).
- Handle reconnection on connection loss.
- Expect telemetry every 1 second.

## ArduinoJson v7 Migration

The codebase uses ArduinoJson v7. Key changes from v6:

**Old (v6):**
```cpp
StaticJsonDocument<1024> doc;
float temp = doc["temperature"];
```

**New (v7):**
```cpp
JsonDocument doc;
float temp = doc["temperature"].as<float>();
```

**Type conversions:**
- `.as<T>()` - Convert to type T
- `.is<T>()` - Check if value is type T
- No implicit conversions

Refer to commit `4ade665` for migration examples.

## Device-Specific Notes

### Dummy Device
Simple test device for development. Single temperature sensor with basic PID control.
Location: `firmware/dummy/dummy_demo/`

### PCR Machine
3-zone thermal cycler with cycle state machine (IDLE → INIT_DENATURE → DENATURE → ANNEAL → EXTEND → cycles → FINAL_EXTEND → HOLD → COMPLETE).
Location: `firmware/pcr/pcr_demo/`

### Incubator
Environmental control system managing temperature, humidity, and CO2 levels.
Location: `firmware/incubator/incubator_demo/`

## Additional Resources

- Main README: `/README.md`
- Complete docs: `/docs/README.md`
- Architecture: `/docs/architecture/README.md`
- API Reference: `/docs/api/README.md`
- Contributing: `/docs/contributing/README.md`
