# Mobile App Development Setup

**Flutter Mobile App Setup Guide**

This guide covers setting up the Axionyx mobile application for iOS and Android development.

---

## Overview

The Axionyx mobile app is built with:
- **Flutter 3.2.6+** - Cross-platform UI framework
- **Dart 3.2+** - Programming language
- **Material Design 3** - UI design system
- **Provider/Riverpod** - State management (future)

**Current Status:** In early development

---

## Prerequisites

### Required Software

- **Flutter SDK 3.2.6+** - Mobile development framework
- **Git** - Version control
- **Code Editor** - VS Code or Android Studio recommended

### Platform-Specific Requirements

**For Android Development:**
- Android Studio
- Android SDK (API 26+)
- Java Development Kit (JDK) 11+

**For iOS Development (macOS only):**
- Xcode 14+
- CocoaPods
- iOS SDK

---

## Installation

### Step 1: Install Flutter SDK

**Linux:**
```bash
# Download Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
flutter doctor
```

**macOS:**
```bash
# Using Homebrew (recommended)
brew install --cask flutter

# Or download manually
cd ~/development
unzip ~/Downloads/flutter_macos_*.zip

# Add to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify installation
flutter doctor
```

**Windows:**
1. Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
2. Extract to `C:\flutter`
3. Add `C:\flutter\bin` to PATH:
   - Search "Environment Variables" in Start menu
   - Edit Path variable
   - Add `C:\flutter\bin`
4. Restart terminal
5. Run `flutter doctor`

### Step 2: Run Flutter Doctor

```bash
# Check installation and dependencies
flutter doctor

# Example output:
# [✓] Flutter (Channel stable, 3.16.0)
# [✓] Android toolchain - develop for Android devices
# [✓] Xcode - develop for iOS and macOS
# [✓] Chrome - develop for the web
# [✓] Android Studio (version 2023.1)
# [✓] VS Code (version 1.85)
```

### Step 3: Install Platform Tools

**Android Studio (All Platforms):**
1. Download from https://developer.android.com/studio
2. Run installer
3. Open Android Studio
4. Tools → SDK Manager
5. Install:
   - Android SDK Platform (API 34+)
   - Android SDK Build-Tools
   - Android Emulator
   - Intel x86 Emulator Accelerator (HAXM) or equivalent

**Accept Android Licenses:**
```bash
flutter doctor --android-licenses
# Press 'y' to accept all licenses
```

**Xcode (macOS only):**
```bash
# Install Xcode from App Store

# Install Command Line Tools
sudo xcode-select --install

# Accept license
sudo xcodebuild -license accept

# Install CocoaPods
sudo gem install cocoapods
pod setup
```

### Step 4: Install IDE Extensions

**VS Code:**
1. Install Flutter extension
2. Install Dart extension

**Android Studio:**
1. Plugins → Flutter
2. Plugins → Dart

---

## Project Setup

### Step 1: Clone Repository (if not done)

```bash
git clone https://github.com/axionyx/axionyx.git
cd axionyx/mobile
```

### Step 2: Get Dependencies

```bash
# Fetch all Flutter packages
flutter pub get

# Expected output:
# Resolving dependencies...
# Got dependencies!
```

### Step 3: Verify Project

```bash
# Check for issues
flutter analyze

# Run tests
flutter test
```

---

## Project Structure

```
mobile/
├── lib/
│   ├── main.dart              # App entry point
│   ├── app.dart               # App widget
│   ├── config/                # Configuration
│   │   └── app_config.dart
│   ├── models/                # Data models
│   ├── services/              # API services
│   │   ├── api_service.dart
│   │   └── websocket_service.dart
│   ├── providers/             # State management (future)
│   ├── screens/               # App screens
│   │   ├── home_screen.dart
│   │   └── device_screen.dart
│   └── widgets/               # Reusable widgets
│       └── device_card.dart
├── test/                      # Unit tests
├── android/                   # Android-specific code
├── ios/                       # iOS-specific code
├── web/                       # Web support (optional)
├── pubspec.yaml              # Dependencies
└── README.md
```

---

## Running the App

### Start Emulator/Simulator

**Android Emulator:**
```bash
# List available emulators
flutter emulators

# Start emulator
flutter emulators --launch <emulator_id>

# Or via Android Studio:
# Tools → Device Manager → Play button
```

**iOS Simulator (macOS only):**
```bash
# Start simulator
open -a Simulator

# Or from Xcode:
# Xcode → Open Developer Tool → Simulator
```

### Run on Emulator

```bash
# List connected devices
flutter devices

# Run on first available device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run in debug mode (default)
flutter run --debug

# Run in profile mode
flutter run --profile

# Run in release mode
flutter run --release
```

### Run on Physical Device

**Android:**
1. Enable Developer Options on device
2. Enable USB Debugging
3. Connect via USB
4. Run `flutter devices` to verify
5. Run `flutter run`

**iOS (macOS only):**
1. Connect iPhone/iPad via USB
2. Trust computer on device
3. Open `ios/Runner.xcworkspace` in Xcode
4. Set Development Team in Signing & Capabilities
5. Run `flutter run`

### Hot Reload

While app is running:
- **Hot Reload:** Press `r` (reloads code, preserves state)
- **Hot Restart:** Press `R` (full restart, clears state)
- **Quit:** Press `q`

---

## Development

### Creating Widgets

