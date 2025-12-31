# Axionyx Platform - Quick Start Guide

**Get the Axionyx platform running in 5 minutes!**

---

## Overview

This guide will get you started with the essential Axionyx components. Choose your path based on what you want to do:

- **End Users:** Install the mobile app and control devices
- **App Developers:** Set up firmware + mobile/frontend
- **Firmware Developers:** Flash ESP32 firmware
- **Full Stack:** Set up all components

---

## Path 1: End Users (Mobile App Only)

### Prerequisites
- Smartphone (iOS 13+ or Android 8+)
- WiFi network (2.4 GHz)
- Axionyx device (ESP32-based)

### Steps

**1. Install Mobile App**
- iOS: Download from App Store (Coming soon)
- Android: Download from Google Play (Coming soon)

**2. Power On Device**
- Plug in your Axionyx device
- Wait 10 seconds for boot

**3. Connect to Device Hotspot**
- Open WiFi settings
- Look for network: `Axionyx-[DeviceType]-XXXXXX`
- Password: `axionyx123`

**4. Configure WiFi**
- Captive portal opens automatically
- Select your WiFi network
- Enter password
- Choose "WiFi Only" mode
- Click "Connect"

**5. Use the App**
- Device appears in app automatically
- Tap to connect
- Start controlling your device!

**Time: 3-5 minutes**

---

## Path 2: Firmware Developers

### Prerequisites
- ESP32-WROOM-32 development board
- USB cable (data cable)
- Computer with USB port

### Quick Setup

**1. Install PlatformIO**
```bash
pip install platformio
```

**2. Navigate to Firmware**
```bash
cd firmware/dummy/dummy_demo
```

**3. Flash Firmware**
```bash
# Build and upload
pio run --target upload

# Monitor serial output
pio device monitor
```

**4. Connect to Device**
- WiFi network: `Axionyx-DUMMY-XXXXXX`
- Password: `axionyx123`
- Web interface: http://192.168.4.1

**5. Test API**
```bash
# Get device info
curl http://192.168.4.1/api/v1/device/info

# Start device
curl -X POST http://192.168.4.1/api/v1/device/start \
  -H "Content-Type: application/json" \
  -d '{"setpoint": 95.0}'
```

**Time: 5 minutes**

See [Firmware Setup Guide](firmware-setup.md) for detailed instructions.

---

## Path 3: App Developers (Frontend)

### Prerequisites
- Node.js 18+
- npm or yarn
- Code editor

### Quick Setup

**1. Navigate to Frontend**
```bash
cd frontend
```

**2. Install Dependencies**
```bash
npm install
```

**3. Start Development Server**
```bash
npm run dev
```

**4. Open Browser**
- Navigate to http://localhost:3000
- You should see the Axionyx dashboard

**5. Connect to Device** (optional)
- Flash firmware to ESP32 (see Path 2)
- Configure API endpoint in frontend

**Time: 3 minutes**

See [Frontend Setup Guide](frontend-setup.md) for details.

---

## Path 4: App Developers (Mobile)

### Prerequisites
- Flutter SDK 3.2.6+
- Android Studio or Xcode
- Code editor

### Quick Setup

**1. Verify Flutter Installation**
```bash
flutter doctor
```

**2. Navigate to Mobile App**
```bash
cd mobile
```

**3. Get Dependencies**
```bash
flutter pub get
```

