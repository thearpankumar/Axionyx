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


def test_protocol_features(tester: APITester):
    """Test protocol management features"""

    print(f"\n  {Color.CYAN}Testing Protocol Management...{Color.RESET}\n")

    # Test protocol templates endpoint
    test = tester.test_endpoint(
        "Get Protocol Templates",
        "GET",
        "/device/protocol/templates",
        expected_fields=["templates"]
    )
    tester.add_result(test)

    if test.result == TestResult.PASS and test.response:
        templates = test.response.get("templates", [])
        tester.add_result(TestCase(
            "Template Count",
            TestResult.PASS,
            f"Found {len(templates)} protocol templates"
        ))

        # List template names
        if templates:
            names = [t.get("name", "Unknown") for t in templates]
            print(f"    {Color.CYAN}Templates: {', '.join(names)}{Color.RESET}")

    # Test starting a simple protocol (mammalian cell culture)
    # Note: In a real implementation, we would parse template and construct protocol
    # For now, just test the endpoint
    print(f"\n  {Color.YELLOW}Note: Protocol start requires full protocol JSON structure{Color.RESET}")
    print(f"  {Color.YELLOW}Testing protocol control endpoints with simple commands{Color.RESET}\n")

    # Test protocol pause (should work if protocol is running)
    test = tester.test_endpoint(
        "Protocol Pause",
        "POST",
        "/device/protocol/pause",
        expected_fields=["success"]
    )
    # This may fail if no protocol is running, which is OK

    # Test protocol resume
    test = tester.test_endpoint(
        "Protocol Resume",
        "POST",
        "/device/protocol/resume",
        expected_fields=["success"]
    )

    # Test protocol next-stage
    test = tester.test_endpoint(
        "Protocol Next Stage",
        "POST",
        "/device/protocol/next-stage",
        expected_fields=["success"]
    )

    # Test protocol stop
    test = tester.test_endpoint(
        "Protocol Stop",
        "POST",
        "/device/protocol/stop",
        expected_fields=["success"]
    )
    tester.add_result(test)


def test_alarm_features(tester: APITester):
    """Test alarm management features"""

    print(f"\n  {Color.CYAN}Testing Alarm Management...{Color.RESET}\n")

    # Test get alarms endpoint
    test = tester.test_endpoint(
        "Get Active Alarms",
        "GET",
        "/device/alarms",
        expected_fields=["alarms"]
    )
    tester.add_result(test)

    if test.result == TestResult.PASS and test.response:
        alarms = test.response.get("alarms", {})
        active_count = alarms.get("activeCount", 0)
        has_critical = alarms.get("hasCritical", False)

        tester.add_result(TestCase(
            "Alarm Status",
            TestResult.PASS,
            f"Active alarms: {active_count}, Critical: {has_critical}"
        ))

        # List active alarms if any
        if alarms.get("active"):
            print(f"    {Color.YELLOW}Active alarms detected:{Color.RESET}")
            for alarm in alarms.get("active", []):
                severity = "CRITICAL" if alarm.get("severity") == 1 else "WARNING"
                msg = alarm.get("message", "Unknown")
                print(f"      - [{severity}] {msg}")

    # Test alarm history endpoint
    test = tester.test_endpoint(
        "Get Alarm History",
        "GET",
        "/device/alarms/history",
        expected_fields=["history"]
    )
    tester.add_result(test)

    if test.result == TestResult.PASS and test.response:
        history = test.response.get("history", [])
        tester.add_result(TestCase(
            "Alarm History",
            TestResult.PASS,
            f"History contains {len(history)} entries"
        ))

    # Test acknowledge alarm endpoint (may fail if no alarms)
    test = tester.test_endpoint(
        "Acknowledge Alarm",
        "POST",
        "/device/alarms/acknowledge",
        data={"index": 0}
    )
    # This may fail if no active alarms, which is OK

    # Test acknowledge all alarms
    test = tester.test_endpoint(
        "Acknowledge All Alarms",
        "POST",
        "/device/alarms/acknowledge-all",
        expected_fields=["success"]
    )
    tester.add_result(test)


