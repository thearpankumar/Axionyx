# Axionyx Documentation

**Unified AI-Assisted Platform for Biomedical Device Control**

Welcome to the Axionyx documentation! This comprehensive guide covers everything from quick starts to deep technical details for users, developers, and contributors.

---

## Start Here

Choose your path based on your role:

### For Users
- **[Quick Start Guide](getting-started/quick-start.md)** - Get up and running in 5 minutes
- **[User Guide](user-guide/README.md)** - Complete guides for devices and applications
- **[Device Specs](device-specs/README.md)** - Specifications for PCR machines, incubators, and more

### For Developers
- **[Getting Started](getting-started/README.md)** - Setup guides for all components
- **[API Documentation](api/README.md)** - REST API and WebSocket protocols
- **[Architecture](architecture/README.md)** - System design and component architecture
- **[Development Guides](development/README.md)** - Component-specific development docs

### For Contributors
- **[Contributing Guide](contributing/README.md)** - How to contribute to Axionyx
- **[Reference](reference/README.md)** - Complete API references and configuration

---

## Documentation Sections

### Getting Started
Complete setup and installation guides for all Axionyx components.

- [Quick Start](getting-started/quick-start.md) - 5-minute platform overview
- [Installation Guide](getting-started/installation.md) - Full platform installation
- [Firmware Setup](getting-started/firmware-setup.md) - Flash ESP32 device firmware
- [Backend Setup](getting-started/backend-setup.md) - Python/FastAPI backend
- [Frontend Setup](getting-started/frontend-setup.md) - Next.js web dashboard
- [Mobile Setup](getting-started/mobile-setup.md) - Flutter mobile app

### User Guide
User-facing documentation for operating devices and using applications.

- **Devices**
  - [PCR Machine](user-guide/devices/pcr-machine.md) - Operating the thermal cycler
  - [Incubator](user-guide/devices/incubator.md) - Environmental control system
  - [Device Discovery](user-guide/devices/device-discovery.md) - Find and pair devices

- **Mobile App**
  - [App Overview](user-guide/mobile-app/overview.md) - Mobile app features
  - [WiFi Provisioning](user-guide/mobile-app/wifi-provisioning.md) - Connect devices to WiFi
  - [Device Control](user-guide/mobile-app/device-control.md) - Control and monitor
  - [Monitoring](user-guide/mobile-app/monitoring.md) - Real-time telemetry

- **Web Dashboard**
  - [Dashboard Overview](user-guide/web-dashboard/overview.md) - Web interface features
  - [Multi-Device Management](user-guide/web-dashboard/multi-device.md) - Manage multiple devices
  - [Data Export](user-guide/web-dashboard/data-export.md) - Export experiment data

### API Documentation
Complete API reference for device communication and backend services.

- **REST API**
  - [Overview](api/rest-api/overview.md) - REST API introduction
  - [Authentication](api/rest-api/authentication.md) - Device pairing and auth
  - [Device Endpoints](api/rest-api/device-endpoints.md) - Control devices
  - [WiFi Endpoints](api/rest-api/wifi-endpoints.md) - Configure WiFi
  - [Config Endpoints](api/rest-api/config-endpoints.md) - Configuration management
  - [OTA Endpoints](api/rest-api/ota-endpoints.md) - Firmware updates

- **WebSocket**
  - [Overview](api/websocket/overview.md) - WebSocket protocol
  - [Telemetry](api/websocket/telemetry.md) - Real-time device data
  - [Events](api/websocket/events.md) - Event notifications
  - [Commands](api/websocket/commands.md) - Bidirectional commands

- **Backend API**
  - [Overview](api/backend-api/overview.md) - Backend service API
  - [Endpoints](api/backend-api/endpoints.md) - Backend REST endpoints

### Architecture
System architecture and design documentation.

- [System Overview](architecture/system-overview.md) - Complete system architecture

- **Firmware**
  - [Overview](architecture/firmware/overview.md) - Firmware architecture
  - [WiFi State Machine](architecture/firmware/wifi-state-machine.md) - Connectivity
  - [Device Abstraction](architecture/firmware/device-abstraction.md) - DeviceBase hierarchy
  - [PID Control](architecture/firmware/pid-control.md) - Temperature regulation
  - [Sensor Simulation](architecture/firmware/sensor-simulation.md) - Mock sensors

- **Backend**
  - [Overview](architecture/backend/overview.md) - Backend architecture
  - [Database](architecture/backend/database.md) - Database schema
  - [Services](architecture/backend/services.md) - Service layer

- **Frontend**
  - [Overview](architecture/frontend/overview.md) - Frontend architecture
  - [State Management](architecture/frontend/state-management.md) - State patterns

- **Mobile**
  - [Overview](architecture/mobile/overview.md) - Mobile app architecture
  - [State Management](architecture/mobile/state-management.md) - Flutter state

