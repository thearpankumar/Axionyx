# Axionyx ESP32 Firmware

**Demo firmware for ESP32-WROOM-32 biotech IoT devices**

This firmware provides comprehensive WiFi provisioning, device control APIs, and sensor simulation for testing your mobile app with biotech lab equipment (PCR machines, incubators, etc.).

---

## Quick Start

### 1. Hardware Requirements
- **ESP32-WROOM-32** development board (or compatible ESP32 module)
- **USB cable** for programming (data cable, not charge-only)
- **Computer** with Windows/macOS/Linux
- **Minimum 4MB flash** on ESP32

### 2. Software Requirements

**Option A: PlatformIO (Recommended)**
```bash
# Install PlatformIO Core
pip install platformio

# Or install VS Code extension
# Search "PlatformIO IDE" in VS Code extensions
```

**Option B: Arduino IDE**
- Download from https://www.arduino.cc/en/software
- Version 2.0 or higher required

### 3. Compile and Flash Firmware

#### Using PlatformIO (Recommended)

**Step 1: Navigate to device directory**
```bash
cd firmware/dummy/dummy_demo
```

**Step 2: Install dependencies (automatic)**
```bash
pio lib install
```

**Step 3: Build firmware**
```bash
# Build only (verify compilation)
pio run

# Expected output:
# RAM:   [==        ]  15.2% (used 49876 bytes from 327680 bytes)
# Flash: [====      ]  35.8% (used 470234 bytes from 1310720 bytes)
# SUCCESS
```

**Step 4: Connect ESP32**
- Connect ESP32 to computer via USB
- Check device port:
```bash
# Linux/macOS
ls /dev/tty*

# Windows
# Check Device Manager → Ports (COM & LPT)
```

**Step 5: Upload firmware**
```bash
# Auto-detect port and upload
pio run --target upload

# Or specify port manually
pio run --target upload --upload-port /dev/ttyUSB0  # Linux
pio run --target upload --upload-port COM3          # Windows
```

**Step 6: Monitor serial output**
```bash
# Open serial monitor
pio device monitor

# Or combine upload + monitor
pio run --target upload && pio device monitor
```

#### Using Arduino IDE

**Step 1: Install ESP32 Board Support**
1. Open Arduino IDE
2. Go to **File → Preferences**
3. Add to "Additional Board Manager URLs":
   ```
   https://espressif.github.io/arduino-esp32/package_esp32_index.json
   ```
4. Go to **Tools → Board → Board Manager**
5. Search "ESP32" and click **Install**

**Step 2: Install Required Libraries**
1. Go to **Tools → Manage Libraries**
2. Install the following:
   - **ArduinoJson** by Benoit Blanchon (version 7.0.0+)
   - **ESP Async WebServer** by lacamera (version 1.2.3+)
   - **ESPAsyncTCP** by dvarrel (version 1.2.2+)
   - **WebSockets** by Links2004 (version 2.4.1+)

**Step 3: Open Sketch**
1. **File → Open**
2. Navigate to `firmware/dummy/dummy_demo/dummy_demo.ino`

**Step 4: Configure Board Settings**
1. **Tools → Board → ESP32 Dev Module**
2. **Tools → Upload Speed → 921600**
3. **Tools → Flash Frequency → 80MHz**
4. **Tools → Flash Size → 4MB (32Mb)**
5. **Tools → Partition Scheme → Default 4MB**
6. **Tools → Core Debug Level → Info** (or Debug for verbose logs)

**Step 5: Select Port**
1. **Tools → Port**
2. Select your ESP32 port (e.g., COM3, /dev/ttyUSB0)

**Step 6: Compile and Upload**
1. Click **Verify** button (✓) to compile
2. Wait for "Done compiling" message
3. Click **Upload** button (→) to flash
4. Wait for "Done uploading" message

**Step 7: Open Serial Monitor**
1. **Tools → Serial Monitor**
2. Set baud rate to **115200**
3. You should see device boot logs

#### Troubleshooting Upload Issues

