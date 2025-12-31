# Development Guides

Component-specific development documentation for contributing to Axionyx.

---

## Overview

This section provides comprehensive development guides for all Axionyx components, covering setup, architecture, best practices, testing, and debugging.

---

## Quick Navigation

### Firmware Development
- **[Firmware Overview](firmware/overview.md)** - Getting started with firmware
- **[Adding New Devices](firmware/adding-devices.md)** - Create new device types
- **[Common Components](firmware/common-components.md)** - Using shared libraries
- **[Testing](firmware/testing.md)** - Firmware testing strategies
- **[Debugging](firmware/debugging.md)** - Debug tools and techniques

### Backend Development
- **[Backend Overview](backend/overview.md)** - Python/FastAPI development
- **[API Development](backend/api-development.md)** - Adding new endpoints
- **[Database Migrations](backend/database-migrations.md)** - Schema management
- **[Testing](backend/testing.md)** - Backend testing

### Frontend Development
- **[Frontend Overview](frontend/overview.md)** - Next.js development
- **[Components](frontend/components.md)** - Creating UI components
- **[Routing](frontend/routing.md)** - Navigation and routing
- **[Testing](frontend/testing.md)** - Frontend testing

### Mobile Development
- **[Mobile Overview](mobile/overview.md)** - Flutter development
- **[Screens](mobile/screens.md)** - Creating app screens
- **[Device Integration](mobile/device-integration.md)** - Connect to devices
- **[Testing](mobile/testing.md)** - Mobile testing

### CI/CD
- **[GitHub Actions](ci-cd/github-actions.md)** - CI/CD workflows
- **[Pre-commit Hooks](ci-cd/pre-commit-hooks.md)** - Code quality gates
- **[Deployment](ci-cd/deployment.md)** - Deployment strategies

---

## Development Environment Setup

### Prerequisites

**General:**
- Git 2.30+
- Code editor (VS Code recommended)
- Terminal/shell access

**Component-Specific:**
- **Firmware:** PlatformIO or Arduino IDE
- **Backend:** Python 3.12+, uv package manager
- **Frontend:** Node.js 18+, npm/yarn
- **Mobile:** Flutter SDK 3.2.6+

See [Getting Started](../getting-started/README.md) for detailed setup.

---

## Development Workflow

### Standard Workflow

1. **Clone Repository**
   ```bash
   git clone https://github.com/axionyx/axionyx.git
   cd axionyx
   ```

2. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**
   - Write code
   - Write tests
   - Update documentation

4. **Run Tests**
   ```bash
   # Component-specific test commands
   ```

5. **Commit Changes**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

6. **Push and Create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

### Commit Message Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

**Examples:**
```
feat(firmware): add support for new sensor type
fix(api): correct temperature calculation in PCR
docs(readme): update installation instructions
```

---

## Code Style Guidelines

### Firmware (C++)

**Style:**
- Google C++ Style Guide
- 4-space indentation
- CamelCase for classes
- camelCase for methods
- UPPER_CASE for constants

**Example:**
```cpp
class TemperatureController {
public:
    void setSetpoint(float temperature);
    float getCurrentTemperature() const;

private:
    static const int MAX_TEMPERATURE = 120;
    float currentTemp;
};
```

### Backend (Python)

**Style:**
- PEP 8
- Black formatter
- Ruff linter
- 4-space indentation
- snake_case for functions/variables
- PascalCase for classes

**Example:**
```python
class DeviceService:
    def get_device_status(self, device_id: str) -> DeviceStatus:
        """Get current device status."""
        device = self.repository.find_by_id(device_id)
        return device.get_status()
```

### Frontend (TypeScript)

**Style:**
- ESLint + Prettier
- 2-space indentation
- camelCase for variables/functions
- PascalCase for components/types
- Functional components with hooks

**Example:**
```typescript
interface DeviceProps {
  deviceId: string;
  onUpdate: (data: DeviceData) => void;
}

export function DeviceMonitor({ deviceId, onUpdate }: DeviceProps) {
  const [status, setStatus] = useState<DeviceStatus | null>(null);
  // ...
}
```

### Mobile (Dart)

**Style:**
- Effective Dart
- 2-space indentation
- camelCase for variables/methods
- PascalCase for classes
- Trailing commas for better formatting

**Example:**
```dart
class DeviceController extends ChangeNotifier {
  DeviceStatus? _status;

  Future<void> updateStatus(String deviceId) async {
    final status = await deviceRepository.getStatus(deviceId);
    _status = status;
    notifyListeners();
  }
}
```

---

## Testing Strategy

### Unit Tests

Test individual functions and classes in isolation.

**Coverage Goal:** 80%+

**Tools:**
- **Firmware:** Unity test framework
- **Backend:** pytest
- **Frontend:** Jest + React Testing Library
- **Mobile:** Flutter test framework

### Integration Tests

Test component interactions.

**Coverage:**
- API endpoint testing
- Database operations
- WebSocket communication

### End-to-End Tests