- **Communication**
  - [Device ↔ App](architecture/communication/device-to-app.md) - Device communication
  - [App ↔ Backend](architecture/communication/app-to-backend.md) - Backend communication
  - [Security](architecture/communication/security.md) - Security architecture

### Device Specifications
Technical specifications for all Axionyx devices.

- [PCR Machine](device-specs/pcr-machine.md) - 3-zone thermal cycler specs
- [Incubator](device-specs/incubator.md) - Environmental control specs
- [Dummy Device](device-specs/dummy-device.md) - Test device specs

- **Hardware**
  - [ESP32-WROOM-32](device-specs/hardware/esp32-wroom-32.md) - Microcontroller specs
  - [Sensors](device-specs/hardware/sensors.md) - Sensor specifications
  - [Power Requirements](device-specs/hardware/power-requirements.md) - Power specs

- **Protocols**
  - [WiFi Provisioning](device-specs/protocols/wifi-provisioning.md) - WiFi setup workflow
  - [mDNS Discovery](device-specs/protocols/mdns-discovery.md) - Device discovery
  - [OTA Updates](device-specs/protocols/ota-updates.md) - Firmware update protocol

### Development Guides
Component-specific development documentation.

- **Firmware**
  - [Overview](development/firmware/overview.md) - Firmware development
  - [Adding Devices](development/firmware/adding-devices.md) - New device types
  - [Common Components](development/firmware/common-components.md) - Shared code
  - [Testing](development/firmware/testing.md) - Firmware testing
  - [Debugging](development/firmware/debugging.md) - Debug guide

- **Backend**
  - [Overview](development/backend/overview.md) - Backend development
  - [API Development](development/backend/api-development.md) - New endpoints
  - [Database Migrations](development/backend/database-migrations.md) - Schema changes
  - [Testing](development/backend/testing.md) - Backend testing

- **Frontend**
  - [Overview](development/frontend/overview.md) - Frontend development
  - [Components](development/frontend/components.md) - Creating components
  - [Routing](development/frontend/routing.md) - Navigation
  - [Testing](development/frontend/testing.md) - Frontend testing

- **Mobile**
  - [Overview](development/mobile/overview.md) - Mobile development
  - [Screens](development/mobile/screens.md) - Creating screens
  - [Device Integration](development/mobile/device-integration.md) - Connect to devices
  - [Testing](development/mobile/testing.md) - Mobile testing

- **CI/CD**
  - [GitHub Actions](development/ci-cd/github-actions.md) - CI workflows
  - [Pre-commit Hooks](development/ci-cd/pre-commit-hooks.md) - Code quality
  - [Deployment](development/ci-cd/deployment.md) - Deployment guide

### Reference
Complete API references and configuration documentation.

- [Firmware API Reference](reference/firmware-api.md) - Complete firmware API
- [Backend API Reference](reference/backend-api.md) - Backend API reference
- [Configuration](reference/configuration.md) - All configuration options
- [Error Codes](reference/error-codes.md) - Error codes and troubleshooting
- [Glossary](reference/glossary.md) - Technical terms and definitions

### Contributing
Guidelines for contributing to the Axionyx project.

- [Contributing Guide](contributing/README.md) - How to contribute
- [Code Style](contributing/code-style.md) - Coding standards
- [Git Workflow](contributing/git-workflow.md) - Branching and commits
- [Documentation](contributing/documentation.md) - Writing docs
- [Testing Guidelines](contributing/testing-guidelines.md) - Testing best practices

---

## Project Overview

**Axionyx** is a unified platform for controlling modular biomedical devices through a single integrated interface. The platform consists of:

- **ESP32 Firmware** - Smart device firmware with WiFi provisioning
- **Python Backend** - FastAPI-based backend services
- **Next.js Frontend** - Modern web dashboard
- **Flutter Mobile** - Cross-platform mobile application

### Key Features

- Multi-device support with automatic discovery
- Real-time monitoring via WebSocket
- WiFi provisioning with captive portal
- OTA firmware updates
- Device pairing and authentication
- Comprehensive REST API
- Temperature control with PID
- Multi-parameter environmental control

---

## Quick Links

- [GitHub Repository](https://github.com/axionyx/axionyx) (Update with actual URL)
- [Issue Tracker](https://github.com/axionyx/axionyx/issues)
- [Contributing Guidelines](contributing/README.md)
- [License](../LICENSE)

---

## Need Help?

- Check the [Troubleshooting Guide](reference/error-codes.md)
- Review [FAQ](user-guide/README.md#faq) (Coming soon)
- Open an [Issue](https://github.com/axionyx/axionyx/issues)

---

**Documentation Version:** 1.0.0
**Last Updated:** 2025-12-31
