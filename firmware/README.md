# Axionyx ESP32 Firmware

Demo firmware for ESP32-WROOM-32 biotech IoT devices.

---

## Quick Start

```bash
# Navigate to device directory
cd dummy/dummy_demo

# Build and upload
pio run --target upload

# Monitor serial output
pio device monitor
```

---

## Documentation

📚 **Complete documentation has moved to:**

**[docs/getting-started/firmware-setup.md](../docs/getting-started/firmware-setup.md)**

This includes:
- Installation instructions
- PlatformIO and Arduino IDE setup
- Flashing firmware
- WiFi provisioning
- API testing
- Troubleshooting

---

## Quick Links

- **[Firmware Setup Guide](../docs/getting-started/firmware-setup.md)** - Complete setup instructions
- **[Quick Start](../docs/getting-started/quick-start.md)** - 5-minute guide
- **[API Documentation](../docs/api/README.md)** - REST API & WebSocket
- **[Architecture](../docs/architecture/firmware/overview.md)** - Firmware architecture
- **[Device Specifications](../docs/device-specs/README.md)** - PCR, Incubator, Dummy

---

## Available Devices

- **[Dummy Device](dummy/README.md)** - Simple test device
- **[PCR Machine](pcr/README.md)** - 3-zone thermal cycler
- **[Incubator](incubator/README.md)** - Environmental control system

---

For complete documentation, see **[docs/](../docs/README.md)**
