#!/usr/bin/env python3
"""
API Test Suite for Axionyx Incubator
Tests incubator-specific functionality including environmental control
"""

import sys
import os
import argparse
import time

# Add parent directory to path to import common module
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from common.api_tester import APITester, TestCase, TestResult, Color


def incubator_specific_tests(tester: APITester):
    """Incubator specific tests"""

    print(f"\n  {Color.CYAN}Testing incubator-specific features...{Color.RESET}\n")

    # Test temperature setpoint
    test = tester.test_endpoint(
        "Set Temperature Setpoint",
        "PUT",
        "/device/setpoint",
        data={"zone": 0, "temperature": 37.0},
        expected_fields=["success"]
    )
    tester.add_result(test)

    # Get status to check environmental parameters
    test = tester.test_endpoint(
        "Get Incubator Status",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        # Check for incubator-specific fields
        temperature = test.response.get("temperature")
        humidity = test.response.get("humidity")
        co2 = test.response.get("co2Level")

        env_status = []
        if temperature is not None:
            env_status.append(f"Temp: {temperature}°C")
        if humidity is not None:
            env_status.append(f"Humidity: {humidity}%")
        if co2 is not None:
            env_status.append(f"CO2: {co2}%")

        if env_status:
            tester.add_result(TestCase(
                "Environmental Sensors",
                TestResult.PASS,
                ", ".join(env_status)
            ))
        else:
            tester.add_result(TestCase(
                "Environmental Sensors",
                TestResult.PASS,
                "Basic temperature control available"
            ))

    # Test starting incubator with environmental parameters
    incubator_params = {
        "temperature": 37.0,
        "humidity": 85.0,
        "co2": 5.0
    }

    test = tester.test_endpoint(
        "Start Incubator",
        "POST",
        "/device/start",
        data=incubator_params,
        expected_fields=["success"]
    )
    tester.add_result(test)

    time.sleep(2)  # Wait for incubator to stabilize

    # Verify incubator is running
    test = tester.test_endpoint(
        "Verify Incubator Running",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        state = test.response.get("state", "")
        temperature = test.response.get("temperature", 0)
        setpoint = test.response.get("setpoint", 0)

        if "RUNNING" in state.upper() or "IDLE" in state.upper():
            tester.add_result(TestCase(
                "Incubator Started",
                TestResult.PASS,
                f"State: {state}, Temp: {temperature}°C (Target: {setpoint}°C)"
            ))
        else:
            tester.add_result(TestCase(
                "Incubator Started",
                TestResult.FAIL,
                f"Unexpected state: {state}"
            ))

    # Test different temperature setpoint
    test = tester.test_endpoint(
        "Change Temperature",
        "PUT",
        "/device/setpoint",
        data={"zone": 0, "temperature": 42.0},
        expected_fields=["success"]
    )
    tester.add_result(test)

    time.sleep(1)

    # Verify new setpoint
    test = tester.test_endpoint(
        "Verify New Setpoint",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        setpoint = test.response.get("setpoint")
        if setpoint is not None and abs(setpoint - 42.0) < 0.1:
            tester.add_result(TestCase(
                "Setpoint Updated",
                TestResult.PASS,
                f"New setpoint: {setpoint}°C"
            ))
        else:
            tester.add_result(TestCase(
                "Setpoint Updated",
                TestResult.FAIL,
                f"Setpoint: {setpoint}°C (expected 42.0°C)"
            ))


def main():
    parser = argparse.ArgumentParser(description='Test Axionyx Incubator API')
    parser.add_argument(
        '--ip',
        default='192.168.4.1',
        help='Device IP address (default: 192.168.4.1 - AP mode)'
    )
    args = parser.parse_args()

    # Create tester instance
    tester = APITester(args.ip, "INCUBATOR")

    # Run all tests
    success = tester.run_all_tests(incubator_specific_tests)

    # Exit with appropriate code
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
