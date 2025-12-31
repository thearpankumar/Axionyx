# Getting Started with Axionyx

Complete setup and installation guides for all Axionyx platform components.

---

## Overview

The Axionyx platform consists of four main components:
- **Firmware** - ESP32 device firmware (C++/Arduino)
- **Backend** - Python FastAPI server
- **Frontend** - Next.js web dashboard
- **Mobile** - Flutter mobile application

This section provides setup guides for each component, from quick starts to comprehensive installations.

---

## Quick Start (5 Minutes)

Get started quickly with the essential components:

**[Quick Start Guide](quick-start.md)** - Get the platform running in 5 minutes

---

## Full Installation

Complete installation guide covering all components:

**[Installation Guide](installation.md)** - Step-by-step platform installation

---

## Component-Specific Setup

Detailed setup guides for each component:

### Firmware Setup
**[Firmware Setup Guide](firmware-setup.md)**

Set up ESP32 development environment and flash device firmware.

**What you'll learn:**
- PlatformIO and Arduino IDE setup
- Flashing firmware to ESP32-WROOM-32
- Serial monitor debugging
- WiFi provisioning

**Prerequisites:**
- ESP32-WROOM-32 development board
- USB cable
- Computer with USB port


Set up the Python FastAPI backend for development.

**What you'll learn:**
- Python environment setup with uv
- Running the FastAPI server
- Database configuration
- API endpoint testing

**Prerequisites:**
- Python 3.12+
- PostgreSQL (optional)

### Frontend Setup
**[Frontend Setup Guide](frontend-setup.md)**

Set up the Next.js web dashboard for development.

**What you'll learn:**
- Node.js and npm setup
- Running the development server
- Building for production
- Connecting to backend

**Prerequisites:**
- Node.js 18+
- npm or yarn

### Mobile Setup
**[Mobile Setup Guide](mobile-setup.md)**

Set up the Flutter mobile app for development.

**What you'll learn:**
- Flutter SDK installation
- Running on iOS/Android emulators
- Building for physical devices
- Device integration testing

**Prerequisites:**
- Flutter SDK 3.2.6+
- Android Studio or Xcode

---

## Prerequisites

### General Requirements

**Development Tools:**
- Git for version control
- Code editor (VS Code recommended)
- Terminal/command line access

**Operating Systems:**
- Linux, macOS, or Windows 10/11
- 8GB+ RAM recommended
- 10GB+ free disk space

### Component-Specific Requirements

| Component | Prerequisites |
|-----------|--------------|
| **Firmware** | PlatformIO or Arduino IDE, ESP32 board |
| **Backend** | Python 3.12+, uv package manager |
| **Frontend** | Node.js 18+, npm/yarn |
| **Mobile** | Flutter SDK 3.2.6+, Xcode/Android Studio |

---

## Installation Paths

Choose your installation path based on your goals:

### Path 1: End Users
**Goal:** Use the Axionyx platform to control devices

1. Install mobile app from App Store/Play Store
2. Follow in-app setup wizard
3. Connect and provision devices
4. Start using devices

### Path 2: App Developers
**Goal:** Develop mobile/web applications

1. [Frontend Setup](frontend-setup.md) or [Mobile Setup](mobile-setup.md)
3. [Firmware Setup](firmware-setup.md) (for device testing)

### Path 3: Firmware Developers
**Goal:** Develop device firmware

1. [Firmware Setup](firmware-setup.md)

### Path 4: Full Stack Development
**Goal:** Contribute to all components

1. [Installation Guide](installation.md) - Complete setup
2. Follow all component-specific guides
3. Review [Development Guides](../development/README.md)
4. Read [Contributing Guidelines](../contributing/README.md)

---

## Troubleshooting

### Common Issues

**USB driver issues (ESP32):**
- Install CP210x or CH340 drivers
- Check device manager for proper recognition

**Python dependency errors:**
- Use `uv` package manager for automatic resolution
- Create fresh virtual environment

**Node.js version issues:**
- Use nvm to manage Node.js versions
- Ensure Node.js 18+ is installed

**Flutter SDK path issues:**
- Add Flutter to system PATH
- Run `flutter doctor` to verify setup

### Getting Help

- Check [Error Codes Reference](../reference/error-codes.md)
- Review component-specific troubleshooting sections
- Open an issue on GitHub

---

## Next Steps

After completing setup:

1. **Learn the Architecture** - [Architecture Overview](../architecture/system-overview.md)
2. **Explore the API** - [API Documentation](../api/README.md)
3. **Try Examples** - Component-specific examples in each guide
4. **Start Developing** - [Development Guides](../development/README.md)

---

## Additional Resources

- [User Guide](../user-guide/README.md) - Using the platform
- [Device Specifications](../device-specs/README.md) - Device technical specs
- [Reference Documentation](../reference/README.md) - Complete API reference

---

[← Back to Documentation Home](../README.md)
