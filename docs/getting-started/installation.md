# Complete Installation Guide

**Comprehensive setup for the entire Axionyx platform**

This guide covers installation of all Axionyx components from scratch. For quick setup, see the [Quick Start Guide](quick-start.md).

---

## Overview

The Axionyx platform consists of four main components:

1. **Firmware** - ESP32 device firmware (C++/Arduino)
2. **Backend** - Python FastAPI server (Future)
3. **Frontend** - Next.js web dashboard (In Development)
4. **Mobile** - Flutter mobile application (In Development)

**Installation Time:** 30-60 minutes for all components

---

## Prerequisites

### Hardware Requirements

**For Firmware Development:**
- ESP32-WROOM-32 development board
- USB cable (data cable, not charge-only)
- Computer with USB port

**For General Development:**
- Computer with 8GB+ RAM
- 10GB+ free disk space
- Internet connection

### Operating System

Supported platforms:
- **Linux** - Ubuntu 20.04+ (recommended)
- **macOS** - 11.0 (Big Sur) or later
- **Windows** - Windows 10/11

---

## Step 1: Install System Dependencies

### Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install essential build tools
sudo apt install -y git build-essential curl wget

# Install Python 3.12
sudo apt install -y python3.12 python3.12-venv python3-pip

# Install Node.js 18+ (via NodeSource)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Install Flutter dependencies
sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev
```

### macOS

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install git python@3.12 node@18

# Install Flutter dependencies (for macOS development)
brew install --cask flutter
```

### Windows

**Using Chocolatey:**
```powershell
# Install Chocolatey (if not installed)
# Run PowerShell as Administrator

# Install dependencies
choco install -y git python nodejs flutter
```

**Manual Installation:**
- Git: https://git-scm.com/download/win
- Python 3.12: https://www.python.org/downloads/
- Node.js 18: https://nodejs.org/
- Flutter: https://docs.flutter.dev/get-started/install/windows

---

## Step 2: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/axionyx/axionyx.git
cd axionyx

# Verify structure
ls -la
# Should see: backend/ frontend/ mobile/ firmware/ docs/
```

---

## Step 3: Firmware Setup

### Install PlatformIO

**Option A: PlatformIO CLI (Recommended)**
```bash
# Install via pip
pip install platformio

# Verify installation
pio --version
# Should output: PlatformIO Core, version X.X.X
```

**Option B: PlatformIO IDE (VS Code Extension)**
```bash
# Install VS Code
# Then install PlatformIO IDE extension
# Search "PlatformIO IDE" in VS Code Extensions
```

### Flash Firmware to ESP32

```bash
# Navigate to dummy device
cd firmware/dummy/dummy_demo

# Connect ESP32 via USB
# Check device port
pio device list

# Build and upload
pio run --target upload

# Monitor serial output
pio device monitor
```

**Expected Output:**
```
===========================================
Axionyx Dummy Device Demo
Firmware Version: 1.0.0
===========================================
[INFO] Device ID: DUMMY-A1B2C3D4
[INFO] WiFi manager initialized
[INFO] HTTPServer: Started successfully
Setup complete!
Connect to WiFi: Axionyx-DUMMY-A1B2C3
===========================================
```

### Test Firmware

```bash
# Connect to device WiFi
# SSID: Axionyx-DUMMY-XXXXXX
# Password: axionyx123

# Test API
curl http://192.168.4.1/api/v1/device/info
```

**Troubleshooting:**
- **Upload fails:** Hold BOOT button while uploading
- **Port not found:** Install CP210x or CH340 USB drivers
- **Build errors:** Check PlatformIO installation

See [Firmware Setup Guide](firmware-setup.md) for detailed instructions.

---

## Step 4: Backend Setup

**Status:** In development (Python 3.12 + FastAPI)

### Install Python Dependencies

```bash
# Navigate to backend directory
cd backend

# Install uv package manager
pip install uv

# Create virtual environment
uv venv

# Activate virtual environment
source .venv/bin/activate  # Linux/macOS
# or .venv\Scripts\activate  # Windows

# Install dependencies
uv pip install -e .
```

### Configure Database (Future)

```bash
# Install PostgreSQL
# Linux
sudo apt install postgresql postgresql-contrib

# macOS
brew install postgresql

# Windows
# Download from https://www.postgresql.org/download/windows/

