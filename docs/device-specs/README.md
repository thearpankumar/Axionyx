# Device Specifications

Technical specifications for all Axionyx biomedical devices.

---

## Overview

This section provides comprehensive technical specifications, operational parameters, and protocol documentation for all Axionyx devices.

---

## Device Types

### PCR Machine
**[PCR Machine Specifications](pcr-machine.md)**

3-zone thermal cycler for DNA amplification.

**Key Specs:**
- 3 independent temperature zones
- Temperature range: 4-120°C
- Heating rate: 5°C/s (denaturation zone)
- Cooling rate: 2°C/s
- Programmable cycling (up to 99 cycles)
- Real-time progress tracking

**Applications:**
- Standard PCR
- Fast PCR
- Long PCR
- Gradient PCR (future)

### Incubator
**[Incubator Specifications](incubator.md)**

Environmental control system for cell culture.

**Key Specs:**
- Temperature range: 4-50°C (±0.5°C precision)
- Humidity range: 0-100% RH (±2% precision)
- CO2 range: 0-20% (±0.3% precision)
- Independent PID control for each parameter
- Stability monitoring and alerts
- Time-at-stable tracking

**Applications:**
- Mammalian cell culture
- Bacterial culture
- Yeast culture
- Insect cell culture

### Dummy Device
**[Dummy Device Specifications](dummy-device.md)**

Simple test device for platform development and testing.

**Key Specs:**
- Single temperature zone
- Basic start/stop/pause operations
- Simplified telemetry
- Full API support

**Use Cases:**
- WiFi provisioning testing
- App development
- API integration testing
- Load testing

---

## Hardware Specifications

### ESP32-WROOM-32
**[ESP32 Hardware Specs](hardware/esp32-wroom-32.md)**

Microcontroller platform for all devices.

**Specifications:**
- **CPU:** Dual-core Xtensa LX6 @ 240 MHz
- **RAM:** 520 KB SRAM
- **Flash:** 4 MB
- **WiFi:** 802.11 b/g/n (2.4 GHz)
- **Bluetooth:** BLE 4.2
- **GPIO:** 34 pins
- **ADC:** 18 channels, 12-bit
- **DAC:** 2 channels, 8-bit
- **Operating Voltage:** 3.3V
- **Input Voltage:** 5V via USB

### Sensors
**[Sensor Specifications](hardware/sensors.md)**

Sensor specifications for production devices.

**Temperature Sensors:**
- Type: DS18B20 or thermocouple
- Range: -55°C to +125°C
- Accuracy: ±0.5°C

**Humidity Sensors:**
- Type: DHT22 or SHT31
- Range: 0-100% RH
- Accuracy: ±2%

**CO2 Sensors:**
- Type: MH-Z19 or SCD30
- Range: 0-10000 ppm
- Accuracy: ±50 ppm

### Power Requirements
**[Power Specifications](hardware/power-requirements.md)**

Power consumption and requirements.

**Device Power:**
- Operating voltage: 5V DC
- Average current: 500mA
- Peak current: 1.5A (heating)
- Recommended supply: 5V 2A adapter

---

## Communication Protocols

### WiFi Provisioning
**[WiFi Provisioning Protocol](protocols/wifi-provisioning.md)**

How devices connect to WiFi networks.

**Workflow:**
1. Device boots in AP mode
2. Captive portal serves provisioning page
3. User selects network and enters credentials
4. Device switches to STA mode
5. Connection established

**Features:**
- Network scanning
- 3 WiFi modes (AP_ONLY, STA_ONLY, AP_STA_DUAL)
- Automatic reconnection
- Fallback to AP mode on failure

### mDNS Discovery
**[mDNS Device Discovery](protocols/mdns-discovery.md)**

Zero-configuration device discovery on local networks.

**Service Type:** `_axionyx._tcp.local`

**TXT Records:**
- `type` - Device type (PCR, Incubator, etc.)
- `version` - Firmware version
- `id` - Unique device ID
- `serial` - Serial number

**Discovery Process:**
1. Device registers mDNS service on boot
2. App scans for `_axionyx._tcp.local` services
3. Discovered devices shown in app
4. User selects device to connect

### OTA Updates
**[OTA Update Protocol](protocols/ota-updates.md)**

Over-the-air firmware update mechanism.

**Update Process:**
1. Backend announces new firmware version
2. Device checks for updates
3. Downloads firmware via HTTP
4. Validates signature
5. Writes to OTA partition
6. Reboots to new firmware
7. Rollback on failure

**Features:**
- Dual partition system
- Signature validation
- Progress reporting
- Automatic rollback
- Resume interrupted downloads

---

## Common Specifications

### Network

