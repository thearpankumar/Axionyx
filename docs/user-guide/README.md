# User Guide

Complete user-facing documentation for operating Axionyx devices and using the platform applications.

---

## Overview

This guide covers everything you need to know about using the Axionyx platform, from discovering and pairing devices to running experiments and monitoring results.

---

## Quick Navigation

### Devices
- **[PCR Machine User Manual](devices/pcr-machine.md)** - Operating the thermal cycler
- **[Incubator User Manual](devices/incubator.md)** - Environmental control system
- **[Device Discovery & Pairing](devices/device-discovery.md)** - Find and connect devices

### Mobile Application
- **[Mobile App Overview](mobile-app/overview.md)** - Features and capabilities
- **[WiFi Provisioning](mobile-app/wifi-provisioning.md)** - Connect devices to WiFi
- **[Device Control](mobile-app/device-control.md)** - Control and configure devices
- **[Real-Time Monitoring](mobile-app/monitoring.md)** - Monitor device telemetry

### Web Dashboard
- **[Dashboard Overview](web-dashboard/overview.md)** - Web interface features
- **[Multi-Device Management](web-dashboard/multi-device.md)** - Manage multiple devices
- **[Data Export](web-dashboard/data-export.md)** - Export experiment data

---

## Getting Started

### First-Time Setup

1. **Install the mobile app** (iOS/Android) or access the web dashboard
2. **Create an account** and log in
3. **Discover devices** on your network
4. **Provision WiFi** on devices (if needed)
5. **Pair devices** with your account
6. **Start using** devices for experiments

### Typical Workflow

1. Power on your device
2. Connect via mobile app or web dashboard
3. Configure experiment parameters
4. Start the experiment
5. Monitor real-time telemetry
6. Review results and export data

---

## Device Operations

### PCR Machine

The PCR machine provides programmable thermal cycling for DNA amplification.

**Key Features:**
- 3-zone temperature control
- Customizable cycling programs
- Progress tracking
- Cycle-by-cycle monitoring

