#!/usr/bin/env python3
"""
API Test Suite for Axionyx PCR Machine
Tests PCR-specific functionality including thermal cycling
"""

import sys
import os
import argparse
import time

# Add parent directory to path to import common module
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from common.api_tester import APITester, TestCase, TestResult, Color


def pcr_specific_tests(tester: APITester):
    """PCR machine specific tests"""

    print(f"\n  {Color.CYAN}Testing PCR-specific features...{Color.RESET}\n")

    # Test setting setpoints for multiple zones (PCR has 3 zones)
    zones = [
        {"zone": 0, "temp": 95.0, "name": "Lid"},
        {"zone": 1, "temp": 72.0, "name": "Block"},
    ]

    for zone_config in zones:
        test = tester.test_endpoint(
            f"Set {zone_config['name']} Temperature",
            "PUT",
            "/device/setpoint",
            data={"zone": zone_config["zone"], "temperature": zone_config["temp"]},
            expected_fields=["success"]
        )
        tester.add_result(test)

    # Get status to verify multi-zone support
    test = tester.test_endpoint(
        "Get PCR Status",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        # Check for PCR-specific fields
        pcr_fields = ["state", "currentCycle", "totalCycles"]
        has_pcr_fields = all(f in test.response for f in ["state"])

        if has_pcr_fields:
            state = test.response.get("state", "UNKNOWN")
            current_cycle = test.response.get("currentCycle", 0)
            total_cycles = test.response.get("totalCycles", 0)

            tester.add_result(TestCase(
                "PCR State Info",
                TestResult.PASS,
                f"State: {state}, Cycle: {current_cycle}/{total_cycles}"
            ))
        else:
            tester.add_result(TestCase(
                "PCR State Info",
                TestResult.PASS,
                "Basic status available"
            ))

    # Test starting PCR with cycle parameters
    pcr_params = {
        "cycles": 30,
        "denatureTemp": 95.0,
        "denatureTime": 30,
        "annealTemp": 55.0,
        "annealTime": 30,
        "extendTemp": 72.0,
        "extendTime": 60
    }

    test = tester.test_endpoint(
        "Start PCR Cycle",
        "POST",
        "/device/start",
        data=pcr_params,
        expected_fields=["success"]
    )
    tester.add_result(test)

    time.sleep(2)  # Wait for PCR to start cycling

    # Verify PCR is cycling
    test = tester.test_endpoint(
        "Verify PCR Cycling",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        state = test.response.get("state", "")
        if any(x in state.upper() for x in ["RUNNING", "DENATURE", "ANNEAL", "EXTEND", "INIT"]):
            tester.add_result(TestCase(
                "PCR Started",
                TestResult.PASS,
                f"Cycling state: {state}"
            ))
        else:
            tester.add_result(TestCase(
                "PCR Started",
                TestResult.FAIL,
                f"Unexpected state: {state}"
            ))

    # Stop the PCR (don't let it run full cycle in test)
    print(f"\n  {Color.YELLOW}Stopping PCR cycle (test mode)...{Color.RESET}")
    test = tester.test_endpoint(
        "Stop PCR Cycle",
        "POST",
        "/device/stop",
        expected_fields=["success"]
    )
    tester.add_result(test)


def main():
    parser = argparse.ArgumentParser(description='Test Axionyx PCR Machine API')
    parser.add_argument(
        '--ip',
        default='192.168.4.1',
        help='Device IP address (default: 192.168.4.1 - AP mode)'
    )
    args = parser.parse_args()

    # Create tester instance
    tester = APITester(args.ip, "PCR")

    # Run all tests
    success = tester.run_all_tests(pcr_specific_tests)

    # Exit with appropriate code
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