**Issue: "Failed to connect to ESP32"**
```bash
# Solution 1: Hold BOOT button while uploading
# On most ESP32 boards, hold BOOT button when "Connecting..." appears

# Solution 2: Install CP210x or CH340 drivers
# Download from manufacturer website

# Solution 3: Try different baud rate
pio run --target upload --upload-speed 115200
```

**Issue: "Port not found"**
```bash
# Check USB cable (must be data cable)
# Try different USB port
# Check drivers are installed
```

**Issue: "A fatal error occurred: MD5 of file does not match data in flash"**
```bash
# Erase flash and try again
pio run --target erase
pio run --target upload
```

### 4. Connect to the Device

**Step 1: Power On and Wait**
- Device boots in 2-3 seconds
- Serial monitor shows:
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
HTTP API: http://192.168.4.1/api/v1/
WebSocket: ws://192.168.4.1:81
===========================================
```

**Step 2: Connect to WiFi Hotspot**
- On your phone/computer, open WiFi settings
- Look for network: **`Axionyx-DUMMY-XXXXXX`** (XXXXXX = your chip ID)
- Password: **`axionyx123`**

**Step 3: Access Provisioning Page**
- **Automatic:** Captive portal should open automatically
- **Manual:** Open browser and go to http://192.168.4.1

**Step 4: Configure WiFi**
1. Click **"Scan Networks"** button
2. Select your WiFi network from the list
3. Enter WiFi password
4. Choose connection mode:
   - **WiFi Only** (STA_ONLY): Hotspot turns off after connection
   - **WiFi + Hotspot** (AP_STA_DUAL): Both active simultaneously
5. Click **"Connect to WiFi"**

**Step 5: Verify Connection**
- Serial monitor shows:
```
[INFO] WiFiManager: Connecting to YourNetwork
[INFO] WiFiManager: Connected! IP: 192.168.1.100
```

**Step 6: Control Device**
- Open browser to device IP (check serial monitor)
- Or use API directly:
```bash
# Get device info
curl http://192.168.1.100/api/v1/device/info

# Start device
curl -X POST http://192.168.1.100/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{"setpoint": 95.0}'
```

---

## Firmware Features Overview

### 🌐 WiFi Provisioning System
- **5-State WiFi State Machine**: Robust connection management
- **Captive Portal**: Automatic provisioning page when connecting
- **3 Operation Modes**:
  - AP_ONLY: Hotspot only (local control)
  - STA_ONLY: WiFi only (internet connectivity)
  - AP_STA_DUAL: Both active (local + remote)
- **Auto-Reconnection**: Exponential backoff (1s → 30s)
- **Network Scanning**: List available WiFi networks with signal strength
- **Persistent Storage**: WiFi credentials saved to SPIFFS

### 🔌 HTTP REST API
- **14 Endpoints** organized in 4 categories
- **Device Management**: Info, status, control (start/stop/pause/resume)
- **WiFi Configuration**: Status, scanning, credential management
- **System Configuration**: Full config access, factory reset
- **JSON Format**: All requests and responses in JSON
- **CORS Enabled**: Cross-origin requests supported for web apps
- **Async Processing**: Non-blocking request handling

### 📡 WebSocket Real-Time Communication
- **Bidirectional**: Client ↔ Server communication
- **Telemetry Broadcasting**: Automatic status updates (1 Hz)
- **Event Notifications**: Asynchronous event messages
- **Command Execution**: Remote device control via WebSocket
- **Multi-Client Support**: Multiple connections simultaneously
- **Heartbeat**: Ping/pong for connection health monitoring

### 🎛️ Sensor Simulation
- **PID Temperature Control**:
  - Realistic heating (3°C/s) and cooling (1.5°C/s)
  - Proportional-Integral-Derivative control
  - Anti-windup protection
  - Configurable constants (Kp, Ki, Kd)
- **Sensor Noise**: Realistic ±0.1°C fluctuations
- **Multi-Zone Support**: Independent temperature zones
- **Humidity Simulator**: 0-100% range with 2%/s change rate
- **CO2 Simulator**: 0-20% range with 0.5%/s change rate

### 💾 Configuration Management
- **SPIFFS Filesystem**: Persistent configuration storage
- **JSON Format**: Human-readable configuration file
- **Auto-Save**: Configuration persists across reboots
- **Factory Reset**: Restore defaults via API or button
- **Runtime Updates**: Change settings without recompilation

### 🔐 Security Features (Phase 6 - Coming Soon)
- Device pairing with JWT tokens
- WiFi password encryption
- API authentication
- Secure OTA updates

### 📱 Device Identity
- **Unique Device ID**: Generated from ESP32 chip ID
- **Serial Number**: Production-ready format
- **Auto-Generated AP SSID**: Unique per device
- **mDNS Hostname**: Network discovery support (Phase 6)

### 🔄 Advanced Features (Phases 4-7)
- **OTA Updates**: Over-the-air firmware updates
- **mDNS Discovery**: Zero-configuration device discovery
- **Multi-Device Management**: Control multiple devices
- **PCR Thermal Cycling**: 3-zone temperature control
- **Incubator Control**: Environmental parameter regulation

---

## How the Firmware Works

### Boot Sequence

```
1. ESP32 Powers On
   ├─ Initialize serial communication (115200 baud)
   ├─ Print firmware banner and version
   └─ Initialize SPIFFS filesystem