**Common Tasks:**
- [Run standard PCR protocol](devices/pcr-machine.md#standard-protocol)
- [Create custom programs](devices/pcr-machine.md#custom-programs)
- [Monitor cycle progress](devices/pcr-machine.md#monitoring)
- [Troubleshoot issues](devices/pcr-machine.md#troubleshooting)

### Incubator

The incubator provides precise environmental control for cell culture.

**Key Features:**
- Temperature, humidity, and CO2 control
- Stability monitoring
- Multi-parameter regulation
- Time-at-stable tracking

**Common Tasks:**
- [Set up mammalian cell culture](devices/incubator.md#mammalian-culture)
- [Configure custom environments](devices/incubator.md#custom-environments)
- [Monitor stability](devices/incubator.md#stability-tracking)
- [Troubleshoot environmental issues](devices/incubator.md#troubleshooting)

---

## Mobile Application

### Features

- Device discovery via mDNS
- WiFi provisioning with captive portal
- Real-time device control
- WebSocket telemetry streaming
- Multi-device management
- Offline mode support
- Push notifications

### Supported Platforms

- **iOS** 13.0+
- **Android** 8.0+ (API 26+)

### Getting the App

- **iOS:** App Store (Coming soon)
- **Android:** Google Play Store (Coming soon)
- **Development:** Build from source

---

## Web Dashboard

### Features

- Browser-based device control
- Multi-device dashboard
- Historical data visualization
- Experiment management
- Data export (CSV, JSON)
- User account management

### Supported Browsers

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

### Accessing the Dashboard

- **Production:** https://app.axionyx.com (Coming soon)
- **Development:** http://localhost:3000

---

## Device Discovery & Pairing

### How Discovery Works

Axionyx devices use **mDNS (Multicast DNS)** for zero-configuration network discovery.

**Discovery Process:**
1. Device boots and starts mDNS service
2. App scans for `_axionyx._tcp.local` services
3. Discovered devices appear in app
4. User selects device to pair

**Network Requirements:**
- Devices and app on same WiFi network
- mDNS/Bonjour not blocked by firewall
- Multicast traffic allowed

### Pairing Workflow

1. **Discover device** on network
2. **Generate pairing code** on device (shown on serial monitor or display)
3. **Enter pairing code** in app
4. **Confirm pairing** - device and app are now linked
5. **Access device** - control and monitor from app

### WiFi Provisioning

**For devices in AP mode (not connected to WiFi):**

1. **Connect to device hotspot** - Network name: `Axionyx-[Type]-[ID]`
2. **Open app** - Captive portal appears automatically
3. **Scan for networks** - App shows available WiFi networks
4. **Enter WiFi credentials** - SSID and password
5. **Submit configuration** - Device connects to WiFi
6. **Reconnect app** - Join same WiFi network as device
7. **Verify connection** - Device should appear in discovery

---

## Real-Time Monitoring

### Telemetry Streams

All devices broadcast real-time telemetry via WebSocket:

**Update Frequency:** 1 Hz (1 update per second)

**PCR Machine Telemetry:**
- Current temperature (all 3 zones)
- Current phase (denaturation, annealing, extension)
- Cycle number and progress percentage
- Time remaining

**Incubator Telemetry:**
- Current temperature, humidity, CO2 level
- Stability status (stable/unstable)
- Time at stable conditions
- Environmental errors

### Viewing Telemetry

**Mobile App:**
- Real-time graphs
- Numeric displays
- Status indicators
- Historical data (last 24 hours)

**Web Dashboard:**
- Multi-device view
- Customizable dashboards
- Export charts as images
- Historical data (all experiments)

---

## Data Export

### Export Formats

- **CSV** - Comma-separated values for Excel/spreadsheets
- **JSON** - Structured data for analysis tools
- **PDF** - Reports with charts and summaries

### What Gets Exported

- Experiment parameters
- Telemetry time series
- Event logs
- Device metadata
- User annotations

### Exporting Data

**Mobile App:**
1. Open experiment details
2. Tap "Export" button
3. Select format
4. Choose destination (email, cloud storage, local)

**Web Dashboard:**
1. Navigate to experiment
2. Click "Export" button
3. Configure export options
4. Download file

---

## Safety & Best Practices

### Device Safety

- Always verify experiment parameters before starting
- Monitor critical experiments in real-time
- Set up alert notifications for errors
- Follow device-specific safety guidelines

### Data Backup

- Export important experiment data regularly
- Enable cloud backup (if available)
- Keep local copies of critical data

### Network Security

- Use strong WiFi passwords
- Change default device passwords
- Enable device authentication
- Keep firmware updated

---

## Troubleshooting

### Common Issues

**Device not discovered:**
- Ensure device and app on same WiFi network
- Check mDNS/Bonjour is enabled
- Restart device and app
- Verify firewall settings

**WiFi provisioning fails:**
- Check WiFi credentials are correct
- Ensure WiFi network is 2.4GHz (ESP32 limitation)
- Move device closer to router
- Check WiFi network is not hidden

**Connection drops:**
- Check WiFi signal strength (RSSI)
- Reduce distance to router
- Minimize interference (microwaves, other devices)
- Update firmware

**Telemetry not updating:**
- Verify WebSocket connection established
- Check network connectivity
- Restart app
- Reboot device

### Getting Help

- Check [Error Codes Reference](../reference/error-codes.md)
- Review device-specific troubleshooting
- Contact support (support@axionyx.com)
- Open GitHub issue for bugs

---

## FAQ

**Q: Can I control devices from multiple apps simultaneously?**
A: Yes, multiple apps can connect to a device at the same time. WebSocket telemetry is broadcast to all connected clients.

**Q: Do devices need internet access?**
A: No, devices work on local WiFi networks without internet. Internet is only needed for cloud features and firmware updates.

**Q: What happens if WiFi connection is lost during an experiment?**
A: Devices continue running autonomously. They'll resume broadcasting telemetry when WiFi reconnects.

**Q: Can I use custom PCR programs?**
A: Yes, you can create custom PCR programs with configurable temperatures, times, and cycle counts.

**Q: How do I update firmware?**
A: Firmware updates can be done OTA (Over-The-Air) via the app or by USB flashing. See [OTA Updates](../device-specs/protocols/ota-updates.md).

---

## Next Steps

- [Explore API Documentation](../api/README.md)
- [Review Device Specifications](../device-specs/README.md)
- [Learn System Architecture](../architecture/README.md)

---

[← Back to Documentation Home](../README.md)