**WiFi:**
- Protocol: 802.11 b/g/n
- Frequency: 2.4 GHz only
- Security: WPA/WPA2
- Max range: 50m (line of sight)

**API:**
- REST: HTTP/1.1 on port 80
- WebSocket: ws:// on port 81
- Max connections: 4 simultaneous clients

### Storage

**Configuration:**
- Filesystem: SPIFFS or LittleFS
- Capacity: ~1.5 MB (of 4 MB flash)
- Wear leveling: Yes

**Telemetry:**
- Storage: In-memory circular buffer
- Capacity: Last 1000 samples
- Persistence: No (volatile)

### Performance

**Temperature Control:**
- PID loop frequency: 10 Hz
- Telemetry broadcast: 1 Hz
- API response time: <100ms

**Network:**
- WiFi connection time: 2-10 seconds
- mDNS response time: <1 second
- WebSocket latency: <50ms (local network)

---

## Environmental Requirements

### Operating Conditions

**Temperature:**
- Operating: 0-40°C ambient
- Storage: -20-60°C

**Humidity:**
- Operating: 10-90% RH non-condensing
- Storage: 5-95% RH non-condensing

**Power:**
- Input: 100-240V AC, 50/60 Hz (via adapter)
- Consumption: 10W typical, 30W max

### Safety

**Certifications (Future):**
- CE marking
- FCC compliance
- UL listing

**Safety Features:**
- Over-temperature protection
- Short circuit protection
- Automatic shutdown on errors

---

## Physical Specifications

### Dimensions (Typical)

**PCR Machine:**
- Size: 250 x 200 x 150 mm
- Weight: 2.5 kg
- Sample capacity: 96-well plate

**Incubator:**
- Size: 400 x 350 x 300 mm
- Weight: 8 kg
- Chamber capacity: 20 liters

**Dummy Device:**
- Size: ESP32 dev board only
- Weight: 50 g

---

## Compliance & Standards

### Laboratory Standards

**PCR Machine:**
- ISO 9001 (Quality Management)
- ISO 13485 (Medical Devices) - Future
- CE-IVD (In Vitro Diagnostics) - Future

**Incubator:**
- ISO 14644 (Cleanrooms) - Future
- GMP (Good Manufacturing Practice) - Future

### Network Standards

**Protocols:**
- IEEE 802.11 (WiFi)
- RFC 6762 (mDNS)
- RFC 6455 (WebSocket)
- REST architectural style

---

## Maintenance & Calibration

### Recommended Maintenance

**PCR Machine:**
- Monthly: Clean heating blocks
- Quarterly: Verify temperature accuracy
- Annually: Professional calibration

**Incubator:**
- Weekly: Clean interior
- Monthly: Check sensor calibration
- Quarterly: HEPA filter replacement (if equipped)

### Calibration

**Temperature:**
- Method: Certified thermometer comparison
- Frequency: Every 6 months
- Acceptance: ±0.5°C

**Humidity:**
- Method: Saturated salt solution
- Frequency: Every 6 months
- Acceptance: ±2%

**CO2:**
- Method: Calibrated gas mixture
- Frequency: Every 3 months
- Acceptance: ±0.3%

---

## Firmware Versioning

### Version Scheme

Format: `MAJOR.MINOR.PATCH`

- **MAJOR:** Breaking API changes
- **MINOR:** New features, backward compatible
- **PATCH:** Bug fixes, no API changes

### Current Versions

- **PCR Firmware:** 1.0.0
- **Incubator Firmware:** 1.0.0
- **Dummy Firmware:** 1.0.0
- **Common Libraries:** 1.0.0

---

## Limitations

### Known Limitations

**ESP32 Platform:**
- 2.4 GHz WiFi only (no 5 GHz support)
- Limited RAM (520 KB)
- No real-time clock (requires NTP)

**Network:**
- Local network only (no cloud by default)
- Max 4 simultaneous clients
- No mesh networking

**Storage:**
- Limited flash (4 MB total)
- No SD card support (current hardware)
- Volatile telemetry (cleared on reboot)

---

## Future Enhancements

### Planned Features

**Hardware:**
- Real-time clock module (RTC)
- SD card for data logging
- LCD display
- Physical buttons

**Software:**
- Cloud connectivity
- Data export to SD card
- Advanced scheduling
- Multi-language support

**Devices:**
- Centrifuge
- Spectrophotometer
- Microscope controller
- Generic laboratory device

---

## Technical Support

### Documentation

- [User Guides](../user-guide/README.md)
- [API Documentation](../api/README.md)
- [Architecture](../architecture/README.md)

### Resources

- **Datasheets:** Available on request
- **Schematics:** Open source (future)
- **3D Models:** For custom enclosures (future)

---

[← Back to Documentation Home](../README.md)