**Stateless Widget:**
```dart
// lib/widgets/device_card.dart
import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String status;
  final VoidCallback? onTap;

  const DeviceCard({
    Key? key,
    required this.deviceName,
    required this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(deviceName),
        subtitle: Text('Status: $status'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
```

**Stateful Widget:**
```dart
// lib/screens/device_screen.dart
import 'package:flutter/material.dart';

class DeviceScreen extends StatefulWidget {
  final String deviceId;

  const DeviceScreen({Key? key, required this.deviceId}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  double _temperature = 25.0;
  bool _isRunning = false;

  void _startDevice() {
    setState(() {
      _isRunning = true;
    });
    // Call API to start device
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device ${widget.deviceId}'),
      ),
      body: Column(
        children: [
          Text('Temperature: ${_temperature}°C'),
          ElevatedButton(
            onPressed: _isRunning ? null : _startDevice,
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }
}
```

### Navigation

```dart
// Navigate to new screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DeviceScreen(deviceId: 'DUMMY-123'),
  ),
);

// Navigate and replace
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => HomeScreen()),
);

// Go back
Navigator.pop(context);
```

### API Integration

**Create API Service:**
```dart
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> getDeviceInfo() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/device/info'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load device info');
    }
  }

  Future<void> startDevice(double setpoint) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/device/start'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'setpoint': setpoint}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to start device');
    }
  }
}
```

**Use in Widget:**
```dart
class DeviceScreen extends StatefulWidget {
  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final apiService = ApiService(baseUrl: 'http://192.168.4.1');
  Map<String, dynamic>? deviceInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    try {
      final info = await apiService.getDeviceInfo();
      setState(() {
        deviceInfo = info;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text(deviceInfo?['name'] ?? 'Device')),
      body: /* ... */,
    );
  }
}
```

---

## Building for Production

### Android APK

```bash
# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Build split APKs per ABI (smaller sizes)
flutter build apk --split-per-abi

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (for Play Store)

```bash
# Build app bundle
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS IPA (macOS only)

```bash
# Build for iOS
flutter build ipa --release

# Output: build/ios/iphoneos/Runner.app
```

---

## Testing

### Unit Tests

```dart
// test/services/api_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:axionyx/services/api_service.dart';

void main() {
  group('ApiService', () {
    test('getDeviceInfo returns device data', () async {
      final apiService = ApiService(baseUrl: 'http://test.local');
      // Add mock HTTP client
      final info = await apiService.getDeviceInfo();
      expect(info, isNotNull);
      expect(info['id'], isNotEmpty);
    });
  });
}
```

### Widget Tests

```dart
// test/widgets/device_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:axionyx/widgets/device_card.dart';

void main() {
  testWidgets('DeviceCard displays device name', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DeviceCard(
            deviceName: 'Test Device',
            status: 'Online',
          ),
        ),
      ),
    );

    expect(find.text('Test Device'), findsOneWidget);
    expect(find.text('Status: Online'), findsOneWidget);
  });
}
```

### Integration Tests

```dart
// integration_test/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:axionyx/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full app test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify home screen appears
    expect(find.text('Axionyx'), findsOneWidget);

    // Tap on device
    await tester.tap(find.text('Device 1'));
    await tester.pumpAndSettle();

    // Verify device screen appears
    expect(find.text('Temperature'), findsOneWidget);
  });
}
```

**Run Tests:**
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

---

## Troubleshooting

### Common Issues

**Flutter Doctor Issues:**
```bash
# Re-run doctor with verbose output
flutter doctor -v

# Common fixes:
flutter doctor --android-licenses  # Accept licenses
sudo xcode-select -s /Applications/Xcode.app  # Set Xcode path
```

**Build Failures:**
```bash
# Clean project
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

**Gradle Errors (Android):**
```bash
# Update Gradle wrapper
cd android
./gradlew wrapper --gradle-version=8.0

# Clean Gradle cache
./gradlew clean
```

**CocoaPods Errors (iOS):**
```bash
# Update CocoaPods
cd ios
pod repo update
pod install

# Clean derived data
rm -rf ~/Library/Developer/Xcode/DerivedData
```

---

## Best Practices

### Code Organization

- **Widgets:** Keep widgets small and focused
- **State Management:** Use Provider or Riverpod for complex state
- **Services:** Separate API logic from UI
- **Models:** Define data models for type safety

### Performance

```dart
// Use const constructors
const Text('Hello');

// Avoid rebuilds with const
class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
}

// Use ListView.builder for long lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
);
```

### State Management (Future)

```dart
// Using Provider
class DeviceProvider extends ChangeNotifier {
  List<Device> _devices = [];

  List<Device> get devices => _devices;

  Future<void> fetchDevices() async {
    _devices = await apiService.getDevices();
    notifyListeners();
  }
}

// In widget
final deviceProvider = Provider.of<DeviceProvider>(context);
```

---

## Next Steps

### Development

1. **Build Screens:** Implement device management UI
2. **Add Navigation:** Set up routing between screens
3. **Integrate API:** Connect to device/backend APIs
4. **Add State Management:** Implement Provider/Riverpod
5. **Test on Devices:** Test on physical iOS/Android devices

### Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)
- [Mobile Development Guide](../development/mobile/overview.md)

---

[← Back to Getting Started](README.md) | [Documentation Home](../README.md)