2. Load Configuration
   ├─ Check if /config.json exists
   ├─ If exists: Load and parse configuration
   └─ If missing: Generate defaults and save

3. Initialize Device
   ├─ Create unique Device ID from chip ID
   ├─ Initialize sensor simulators
   ├─ Set device state to IDLE
   └─ Print device information

4. Initialize WiFi Manager
   ├─ Check for saved WiFi credentials
   ├─ If credentials exist: Attempt connection
   └─ If no credentials: Start AP mode

5. Start Network Services
   ├─ Start HTTP server (port 80)
   ├─ Configure 14 REST API endpoints
   ├─ Start WebSocket server (port 81)
   └─ Start captive portal (if in AP mode)

6. Enter Main Loop
   ├─ Update WiFi state machine
   ├─ Update device sensors
   ├─ Process HTTP requests
   ├─ Process WebSocket messages
   └─ Broadcast telemetry (every 1 second)
```

### WiFi State Machine Flow

```
┌──────────┐
│WIFI_INIT │ Load config from SPIFFS
└────┬─────┘
     │
     ├─ Has WiFi credentials? ────YES──> ┌────────────────┐
     │                                    │WIFI_CONNECTING │
     │                                    └───────┬────────┘
     │                                            │
     │                                    Connected? ─YES─> ┌───────────────┐
     │                                            │         │WIFI_CONNECTED │
     │                                            NO        └───────┬───────┘
     │                                            │                 │
     │                                            v                 │
     │                                    ┌──────────────┐         │
     │                            ┌──────>│WIFI_RECONNECT│<────────┘
     │                            │       └──────┬───────┘   Connection lost
     │                            │              │
     │                            │       5 attempts failed
     │                            │              │
     └─ NO ───> ┌──────────────┐ │              │
                │WIFI_AP_MODE  │<───────────────┘
                └──────────────┘
                 Start hotspot
                 Captive portal
                 Wait for credentials
```

### API Request Processing

```
HTTP Request Arrives
    ├─ Async Web Server receives request
    ├─ Route matching (/api/v1/device/info)
    ├─ Execute handler function
    │   ├─ Parse request (if POST/PUT)
    │   ├─ Validate parameters
    │   ├─ Execute device operation
    │   └─ Generate response
    ├─ Add CORS headers
    └─ Send JSON response to client
```

### WebSocket Communication Flow

```
Client Connects
    ├─ WebSocket handshake
    ├─ Server sends "connected" message
    └─ Client subscribed to telemetry

Every Second:
    ├─ Device updates sensor readings
    ├─ Create telemetry JSON message
    └─ Broadcast to all connected clients

Client Sends Command:
    ├─ Server receives command message
    ├─ Parse JSON and extract command type
    ├─ Execute device operation
    ├─ Send response to client
    └─ Broadcast updated status to all clients
