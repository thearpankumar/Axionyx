# Axionyx

**Unified AI-Assisted Platform for Biomedical Device Control**

Control, monitor, and safely operate modular biomedical devices (PCR machines, incubators, and more) through a single integrated interface.

---

## Overview

Axionyx is a comprehensive IoT platform for biotech laboratories, providing:

- **ESP32 Firmware** - Smart device firmware with WiFi provisioning
- **Mobile Application** - Flutter cross-platform app (iOS & Android)
- **Web Dashboard** - Next.js modern web interface
- **Backend Services** - Python FastAPI server (future)

---

## Quick Start

### For Users

**[5-Minute Quick Start →](docs/getting-started/quick-start.md)**

Get started with Axionyx devices and apps.

### For Developers

**[Complete Installation Guide →](docs/getting-started/installation.md)**

Set up all components for development.

### For Firmware Development

**[Firmware Setup →](docs/getting-started/firmware-setup.md)**

Flash ESP32 devices with Axionyx firmware.

---

## Documentation

📚 **[Complete Documentation →](docs/README.md)**

### Main Sections

- **[Getting Started](docs/getting-started/README.md)** - Setup guides for all components
- **[User Guide](docs/user-guide/README.md)** - Using devices and applications
- **[API Documentation](docs/api/README.md)** - REST API & WebSocket protocols
- **[Architecture](docs/architecture/README.md)** - System design and architecture
- **[Device Specifications](docs/device-specs/README.md)** - PCR, Incubator, Dummy device specs
- **[Development Guides](docs/development/README.md)** - Component-specific development
- **[Reference](docs/reference/README.md)** - API references and configuration
- **[Contributing](docs/contributing/README.md)** - How to contribute

---

## Project Structure

```
Axionyx/
├── firmware/          # ESP32 device firmware (C++/Arduino)
│   ├── common/       # Shared components (WiFi, HTTP, WebSocket)
│   ├── pcr/          # PCR machine firmware
│   ├── incubator/    # Incubator firmware
│   └── dummy/        # Test device firmware
├── mobile/           # Flutter mobile app (Dart)
├── frontend/         # Next.js web dashboard (TypeScript/React)
├── backend/          # FastAPI backend (Python) - Future
├── infrastructure/   # Docker & deployment
├── docs/             # Complete documentation
└── README.md         # This file
```

---

## Features

### ESP32 Firmware
- WiFi provisioning with captive portal
- REST API (14 endpoints)
- WebSocket real-time communication
- PID temperature control
- Multi-device support
- OTA updates (future)

### Mobile App
- Cross-platform (iOS & Android)
- Device discovery via mDNS
- Real-time monitoring
- WiFi provisioning
- Multi-device management

### Web Dashboard
- Browser-based control
- Real-time telemetry
- Historical data
- Data export

---

## Supported Devices

- **PCR Machine** - 3-zone thermal cycler for DNA amplification
- **Incubator** - Environmental control (temperature, humidity, CO2)
- **Dummy Device** - Test device for development

More devices coming soon (centrifuge, spectrophotometer, etc.)

---

## Getting Help

- **Documentation:** [docs/README.md](docs/README.md)
- **Issues:** [GitHub Issues](https://github.com/axionyx/axionyx/issues)
- **Discussions:** [GitHub Discussions](https://github.com/axionyx/axionyx/discussions)

---

## Contributing

We welcome contributions! See [Contributing Guide](docs/contributing/README.md) for details.

---

## License

See [LICENSE](LICENSE) file for details.

---

**Version:** 1.0.0
**Status:** Active Development