**4. Run on Emulator/Device**
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Chrome (for testing)
flutter run -d chrome
```

**Time: 5 minutes**

See [Mobile Setup Guide](mobile-setup.md) for details.

---

## Path 5: Backend Developers

### Prerequisites
- Python 3.12+
- uv package manager
- PostgreSQL (optional)

### Quick Setup

**1. Navigate to Backend**
```bash
cd backend
```

**2. Create Virtual Environment**
```bash
# Using uv (recommended)
uv venv
source .venv/bin/activate  # Linux/macOS
# or .venv\Scripts\activate  # Windows
```

**3. Install Dependencies**
```bash
uv pip install -e .
```

**4. Run Development Server**
```bash
# Future: uvicorn main:app --reload
echo "Backend coming soon!"
```

**Time: 3 minutes**


---

## Path 6: Full Stack (All Components)

For comprehensive setup of all components, see the [Complete Installation Guide](installation.md).

**Recommended Order:**
1. Firmware (ESP32 devices)
2. Backend (API server)
3. Frontend (Web dashboard)
4. Mobile (Mobile app)

**Total Time: 20-30 minutes**

---

## Quick Component Overview

### Firmware (ESP32 Devices)
**Location:** `firmware/`
**Language:** C++ / Arduino
**Purpose:** Device control and communication

**Available Devices:**
- Dummy Device - Simple test device
- PCR Machine - 3-zone thermal cycler (coming soon)
- Incubator - Environmental control (coming soon)

### Backend (API Server)
**Location:** `backend/`
**Language:** Python / FastAPI
**Purpose:** Cloud services and user management (future)

**Status:** In development

### Frontend (Web Dashboard)
**Location:** `frontend/`
**Language:** TypeScript / Next.js
**Purpose:** Web-based device control and monitoring

**Status:** In development

### Mobile (Mobile App)
**Location:** `mobile/`
**Language:** Dart / Flutter
**Purpose:** Cross-platform mobile device control

**Status:** In development

---

## Testing Your Setup

### Test Firmware

```bash
# Connect to device via WiFi
# Test REST API
curl http://192.168.4.1/api/v1/device/info

# Expected response:
# {
#   "id": "DUMMY-XXXXXXXX",
#   "type": "DUMMY",
#   "firmwareVersion": "1.0.0",
#   ...
# }
```

### Test Frontend

```bash
# After running `npm run dev`
# Open http://localhost:3000
# You should see the dashboard
```

### Test Mobile

```bash
# After `flutter run`
# App should launch in emulator/device
# Check for any errors in console
```

---

## Common Issues

### Firmware Issues

**Upload fails: "Failed to connect"**
- Hold BOOT button on ESP32 while uploading
- Install USB drivers (CP210x or CH340)
- Try different USB cable or port

**Can't see WiFi network**
- Wait 10 seconds after boot
- Check serial monitor: `pio device monitor`
- Look for "AP started successfully"

**API calls fail**
- Verify correct IP address (check serial monitor)
- Ensure on same WiFi network
- Check CORS is enabled

### Frontend Issues

**npm install fails**
- Clear npm cache: `npm cache clean --force`
- Delete `node_modules` and retry
- Use Node.js 18 or higher

**Page not loading**
- Check port 3000 isn't in use
- Clear browser cache
- Check console for errors

### Mobile Issues

**Flutter command not found**
- Add Flutter to PATH
- Run `flutter doctor` to verify setup

**Dependencies fail to install**
- Run `flutter clean`
- Delete `pubspec.lock`
- Run `flutter pub get` again

**App won't build**
- Check Xcode/Android Studio installation
- Update Flutter: `flutter upgrade`
- Run `flutter doctor` for diagnostics

---

## Next Steps

### For End Users
1. Explore device controls in mobile app
2. Try different experiment parameters
3. Monitor real-time telemetry
4. Export data

### For Developers
1. Review [API Documentation](../api/README.md)
2. Study [Architecture](../architecture/README.md)
3. Read [Development Guides](../development/README.md)
4. Check [Contributing Guidelines](../contributing/README.md)

### For Contributors
1. Review [Code Style Guide](../contributing/code-style.md)
2. Check open [Issues](https://github.com/axionyx/axionyx/issues)
3. Read [Git Workflow](../contributing/git-workflow.md)
4. Start with "good first issue" labels

---

## Additional Resources

- **Firmware:** [Detailed Firmware Setup](firmware-setup.md)
- **Frontend:** [Frontend Development Setup](frontend-setup.md)
- **Mobile:** [Mobile Development Setup](mobile-setup.md)
- **Complete Guide:** [Full Installation](installation.md)

---

## Getting Help

**Documentation:**
- [User Guide](../user-guide/README.md)
- [API Reference](../api/README.md)
- [Troubleshooting](../reference/error-codes.md)

**Community:**
- GitHub Issues
- Discussions
- Pull Requests

---

**Congratulations!** You're now ready to use or develop with Axionyx!

---

[← Back to Getting Started](README.md) | [Documentation Home](../README.md)
