#!/usr/bin/env python3
"""
API Test Suite for Axionyx Dummy Device
Tests basic device functionality and API endpoints
"""

import sys
import os
import argparse

# Add parent directory to path to import common module
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from common.api_tester import APITester, TestCase, TestResult


def dummy_specific_tests(tester: APITester):
    """Dummy device specific tests"""
    import time

    # Test setpoint (dummy has simple temperature control)
    test = tester.test_endpoint(
        "Set Temperature Setpoint",
        "PUT",
        "/device/setpoint",
        data={"zone": 0, "temperature": 37.0},
        expected_fields=["success"],
        timeout=10,
        retries=3
    )
    tester.add_result(test)

    time.sleep(1)

    # Verify setpoint was applied
    test = tester.test_endpoint(
        "Verify Setpoint Applied",
        "GET",
        "/device/status",
        timeout=10,
        retries=3
    )
    if test.result == TestResult.PASS and test.response:
        setpoint = test.response.get("setpoint")
        temperature = test.response.get("temperature")

        if setpoint is not None:
            tester.add_result(TestCase(
                "Read Setpoint",
                TestResult.PASS,
                f"Setpoint: {setpoint}°C, Current: {temperature}°C"
            ))
        else:
            tester.add_result(TestCase(
                "Read Setpoint",
                TestResult.FAIL,
                "Setpoint not found in status"
            ))


def main():
    parser = argparse.ArgumentParser(description='Test Axionyx Dummy Device API')
    parser.add_argument(
        '--ip',
        default='192.168.4.1',
        help='Device IP address (default: 192.168.4.1 - AP mode)'
    )
    args = parser.parse_args()

    # Create tester instance
    tester = APITester(args.ip, "DUMMY")

    # Run all tests
    success = tester.run_all_tests(dummy_specific_tests)

    # Exit with appropriate code
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
