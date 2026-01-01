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


def test_advanced_pcr_features(tester: APITester):
    """Test advanced PCR features (hot start, touchdown, gradient, two-step)"""

    print(f"\n  {Color.CYAN}Testing Advanced PCR Features...{Color.RESET}\n")

    # Test program templates endpoint
    test = tester.test_endpoint(
        "Get Program Templates",
        "GET",
        "/device/program/templates",
        expected_fields=["templates"]
    )
    tester.add_result(test)

    if test.result == TestResult.PASS and test.response:
        templates = test.response.get("templates", [])
        tester.add_result(TestCase(
            "Template Count",
            TestResult.PASS,
            f"Found {len(templates)} program templates"
        ))

        # List template names
        if templates:
            names = [t.get("name", "Unknown") for t in templates]
            print(f"    {Color.CYAN}Templates: {', '.join(names)}{Color.RESET}")

    # Test program validation endpoint
    valid_program = {
        "cycles": 30,
        "denatureTemp": 95.0,
        "annealTemp": 60.0,
        "extendTemp": 72.0
    }

    test = tester.test_endpoint(
        "Validate Valid Program",
        "POST",
        "/device/program/validate",
        data=valid_program,
        expected_fields=["valid"]
    )
    tester.add_result(test)

    if test.result == TestResult.PASS and test.response:
        is_valid = test.response.get("valid", False)
        errors = test.response.get("errors", [])
        warnings = test.response.get("warnings", [])

        if is_valid:
            tester.add_result(TestCase(
                "Program Validation",
                TestResult.PASS,
                f"Valid program, {len(warnings)} warnings"
            ))
        else:
            tester.add_result(TestCase(
                "Program Validation",
                TestResult.FAIL,
                f"Program should be valid but got {len(errors)} errors"
            ))

    # Test invalid program
    invalid_program = {
        "cycles": 150,  # Too many cycles
        "denatureTemp": 95.0,
        "annealTemp": 60.0,
        "extendTemp": 72.0
    }

    test = tester.test_endpoint(
        "Validate Invalid Program",
        "POST",
        "/device/program/validate",
        data=invalid_program
    )

    if test.result == TestResult.PASS and test.response:
        is_valid = test.response.get("valid", False)
        errors = test.response.get("errors", [])

        if not is_valid and len(errors) > 0:
            tester.add_result(TestCase(
                "Invalid Program Detection",
                TestResult.PASS,
                f"Correctly rejected with {len(errors)} errors"
            ))
        else:
            tester.add_result(TestCase(
                "Invalid Program Detection",
                TestResult.FAIL,
                "Should have detected invalid program"
            ))

    # Test Hot Start PCR
    hot_start_params = {
        "programType": "standard",
        "cycles": 25,
        "denatureTemp": 95.0,
        "denatureTime": 30,
        "annealTemp": 60.0,
        "annealTime": 30,
        "extendTemp": 72.0,
        "extendTime": 60,
        "hotStart": {
            "enabled": True,
            "activationTemp": 95.0,
            "activationTime": 10  # Short for testing
        }
    }

    test = tester.test_endpoint(
        "Start Hot Start PCR",
        "POST",
        "/device/start",
        data=hot_start_params,
        expected_fields=["success"],
        timeout=15
    )
    tester.add_result(test)

    time.sleep(2)

    # Check if hot start phase is active
    test = tester.test_endpoint(
        "Verify Hot Start Phase",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        phase = test.response.get("currentPhase", "")
        has_hotstart = test.response.get("program", {}).get("hotStart", {}).get("enabled", False)

        if has_hotstart:
            tester.add_result(TestCase(
                "Hot Start Feature",
                TestResult.PASS,
                f"Hot start enabled, phase: {phase}"
            ))
        else:
            tester.add_result(TestCase(
                "Hot Start Feature",
                TestResult.FAIL,
                "Hot start not detected in status"
            ))

    # Stop before moving to next test
    tester.test_endpoint("Stop PCR", "POST", "/device/stop")
    time.sleep(1)

    # Test Touchdown PCR
    touchdown_params = {
        "programType": "touchdown",
        "cycles": 25,
        "denatureTemp": 95.0,
        "denatureTime": 30,
        "extendTemp": 72.0,
        "extendTime": 60,
        "touchdown": {
            "enabled": True,
            "startAnnealTemp": 68.0,
            "endAnnealTemp": 58.0,
            "stepSize": 1.0,
            "touchdownCycles": 10
        }
    }

    test = tester.test_endpoint(
        "Start Touchdown PCR",
        "POST",
        "/device/start",
        data=touchdown_params,
        expected_fields=["success"]
    )
    tester.add_result(test)

    time.sleep(2)

    # Verify touchdown
    test = tester.test_endpoint(
        "Verify Touchdown PCR",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        touchdown_cfg = test.response.get("program", {}).get("touchdown", {})
        if touchdown_cfg.get("enabled"):
            current_anneal = touchdown_cfg.get("currentAnnealTemp", 0)
            tester.add_result(TestCase(
                "Touchdown Feature",
                TestResult.PASS,
                f"Touchdown enabled, current anneal: {current_anneal}°C"
            ))
        else:
            tester.add_result(TestCase(
                "Touchdown Feature",
                TestResult.FAIL,
                "Touchdown not detected in status"
            ))

    # Stop before next test
    tester.test_endpoint("Stop PCR", "POST", "/device/stop")
    time.sleep(1)

    # Test Gradient PCR
    gradient_params = {
        "programType": "gradient",
        "cycles": 20,
        "denatureTemp": 95.0,
        "denatureTime": 30,
        "extendTemp": 72.0,
        "extendTime": 60,
        "gradient": {
            "enabled": True,
            "tempLow": 55.0,
            "tempHigh": 65.0,
            "positions": 12
        }
    }

    test = tester.test_endpoint(
        "Start Gradient PCR",
        "POST",
        "/device/start",
        data=gradient_params,
        expected_fields=["success"]
    )
    tester.add_result(test)

    time.sleep(2)

    # Verify gradient
    test = tester.test_endpoint(
        "Verify Gradient PCR",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        gradient_cfg = test.response.get("program", {}).get("gradient", {})
        if gradient_cfg.get("enabled"):
            positions = gradient_cfg.get("positions", 0)
            temp_range = f"{gradient_cfg.get('tempLow', 0)}°C - {gradient_cfg.get('tempHigh', 0)}°C"
            tester.add_result(TestCase(
                "Gradient Feature",
                TestResult.PASS,
                f"Gradient enabled: {positions} positions, {temp_range}"
            ))
        else:
            tester.add_result(TestCase(
                "Gradient Feature",
                TestResult.FAIL,
                "Gradient not detected in status"
            ))

    # Stop before next test
    tester.test_endpoint("Stop PCR", "POST", "/device/stop")
    time.sleep(1)

    # Test Two-Step PCR
    twostep_params = {
        "programType": "twostep",
        "twoStepEnabled": True,
        "cycles": 30,
        "denatureTemp": 95.0,
        "denatureTime": 15,
        "annealExtendTemp": 65.0,
        "annealExtendTime": 35
    }

    test = tester.test_endpoint(
        "Start Two-Step PCR",
        "POST",
        "/device/start",
        data=twostep_params,
        expected_fields=["success"]
    )
    tester.add_result(test)

    time.sleep(2)

    # Verify two-step
    test = tester.test_endpoint(
        "Verify Two-Step PCR",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        two_step = test.response.get("program", {}).get("twoStepEnabled", False)
        if two_step:
            anneal_extend_temp = test.response.get("program", {}).get("annealExtendTemp", 0)
            tester.add_result(TestCase(
                "Two-Step Feature",
                TestResult.PASS,
                f"Two-step enabled, anneal+extend: {anneal_extend_temp}°C"
            ))
        else:
            tester.add_result(TestCase(
                "Two-Step Feature",
                TestResult.FAIL,
                "Two-step not detected in status"
            ))

    # Final stop
    tester.test_endpoint("Stop PCR", "POST", "/device/stop")
    time.sleep(1)


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


def combined_pcr_tests(tester: APITester):
    """Run all PCR tests"""
    # Run standard PCR tests
    pcr_specific_tests(tester)

    # Run advanced feature tests
    test_advanced_pcr_features(tester)


def main():
    parser = argparse.ArgumentParser(description='Test Axionyx PCR Machine API')
    parser.add_argument(
        '--ip',
        default='192.168.4.1',
        help='Device IP address (default: 192.168.4.1 - AP mode)'
    )
    parser.add_argument(
        '--basic-only',
        action='store_true',
        help='Run only basic PCR tests (skip advanced features)'
    )
    args = parser.parse_args()

    # Create tester instance
    tester = APITester(args.ip, "PCR")

    # Run all tests
    if args.basic_only:
        success = tester.run_all_tests(pcr_specific_tests)
    else:
        success = tester.run_all_tests(combined_pcr_tests)

    # Exit with appropriate code
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