```

### Temperature PID Control

```
Every 100ms (sensor polling rate):
    ├─ Calculate error: error = setpoint - currentTemp
    ├─ PID Computation:
    │   ├─ P = Kp × error
    │   ├─ I = Ki × ∫error dt (with anti-windup)
    │   └─ D = Kd × d(error)/dt
    ├─ Control output = P + I + D
    ├─ Apply heating/cooling based on output:
    │   ├─ If output > 0: Heat at (output × 3°C/s)
    │   └─ If output < 0: Cool at (|output| × 1.5°C/s)
    ├─ Apply ambient drift
    ├─ Add sensor noise (±0.1°C)
    └─ Update currentTemp
```

---

## Current Implementation Status

### ✅ Phases 1-3 Complete (MVP Demo)

**Phase 1: Core Infrastructure**
- ✅ Configuration management with SPIFFS persistence
- ✅ WiFi state machine (AP/STA/Dual modes)
- ✅ Captive portal for seamless provisioning
- ✅ Serial logging utility

**Phase 2: Device Abstraction**
- ✅ Abstract device base class
- ✅ Device identity generation
- ✅ Temperature simulator with PID control
- ✅ Humidity and CO2 simulators
- ✅ Dummy test device implementation

**Phase 3: Network Services**
- ✅ Complete HTTP REST API (14 endpoints)
- ✅ WebSocket server for real-time telemetry
- ✅ Beautiful web-based provisioning interface
- ✅ CORS support for web/mobile apps

### 🔄 Pending Implementation

**Phase 4:** PCR Device - Complete PCR machine firmware with thermal cycling
**Phase 5:** Incubator Device - Environmental control (temp/humidity/CO2)
**Phase 6:** Advanced Features - mDNS, OTA updates, device pairing
**Phase 7:** Documentation - Complete API docs and user guides

---

## REST API Endpoints

Base URL: `http://192.168.4.1/api/v1/`

### Device Management
- `GET /device/info` - Device metadata
- `GET /device/status` - Current state and sensors
- `POST /device/start` - Start device operation
- `POST /device/stop` - Stop device
- `POST /device/pause` - Pause device
- `POST /device/resume` - Resume device
- `PUT /device/setpoint` - Adjust temperature

### WiFi Configuration
- `GET /wifi/status` - Connection status, RSSI
- `GET /wifi/scan` - Scan available networks
- `POST /wifi/configure` - Configure credentials

### Configuration
- `GET /config` - Get device configuration
- `POST /config` - Update configuration
- `POST /config/factory-reset` - Reset to defaults

---

## WebSocket Protocol

**URL:** `ws://192.168.4.1:81`

### Telemetry (Server → Client)
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

### Commands (Client → Server)
```json
{
  "type": "command",
  "command": "start",
  "params": {"setpoint": 95.0},
  "requestId": "uuid-1234"
}
```

---

## Testing with Your App

1. **Device Discovery**: Scan for `Axionyx-*` WiFi networks
2. **Provisioning**: Connect to hotspot, use captive portal
3. **Control**: Use REST API or WebSocket for commands
4. **Monitoring**: Receive real-time telemetry via WebSocket

---

## Troubleshooting

**Device won't connect to WiFi?**
- Check SSID/password
- Ensure 2.4GHz WiFi (ESP32 doesn't support 5GHz)
- Try factory reset: `POST /api/v1/config/factory-reset`

**Can't access captive portal?**
- Manually navigate to http://192.168.4.1
- Disable mobile data on phone

**API calls fail?**
- Check device IP address
- Ensure same network (if using STA mode)
- Verify endpoint URL

---

## Serial Monitor Output Example

```
===========================================
Axionyx Dummy Device Demo
Firmware Version: 1.0.0
===========================================
[INFO] Device ID: DUMMY-A1B2C3D4
[INFO] WiFiManager: AP started successfully
[INFO] WiFiManager: AP SSID: Axionyx-DUMMY-A1B2C3
[INFO] WiFiManager: AP IP: 192.168.4.1
[INFO] HTTPServer: Started successfully
[INFO] WebSocketServer: Started successfully
===========================================
Setup complete!
Connect to WiFi: Axionyx-DUMMY-A1B2C3
Password: axionyx123
HTTP API: http://192.168.4.1/api/v1/
WebSocket: ws://192.168.4.1:81
===========================================
```

---
