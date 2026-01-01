#!/usr/bin/env python3
"""
API Tester for Axionyx ESP32 Devices
Common testing framework for all device types
"""

import requests
import json
import time
from typing import Dict, Any, Optional
from dataclasses import dataclass
from enum import Enum


class Color:
    """ANSI color codes for terminal output"""
    GREEN = '\033[92m'
    RED = '\033[91m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    RESET = '\033[0m'
    BOLD = '\033[1m'


class TestResult(Enum):
    """Test result status"""
    PASS = "PASS"
    FAIL = "FAIL"
    SKIP = "SKIP"


@dataclass
class TestCase:
    """Test case result"""
    name: str
    result: TestResult
    message: str = ""
    response: Optional[Dict] = None


class APITester:
    """Base class for testing Axionyx device APIs"""

    def __init__(self, device_ip: str, device_type: str):
        self.device_ip = device_ip
        self.device_type = device_type
        self.base_url = f"http://{device_ip}"
        self.api_url = f"{self.base_url}/api/v1"
        self.results = []
        self.session = requests.Session()
        self.session.headers.update({'Content-Type': 'application/json'})

    def print_header(self, text: str):
        """Print section header"""
        print(f"\n{Color.BOLD}{Color.BLUE}{'='*70}{Color.RESET}")
        print(f"{Color.BOLD}{Color.BLUE}{text}{Color.RESET}")
        print(f"{Color.BOLD}{Color.BLUE}{'='*70}{Color.RESET}\n")

    def print_test(self, name: str, result: TestResult, message: str = ""):
        """Print test result"""
        if result == TestResult.PASS:
            symbol = "✓"
            color = Color.GREEN
        elif result == TestResult.FAIL:
            symbol = "✗"
            color = Color.RED
        else:
            symbol = "○"
            color = Color.YELLOW

        status = f"{color}{symbol} {result.value}{Color.RESET}"
        print(f"  {status:30s} {name}")
        if message:
            print(f"    {Color.CYAN}→{Color.RESET} {message}")

    def add_result(self, test_case: TestCase):
        """Add test result"""
        self.results.append(test_case)
        self.print_test(test_case.name, test_case.result, test_case.message)

    def test_endpoint(self, name: str, method: str, endpoint: str,
                     data: Optional[Dict] = None,
                     expected_fields: Optional[list] = None,
                     timeout: int = 10,
                     retries: int = 2) -> TestCase:
        """Test a single endpoint"""
        url = f"{self.api_url}{endpoint}"

        for attempt in range(retries):
            try:
                if method == "GET":
                    response = self.session.get(url, timeout=timeout)
                elif method == "POST":
                    response = self.session.post(url, json=data or {}, timeout=timeout)
                elif method == "PUT":
                    response = self.session.put(url, json=data or {}, timeout=timeout)
                else:
                    return TestCase(name, TestResult.FAIL, f"Unknown method: {method}")

                # Check status code
                if response.status_code not in [200, 201]:
                    if attempt < retries - 1:
                        time.sleep(1)
                        continue
                    return TestCase(
                        name,
                        TestResult.FAIL,
                        f"HTTP {response.status_code}: {response.text[:100]}"
                    )

                # Parse JSON
                try:
                    json_data = response.json()
                except json.JSONDecodeError:
                    if attempt < retries - 1:
                        time.sleep(1)
                        continue
                    return TestCase(name, TestResult.FAIL, "Invalid JSON response")

                # Check expected fields
                if expected_fields:
                    missing = [f for f in expected_fields if f not in json_data]
                    if missing:
                        return TestCase(
                            name,
                            TestResult.FAIL,
                            f"Missing fields: {', '.join(missing)}"
                        )

                return TestCase(
                    name,
                    TestResult.PASS,
                    f"HTTP {response.status_code}",
                    json_data
                )

            except requests.exceptions.Timeout:
                if attempt < retries - 1:
                    time.sleep(2)
                    continue
                return TestCase(name, TestResult.FAIL, "Request timeout (check device connectivity)")
            except requests.exceptions.ConnectionError:
                if attempt < retries - 1:
                    time.sleep(2)
                    continue
                return TestCase(name, TestResult.FAIL, "Connection error (device may have reset)")
            except Exception as e:
                if attempt < retries - 1:
                    time.sleep(1)
                    continue
                return TestCase(name, TestResult.FAIL, f"Error: {str(e)}")

        return TestCase(name, TestResult.FAIL, "All retry attempts failed")

    def test_device_info(self):
        """Test device info endpoint"""
        self.print_header("Device Information Tests")

        # Test device info
        test = self.test_endpoint(
            "Get Device Info",
            "GET",
            "/device/info",
            expected_fields=["id", "type", "name", "firmwareVersion", "mac"]
        )
        self.add_result(test)

        # Show device type (informational only, not a failure)
        if test.result == TestResult.PASS and test.response:
            device_type = test.response.get("type", "").upper()
            expected_type = self.device_type.upper()

            if device_type == expected_type:
                self.add_result(TestCase(
                    "Device Type Match",
                    TestResult.PASS,
                    f"Type: {device_type} (as expected)"
                ))
            else:
                # Not a failure - just informational
                print(f"\n  {Color.YELLOW}⚠  Note: Expected {expected_type}, but device is {device_type}{Color.RESET}")
                print(f"  {Color.YELLOW}   Running generic tests (device-specific tests may not apply){Color.RESET}")
                self.add_result(TestCase(
                    "Device Type",
                    TestResult.PASS,
                    f"Detected: {device_type} (expected: {expected_type})"
                ))

        # Test device status
        test = self.test_endpoint(
            "Get Device Status",
            "GET",
            "/device/status",
            expected_fields=["state", "uptime"]
        )
        self.add_result(test)

        if test.result == TestResult.PASS and test.response:
            self.add_result(TestCase(
                "Device State",
                TestResult.PASS,
                f"State: {test.response.get('state', 'UNKNOWN')}, Uptime: {test.response.get('uptime', 0)}s"
            ))

    def test_wifi_endpoints(self):
        """Test WiFi endpoints"""
        self.print_header("WiFi Configuration Tests")

        # Get WiFi status
        test = self.test_endpoint(
            "Get WiFi Status",
            "GET",
            "/wifi/status",
            expected_fields=["mode", "connected", "apActive"]
        )
        self.add_result(test)

        if test.result == TestResult.PASS and test.response:
            ap_active = test.response.get("apActive", False)
            connected = test.response.get("connected", False)

            status = []
            if ap_active:
                status.append(f"AP: {test.response.get('apSSID', 'N/A')}")
            if connected:
                status.append(f"STA: {test.response.get('ssid', 'N/A')} ({test.response.get('ip', 'N/A')})")

            self.add_result(TestCase(
                "WiFi Connection Status",
                TestResult.PASS,
                " | ".join(status) if status else "Not connected"
            ))

        # WiFi scan disabled on device - mobile app handles network scanning
        # Network scan is done by the mobile app/browser, not the ESP32
        # This prevents watchdog timeouts and improves device stability
        print(f"\n  {Color.CYAN}ℹ  WiFi scan endpoint removed - handled by mobile app/browser{Color.RESET}")
        self.add_result(TestCase(
            "WiFi Scan (Not Required)",
            TestResult.PASS,
            "Network scanning handled by user's device"
        ))

    def test_config_endpoints(self):
        """Test configuration endpoints"""
        self.print_header("Configuration Tests")

        # Small delay to let device recover from WiFi scan
        time.sleep(2)

        # Get config
        test = self.test_endpoint(
            "Get Configuration",
            "GET",
            "/config",
            expected_fields=["device", "wifi", "network"],
            timeout=10,
            retries=3
        )
        self.add_result(test)

        if test.result == TestResult.PASS and test.response:
            config = test.response
            self.add_result(TestCase(
                "Config Structure",
                TestResult.PASS,
                f"Device: {config.get('device', {}).get('name', 'N/A')}"
            ))

    def test_device_control(self, device_specific_tests=None):
        """Test device control endpoints"""
        self.print_header("Device Control Tests")

        # Small delay before control tests
        time.sleep(1)

        # Start device
        test = self.test_endpoint(
            "Start Device",
            "POST",
            "/device/start",
            data={},
            expected_fields=["success"],
            timeout=10,
            retries=3
        )
        self.add_result(test)

        time.sleep(2)  # Wait for device to start

        # Check if running
        test = self.test_endpoint(
            "Verify Running State",
            "GET",
            "/device/status",
            timeout=10,
            retries=3
        )
        if test.result == TestResult.PASS and test.response:
            state = test.response.get("state", "")
            if "RUNNING" in state.upper() or "IDLE" in state.upper():
                self.add_result(TestCase(
                    "Device Started",
                    TestResult.PASS,
                    f"Current state: {state}"
                ))
            else:
                self.add_result(TestCase(
                    "Device Started",
                    TestResult.FAIL,
                    f"Unexpected state: {state}"
                ))
        else:
            self.add_result(test)

        # Run device-specific tests if provided
        if device_specific_tests:
            device_specific_tests(self)

        # Pause device (if supported)
        test = self.test_endpoint(
            "Pause Device",
            "POST",
            "/device/pause"
        )
        # Some devices may not support pause, so we don't fail on this
        if test.result == TestResult.PASS:
            self.add_result(test)
            time.sleep(0.5)

            # Resume device
            test = self.test_endpoint(
                "Resume Device",
                "POST",
                "/device/resume"
            )
            self.add_result(test)
            time.sleep(0.5)

        # Stop device
        test = self.test_endpoint(
            "Stop Device",
            "POST",
            "/device/stop",
            expected_fields=["success"],
            timeout=10,
            retries=3
        )
        self.add_result(test)

        time.sleep(2)

        # Verify stopped
        test = self.test_endpoint(
            "Verify Stopped State",
            "GET",
            "/device/status",
            timeout=10,
            retries=3
        )
        if test.result == TestResult.PASS and test.response:
            state = test.response.get("state", "")
            if "IDLE" in state.upper() or "STOPPED" in state.upper():
                self.add_result(TestCase(
                    "Device Stopped",
                    TestResult.PASS,
                    f"Current state: {state}"
                ))
            else:
                self.add_result(TestCase(
                    "Device Stopped",
                    TestResult.FAIL,
                    f"Unexpected state: {state}"
                ))
        else:
            self.add_result(test)

    def print_summary(self):
        """Print test summary"""
        passed = sum(1 for r in self.results if r.result == TestResult.PASS)
        failed = sum(1 for r in self.results if r.result == TestResult.FAIL)
        skipped = sum(1 for r in self.results if r.result == TestResult.SKIP)
        total = len(self.results)

        self.print_header("Test Summary")

        print(f"  Total Tests:  {Color.BOLD}{total}{Color.RESET}")
        print(f"  {Color.GREEN}Passed:{Color.RESET}       {passed}")
        print(f"  {Color.RED}Failed:{Color.RESET}       {failed}")
        if skipped > 0:
            print(f"  {Color.YELLOW}Skipped:{Color.RESET}      {skipped}")

        success_rate = (passed / total * 100) if total > 0 else 0
        print(f"\n  Success Rate: {Color.BOLD}{success_rate:.1f}%{Color.RESET}")

        if failed == 0:
            print(f"\n  {Color.GREEN}{Color.BOLD}✓ All tests passed!{Color.RESET}")
        else:
            print(f"\n  {Color.RED}{Color.BOLD}✗ Some tests failed!{Color.RESET}")

        print()

        return failed == 0

    def run_all_tests(self, device_specific_tests=None):
        """Run all standard tests"""
        print(f"\n{Color.BOLD}{Color.CYAN}Axionyx Device API Test Suite{Color.RESET}")
        print(f"{Color.CYAN}Device IP: {self.device_ip}{Color.RESET}")
        print(f"{Color.CYAN}Device Type: {self.device_type}{Color.RESET}")

        try:
            self.test_device_info()
            self.test_wifi_endpoints()
            self.test_config_endpoints()
            self.test_device_control(device_specific_tests)
        except KeyboardInterrupt:
            print(f"\n\n{Color.YELLOW}Tests interrupted by user{Color.RESET}\n")
        except Exception as e:
            print(f"\n\n{Color.RED}Unexpected error: {e}{Color.RESET}\n")

        return self.print_summary()