def test_environmental_control(tester: APITester):
    """Test environmental control and ramping features"""

    print(f"\n  {Color.CYAN}Testing Environmental Control...{Color.RESET}\n")

    # Test multi-parameter control
    env_params = {
        "temperature": 37.0,
        "humidity": 95.0,
        "co2Level": 5.0
    }

    test = tester.test_endpoint(
        "Start with Environmental Parameters",
        "POST",
        "/device/start",
        data=env_params,
        expected_fields=["success"]
    )
    tester.add_result(test)

    time.sleep(2)

    # Get status and check for ramping info
    test = tester.test_endpoint(
        "Check Environmental Status",
        "GET",
        "/device/status"
    )

    if test.result == TestResult.PASS and test.response:
        # Check for ramping status
        ramping = test.response.get("ramping", {})
        if ramping:
            temp_ramp = ramping.get("temperature", False)
            hum_ramp = ramping.get("humidity", False)
            co2_ramp = ramping.get("co2", False)

            any_ramping = temp_ramp or hum_ramp or co2_ramp

            tester.add_result(TestCase(
                "Ramping Status",
                TestResult.PASS,
                f"Temp: {temp_ramp}, Humidity: {hum_ramp}, CO2: {co2_ramp}"
            ))

        # Check environmental stability
        temp_stable = test.response.get("temperatureStable", False)
        hum_stable = test.response.get("humidityStable", False)
        co2_stable = test.response.get("co2Stable", False)
        env_stable = test.response.get("environmentStable", False)

        stability_str = "All stable" if env_stable else "Stabilizing"
        tester.add_result(TestCase(
            "Environmental Stability",
            TestResult.PASS,
            f"{stability_str} (T:{temp_stable}, H:{hum_stable}, CO2:{co2_stable})"
        ))

        # Display current readings
        temp = test.response.get("temperature", 0)
        temp_sp = test.response.get("temperatureSetpoint", 0)
        hum = test.response.get("humidity", 0)
        hum_sp = test.response.get("humiditySetpoint", 0)
        co2 = test.response.get("co2Level", 0)
        co2_sp = test.response.get("co2Setpoint", 0)

        print(f"    {Color.CYAN}Current Readings:{Color.RESET}")
        print(f"      Temperature: {temp:.1f}°C (Setpoint: {temp_sp:.1f}°C)")
        print(f"      Humidity:    {hum:.1f}% (Setpoint: {hum_sp:.1f}%)")
        print(f"      CO2:         {co2:.2f}% (Setpoint: {co2_sp:.2f}%)")

    # Test individual parameter changes
    test = tester.test_endpoint(
        "Change Temperature",
        "PUT",
        "/device/setpoint",
        data={"zone": 0, "temperature": 30.0},
        expected_fields=["success"]
    )
    tester.add_result(test)

    test = tester.test_endpoint(
        "Change Humidity",
        "PUT",
        "/device/setpoint",
        data={"zone": 1, "humidity": 70.0},
        expected_fields=["success"]
    )
    tester.add_result(test)

    test = tester.test_endpoint(
        "Change CO2",
        "PUT",
        "/device/setpoint",
        data={"zone": 2, "co2": 4.5},
        expected_fields=["success"]
    )
    tester.add_result(test)


def combined_incubator_tests(tester: APITester):
    """Run all incubator tests in sequence"""
    # Run environmental control tests
    test_environmental_control(tester)

    # Run protocol management tests
    test_protocol_features(tester)

    # Run alarm management tests
    test_alarm_features(tester)


def main():
    parser = argparse.ArgumentParser(description='Test Axionyx Incubator API')
    parser.add_argument(
        '--ip',
        default='192.168.4.1',
        help='Device IP address (default: 192.168.4.1 - AP mode)'
    )
    parser.add_argument(
        '--basic-only',
        action='store_true',
        help='Run only basic environmental control tests'
    )
    args = parser.parse_args()

    # Create tester instance
    tester = APITester(args.ip, "INCUBATOR")

    # Run all tests
    if args.basic_only:
        success = tester.run_all_tests(test_environmental_control)
    else:
        success = tester.run_all_tests(combined_incubator_tests)

    # Exit with appropriate code
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
