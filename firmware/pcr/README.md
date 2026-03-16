# PCR Machine Firmware

Single-zone thermal cycler for DNA amplification — ESP8266MOD (NodeMCU v2).

**Hardware:**
- NTC3950 thermistor → A0 (10kΩ series resistor)
- Ceramic cartridge heater via IRFZ44N MOSFET → D5 (GPIO14)
- Fan via IRFZ44N MOSFET → D6 (GPIO12)

---

## Quick Flash

```bash
cd firmware/pcr
pio run --target upload
pio device monitor --baud 115200
```

Upload speed is set to 921600 in `platformio.ini`. If upload fails, try lowering it to `460800`.

---

## Documentation

📚 **Complete PCR documentation:**

**[docs/device-specs/pcr-machine.md](../../docs/device-specs/pcr-machine.md)**

Includes:
- Technical specifications
- PCR cycling phases
- API usage examples
- Default programs
- Applications

---

## Quick Links

- **[Device Specifications](../../docs/device-specs/pcr-machine.md)** - Complete PCR specs
- **[API Documentation](../../docs/api/README.md)** - Device control API
- **[Firmware Setup](../../docs/getting-started/firmware-setup.md)** - Setup guide

---

For complete documentation, see **[docs/](../../docs/README.md)**