Test complete user workflows.

**Tools:**
- **Frontend:** Playwright
- **Mobile:** Flutter integration tests
- **API:** Postman collections

---

## Debugging Tools

### Firmware

**Serial Monitor:**
```bash
pio device monitor
```

**Logging Levels:**
```cpp
Logger::debug("Debug message");
Logger::info("Info message");
Logger::warning("Warning message");
Logger::error("Error message");
```

**Hardware Debugger:**
- JTAG debugging with ESP-PROG
- GDB integration

### Backend

**Debugger:**
```bash
python -m debugpy --listen 5678 main.py
```

**Logging:**
```python
import logging
logging.debug("Debug message")
```

**Database Inspection:**
```bash
psql -d axionyx
```

### Frontend

**Browser DevTools:**
- React DevTools extension
- Network tab for API calls
- Console for errors

**Next.js Debugging:**
```bash
NODE_OPTIONS='--inspect' npm run dev
```

### Mobile

**Flutter DevTools:**
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

**Debug Mode:**
```bash
flutter run --debug
```

---

## Common Development Tasks

### Adding a New Device Type

1. Create device class extending `DeviceBase`
2. Implement required methods
3. Create device-specific logic (e.g., control algorithms)
4. Add API endpoint handlers
5. Update documentation
6. Write tests

See [Adding New Devices](firmware/adding-devices.md) for details.

### Adding a REST API Endpoint

1. Define route in `HTTPServer.cpp`
2. Implement handler function
3. Add request/response validation
4. Update API documentation
5. Write integration tests

See [API Development](backend/api-development.md) for details.

### Creating a New Frontend Component

1. Create component file
2. Define props interface
3. Implement component logic
4. Add styling (Tailwind CSS)
5. Export component
6. Write tests

See [Components](frontend/components.md) for details.

### Adding a Mobile Screen

1. Create screen widget
2. Define navigation route
3. Implement screen logic
4. Add state management
5. Connect to API
6. Write tests

See [Screens](mobile/screens.md) for details.

---

## Performance Optimization

### Firmware

- Minimize memory allocations
- Use const references
- Optimize loop iterations
- Disable debug logging in production

### Backend

- Use async/await for I/O operations
- Implement connection pooling
- Cache frequently accessed data
- Profile with cProfile

### Frontend

- Code splitting for route-based loading
- Lazy load components
- Optimize images (WebP, responsive)
- Memoize expensive calculations

### Mobile

- Use const constructors
- Implement ListView.builder for long lists
- Optimize build methods
- Profile with DevTools

---

## Security Best Practices

### General

- Never commit secrets to git
- Use environment variables for config
- Validate all user inputs
- Follow principle of least privilege

### Firmware

- Encrypt WiFi credentials in SPIFFS
- Implement secure pairing
- Validate API requests
- Use HTTPS for OTA updates (production)

### Backend

- Use parameterized queries (prevent SQL injection)
- Implement rate limiting
- Validate JWT tokens
- Hash passwords with bcrypt

### Frontend/Mobile

- Sanitize user inputs
- Use HTTPS for API calls
- Store tokens securely (Keychain/Keystore)
- Implement CSRF protection

---

## Documentation Guidelines

### What to Document

- Public APIs and interfaces
- Complex algorithms
- Configuration options
- Breaking changes
- Migration guides

### How to Document

**Code Comments:**
```cpp
/**
 * Sets the temperature setpoint for a specific zone.
 *
 * @param zone Zone number (0-2)
 * @param temperature Target temperature in Celsius (0-120)
 * @return true if successful, false if out of range
 */
bool setSetpoint(uint8_t zone, float temperature);
```

**Markdown Docs:**
- Clear titles and structure
- Code examples
- Links to related docs
- Updated with code changes

See [Documentation Guide](../contributing/documentation.md).

---

## Getting Help

### Resources

- [Architecture Documentation](../architecture/README.md)
- [API Reference](../reference/README.md)
- [Contributing Guidelines](../contributing/README.md)

### Community

- GitHub Discussions
- Issue tracker
- Pull request reviews

---

## Component-Specific Guides

### [Firmware Development](firmware/overview.md)
Comprehensive guide to ESP32 firmware development, including:
- Device abstraction patterns
- Using common components (WiFi, Config, HTTP, WebSocket)
- Sensor simulation
- PID control implementation
- Testing and debugging

### [Backend Development](backend/overview.md)
Python/FastAPI backend development guide:
- Project structure
- Database models and migrations
- Service layer patterns
- API endpoint implementation
- Testing and CI/CD

### [Frontend Development](frontend/overview.md)
Next.js web dashboard development:
- App router patterns
- Server vs client components
- State management
- API integration
- Testing strategies

### [Mobile Development](mobile/overview.md)
Flutter mobile app development:
- Project architecture
- State management (Provider/BLoC)
- WebSocket integration
- Device discovery and pairing
- Platform-specific features

---

[← Back to Documentation Home](../README.md)