# Create database
createdb axionyx

# Run migrations (future)
# alembic upgrade head
```

### Run Backend Server (Future)

```bash
# Start development server
# uvicorn main:app --reload --port 8000

# Expected output:
# INFO:     Uvicorn running on http://127.0.0.1:8000
# INFO:     Application startup complete
```

### Test Backend (Future)

```bash
# Test health endpoint
# curl http://localhost:8000/health

# View API docs
# Open http://localhost:8000/docs
```

See [Backend Setup Guide](backend-setup.md) for details.

---

## Step 5: Frontend Setup

**Status:** In development (Next.js 16 + React 19)

### Install Dependencies

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Expected output:
# added XXX packages in Xs
```

### Configure Environment

```bash
# Create .env.local file
cat > .env.local << EOF
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_WS_URL=ws://localhost:8000/ws
EOF
```

### Start Development Server

```bash
# Start Next.js dev server
npm run dev

# Expected output:
# ▲ Next.js 16.1.1
# - Local:        http://localhost:3000
# - Ready in XXXms
```

### Test Frontend

```bash
# Open browser
open http://localhost:3000

# You should see the Axionyx dashboard
```

### Build for Production

```bash
# Build production bundle
npm run build

# Start production server
npm start
```

See [Frontend Setup Guide](frontend-setup.md) for details.

---

## Step 6: Mobile App Setup

**Status:** In development (Flutter 3.2.6+)

### Install Flutter SDK

**Linux:**
```bash
# Download Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
flutter doctor
```

**macOS:**
```bash
# Using Homebrew
brew install --cask flutter

# Or download manually
# https://docs.flutter.dev/get-started/install/macos

# Verify installation
flutter doctor
```

**Windows:**
- Download Flutter SDK: https://docs.flutter.dev/get-started/install/windows
- Extract to C:\flutter
- Add to PATH: C:\flutter\bin
- Run `flutter doctor` in PowerShell

### Install Mobile Development Tools

**For Android Development:**
```bash
# Install Android Studio
# Download from https://developer.android.com/studio

# Install Android SDK
# Via Android Studio: Tools → SDK Manager

# Accept licenses
flutter doctor --android-licenses
```

**For iOS Development (macOS only):**
```bash
# Install Xcode from App Store
# Install Xcode Command Line Tools
sudo xcode-select --install

# Install CocoaPods
sudo gem install cocoapods

# Verify installation
pod --version
```

### Setup Mobile Project

```bash
# Navigate to mobile directory
cd mobile

# Get dependencies
flutter pub get

# Verify setup
flutter doctor
# All checks should pass ✓
```

### Run on Emulator/Device

**Android:**
```bash
# List available devices
flutter devices

# Start Android emulator (if not running)
# Via Android Studio: AVD Manager → Create/Start

# Run app
flutter run -d android
```

**iOS (macOS only):**
```bash
# List available simulators
flutter devices

# Start iOS simulator
open -a Simulator

# Run app
flutter run -d ios
```

**Chrome (for testing):**
```bash
flutter run -d chrome
```

### Build for Production

**Android:**
```bash
# Build APK
flutter build apk

# Build App Bundle
flutter build appbundle

# Output: build/app/outputs/
```

**iOS (macOS only):**
```bash
# Build IPA
flutter build ipa

# Output: build/ios/iphoneos/
```

See [Mobile Setup Guide](mobile-setup.md) for details.

---

## Step 7: Verify Installation

### Check All Components

**1. Firmware:**
```bash
# Check ESP32 is running
curl http://192.168.4.1/api/v1/device/info
# Should return device info JSON
```

**2. Backend (Future):**
```bash
# Check backend is running
# curl http://localhost:8000/health
# Should return: {"status": "healthy"}
```

**3. Frontend:**
```bash
# Check frontend is running
curl http://localhost:3000
# Should return HTML
```

**4. Mobile:**
```bash
# Check app is running
flutter devices
# Should list running devices/simulators
```

---

## Step 8: Configure Components

### Firmware Configuration

**WiFi Provisioning:**
1. Connect to device hotspot: `Axionyx-DUMMY-XXXXXX`
2. Open http://192.168.4.1
3. Configure WiFi credentials
4. Device connects to network

