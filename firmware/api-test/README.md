# Axionyx API Test Suite

Comprehensive API testing scripts for all Axionyx ESP32 device types.

## Overview

This directory contains automated test scripts to verify the REST API functionality of Axionyx devices:
- **Demo/Dummy** - Basic test device
- **PCR** - Thermal cycler machine
- **Incubator** - Environmental control system

## Directory Structure

```
api-test/
├── common/
│   └── api_tester.py       # Common testing framework
├── demo/
│   └── test_demo.py        # Dummy device tests
├── pcr/
│   └── test_pcr.py         # PCR machine tests
├── incubator/
│   └── test_incubator.py   # Incubator tests
├── requirements.txt        # Python dependencies
└── README.md              # This file
```

## Setup

### 1. Install Python Dependencies

```bash
cd firmware/api-test
pip install -r requirements.txt
```

Or using a virtual environment (recommended):

```bash
cd firmware/api-test
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Connect to Device

Make sure your device is running and accessible:

**Option A: Connect to Device AP (Default)**
- Connect to the device's WiFi access point
- Default SSID: `Axionyx-[TYPE]-XXXXXX`
- Default Password: `axionyx123`
- Device IP: `192.168.4.1`

**Option B: Device on Your Network**
- Configure the device to connect to your WiFi
- Find the device IP address from serial monitor or router

## Running Tests

### Test Dummy Device

```bash
# Using default IP (192.168.4.1 - AP mode)
./demo/test_demo.py

# Using custom IP
./demo/test_demo.py --ip 192.168.1.100
```

### Test PCR Machine

```bash
# Using default IP (192.168.4.1 - AP mode)
./pcr/test_pcr.py

# Using custom IP
./pcr/test_pcr.py --ip 192.168.1.101
```

### Test Incubator

```bash
# Using default IP (192.168.4.1 - AP mode)
./incubator/test_incubator.py

# Using custom IP
./incubator/test_incubator.py --ip 192.168.1.102
```

## What Gets Tested

### Common Tests (All Devices)

- **Device Information**
  - Get device info (ID, type, firmware version, MAC)
  - Get device status
  - Verify device type matches expected

- **WiFi Configuration**
  - Get WiFi status
  - Check connection state
  - **Note:** WiFi network scanning is handled by the mobile app/browser, not the ESP32 device

- **Configuration**
  - Get device configuration
  - Verify config structure

- **Device Control**
  - Start device
  - Stop device
  - Pause/Resume (if supported)
  - Verify state transitions

### Device-Specific Tests

#### Dummy Device
- Set temperature setpoint
- Verify setpoint applied
- Read current temperature

#### PCR Machine
- Set multi-zone temperature setpoints
- Start PCR cycle with parameters
- Verify cycling state
- Check cycle count

#### Incubator
- Set environmental parameters (temp, humidity, CO2)
- Start incubator
- Change setpoints
- Verify environmental sensor readings

## Test Output

The tests provide color-coded output:

- ✓ **GREEN** - Test passed
- ✗ **RED** - Test failed
- ○ **YELLOW** - Test skipped

### Example Output

```
======================================================================
Axionyx Device API Test Suite
Device IP: 192.168.4.1
Device Type: DUMMY
======================================================================

======================================================================
Device Information Tests
======================================================================

  ✓ PASS                         Get Device Info
    → HTTP 200
  ✓ PASS                         Verify Device Type
    → Type: DUMMY
  ✓ PASS                         Get Device Status
    → HTTP 200
  ✓ PASS                         Device State
    → State: IDLE, Uptime: 42s

...

======================================================================
Test Summary
======================================================================

  Total Tests:  20
  Passed:       20
  Failed:       0

  Success Rate: 100.0%

  ✓ All tests passed!
```

## Exit Codes

- `0` - All tests passed
- `1` - Some tests failed

This makes the scripts suitable for CI/CD integration.

## Troubleshooting

### Connection Errors

If you get connection errors:
1. Verify device is powered on
2. Check you're connected to the device's WiFi (or same network)
3. Verify the IP address is correct
4. Try pinging the device: `ping 192.168.4.1`

### Test Failures

If tests fail:
1. Check device serial output for errors
2. Verify firmware is up to date
3. Try factory reset: `curl -X POST http://192.168.4.1/api/v1/config/factory-reset`
4. Re-upload firmware

### Import Errors

If you get Python import errors:
1. Make sure you installed dependencies: `pip install -r requirements.txt`
2. Run from the device directory, not from `common/`
3. Check Python version (requires Python 3.7+)

## Advanced Usage

### Using as a Module

You can import the testing framework in your own scripts:

```python
from common.api_tester import APITester, TestCase, TestResult

# Create tester
tester = APITester("192.168.4.1", "DUMMY")

# Run custom test
test = tester.test_endpoint(
    "My Custom Test",
    "GET",
    "/device/status",
    expected_fields=["state"]
)
tester.add_result(test)

# Run standard tests
tester.run_all_tests()
```

### Custom Device Tests

To add custom tests for a specific device:

```python
def my_custom_tests(tester: APITester):
    """Custom device tests"""
    test = tester.test_endpoint(
        "Custom Test",
        "POST",
        "/custom/endpoint",
        data={"param": "value"}
    )
    tester.add_result(test)

# Pass to run_all_tests
tester.run_all_tests(my_custom_tests)
```

## Integration with CI/CD

Example GitHub Actions workflow:

```yaml
- name: Test Dummy Device API
  run: |
    cd firmware/api-test
    pip install -r requirements.txt
    ./demo/test_demo.py --ip $DEVICE_IP
```

## Contributing

When adding new endpoints to the firmware:
1. Add corresponding tests to the device-specific test script
2. Update the common framework if testing new patterns
3. Run tests to ensure compatibility

## License

Part of the Axionyx Biotech IoT Platform