**Device Settings:**
- Configuration stored in SPIFFS (`/config.json`)
- Factory reset: `POST /api/v1/config/factory-reset`

### Backend Configuration (Future)

**Environment Variables:**
```bash
# Create .env file
cat > backend/.env << EOF
DATABASE_URL=postgresql://user:pass@localhost/axionyx
SECRET_KEY=your-secret-key
DEBUG=true
EOF
```

### Frontend Configuration

**Environment Variables:**
```bash
# Update .env.local
NEXT_PUBLIC_API_URL=http://192.168.1.100:8000
NEXT_PUBLIC_DEVICE_IP=192.168.1.100
```

### Mobile Configuration

**API Endpoints:**
```dart
// Update lib/config/app_config.dart
class AppConfig {
  static const String apiBaseUrl = 'http://192.168.1.100:8000';
  static const String wsBaseUrl = 'ws://192.168.1.100:8000/ws';
}
```

---

## Step 9: Development Workflow

### Recommended Workflow

**1. Start Backend (Future):**
```bash
cd backend
source .venv/bin/activate
uvicorn main:app --reload
```

**2. Start Frontend:**
```bash
cd frontend
npm run dev
```

**3. Run Mobile App:**
```bash
cd mobile
flutter run
```

**4. Flash Firmware:**
```bash
cd firmware/dummy/dummy_demo
pio run --target upload
pio device monitor
```

### Hot Reload

- **Frontend:** Automatic on file save
- **Mobile:** Press 'r' in terminal for hot reload, 'R' for full restart
- **Backend:** Automatic with `--reload` flag
- **Firmware:** Must re-upload (or use OTA in future)

---

## Troubleshooting

### Common Issues

**Port Already in Use:**
```bash
# Find process using port 3000 (frontend)
lsof -i :3000  # Linux/macOS
netstat -ano | findstr :3000  # Windows

# Kill process
kill -9 <PID>  # Linux/macOS
taskkill /PID <PID> /F  # Windows
```

**Permission Denied (ESP32):**
```bash
# Linux: Add user to dialout group
sudo usermod -a -G dialout $USER
# Log out and back in

# Check permissions
ls -l /dev/ttyUSB0
```

**Flutter Doctor Issues:**
```bash
# Run verbose doctor
flutter doctor -v

# Common fixes:
flutter doctor --android-licenses  # Accept Android licenses
sudo xcode-select -s /Applications/Xcode.app  # macOS
```

**npm Install Fails:**
```bash
# Clear cache
npm cache clean --force

# Delete and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Getting Help

- **Documentation:** Check component-specific setup guides
- **Error Codes:** See [Error Reference](../reference/error-codes.md)
- **GitHub Issues:** Report bugs or ask questions
- **Logs:** Enable debug logging for detailed output

---

## Next Steps

### For Development

1. **Read Architecture:** [System Overview](../architecture/system-overview.md)
2. **Study API:** [API Documentation](../api/README.md)
3. **Review Code:** Explore component source code
4. **Start Contributing:** [Contributing Guide](../contributing/README.md)

### For Testing

1. **Test WiFi Provisioning:** Set up device on network
2. **Test API Endpoints:** Use curl or Postman
3. **Test WebSocket:** Monitor real-time telemetry
4. **Test Mobile App:** Control device from app

### For Production

1. **Security:** Enable authentication and HTTPS
2. **OTA Updates:** Set up firmware update system
3. **Monitoring:** Implement logging and metrics
4. **Deployment:** Deploy backend and frontend to cloud

---

## Additional Resources

- [Quick Start Guide](quick-start.md) - 5-minute setup
- [Firmware Setup](firmware-setup.md) - Detailed firmware guide
- [Backend Setup](backend-setup.md) - Backend development
- [Frontend Setup](frontend-setup.md) - Frontend development
- [Mobile Setup](mobile-setup.md) - Mobile development

---

## Installation Checklist

Use this checklist to track your progress:

- [ ] System dependencies installed
- [ ] Repository cloned
- [ ] Firmware flashed and tested
- [ ] Backend running (future)
- [ ] Frontend running
- [ ] Mobile app running
- [ ] All components configured
- [ ] Development workflow verified
- [ ] Documentation reviewed

**Congratulations!** You now have a complete Axionyx development environment.

---

[← Back to Getting Started](README.md) | [Documentation Home](../README.md)
