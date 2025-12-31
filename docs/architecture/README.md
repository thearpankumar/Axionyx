# Architecture Documentation

System architecture and design documentation for the Axionyx platform.

---

## Overview

The Axionyx platform is a distributed system consisting of embedded devices, mobile/web applications, and backend services. This section provides comprehensive architectural documentation for all components.

---

## System Overview

**[Complete System Architecture](system-overview.md)**

High-level architecture covering:
- Component interactions
- Data flow diagrams
- Technology stack
- Communication protocols
- Deployment architecture

---

## Component Architecture

### Firmware Architecture

The ESP32 firmware provides device control and communication capabilities.

- **[Firmware Overview](firmware/overview.md)** - Overall architecture
- **[WiFi State Machine](firmware/wifi-state-machine.md)** - 5-state WiFi management
- **[Device Abstraction](firmware/device-abstraction.md)** - DeviceBase class hierarchy
- **[PID Control](firmware/pid-control.md)** - Temperature regulation algorithm
- **[Sensor Simulation](firmware/sensor-simulation.md)** - Mock sensor implementation

**Key Technologies:**
- C++ / Arduino Framework
- ESP32-WROOM-32 microcontroller
- ESP Async WebServer
- WebSockets library
- ArduinoJson
- SPIFFS filesystem

**Architecture Patterns:**
- State machines (WiFi, PCR cycling)
- Object-oriented design (inheritance, polymorphism)
- Event-driven architecture (WebSocket events)
- PID control loops

### Backend Architecture

The Python FastAPI backend provides cloud services and API management.

- **[Backend Overview](backend/overview.md)** - Service architecture
- **[Database](backend/database.md)** - Schema and data models
- **[Services](backend/services.md)** - Business logic layer

**Key Technologies:**
- Python 3.12+ with FastAPI
- PostgreSQL database
- SQLAlchemy ORM
- Pydantic models
- uvicorn ASGI server

**Architecture Patterns:**
- RESTful API design
- Repository pattern (data access)
- Service layer (business logic)
- Dependency injection

### Frontend Architecture

The Next.js frontend provides a modern web dashboard.

- **[Frontend Overview](frontend/overview.md)** - Application architecture
- **[State Management](frontend/state-management.md)** - State patterns

**Key Technologies:**
- Next.js 16.1 (React 19.2)
- TypeScript 5
- Tailwind CSS v4
- React Query (future)

**Architecture Patterns:**
- Component-based architecture
- Server components + client components
- App router architecture
- CSS-in-JS with Tailwind

### Mobile Architecture

The Flutter mobile app provides cross-platform device control.

- **[Mobile Overview](mobile/overview.md)** - App architecture
- **[State Management](mobile/state-management.md)** - State patterns

**Key Technologies:**
- Flutter (Dart 3.2.6+)
- Material Design 3
- Provider/Riverpod (future)
- WebSocket client

**Architecture Patterns:**
- Widget-based architecture
- BLoC or Provider pattern
- Repository pattern
- Clean architecture layers

---

## Communication Architecture

### Device ↔ App Communication

**[Device to App Communication](communication/device-to-app.md)**

Direct communication between ESP32 devices and mobile/web apps:
- REST API over HTTP
- WebSocket for real-time data
- mDNS for device discovery
- Local network communication

**Protocols:**
- HTTP/1.1 for REST API
- WebSocket (ws://) for telemetry
- mDNS/DNS-SD for discovery

### App ↔ Backend Communication

**[App to Backend Communication](communication/app-to-backend.md)**

Communication between mobile/web apps and backend services:
- RESTful API
- Authentication and authorization
- Data synchronization
- Cloud features

**Protocols:**
- HTTPS for REST API
- JWT tokens for auth
- WebSocket for notifications

### Security Architecture

**[Security Architecture](communication/security.md)**

Security across all components:
- Device pairing and authentication
- API authentication (JWT)
- Encrypted communications
- Secure WiFi provisioning

**Security Measures:**
- TLS/SSL for backend communication
- JWT tokens for API auth
- Device pairing codes
- WiFi credential encryption

---

## Design Decisions

### Why ESP32?

**Pros:**
- Dual-core processor (240 MHz)
- Built-in WiFi and Bluetooth
- Low cost (~$5 per unit)
- Large community and ecosystem
- Arduino compatibility

**Cons:**
- Limited RAM (520 KB)
- 2.4 GHz WiFi only (no 5 GHz)

### Why FastAPI for Backend?

**Pros:**
- Fast, modern Python framework
- Automatic API documentation
- Async support (high performance)
- Type hints and validation
- Easy to learn and use

**Alternatives Considered:**
- Django REST Framework (too heavy)
- Flask (less features)
- Node.js (different language)

### Why Next.js for Frontend?

**Pros:**
- Server-side rendering (SEO, performance)
- React ecosystem
- TypeScript support
- Modern developer experience
- API routes for BFF pattern

**Alternatives Considered:**
- Vite + React (no SSR)
- Remix (less mature)
- SvelteKit (smaller ecosystem)

### Why Flutter for Mobile?

**Pros:**
- Single codebase for iOS + Android
- Native performance
- Beautiful UI (Material Design)
- Hot reload for fast development
- Growing ecosystem

**Alternatives Considered:**
- React Native (less performant)
- Native (2x development cost)
- Ionic (webview performance)

---

## Scalability Considerations

### Device Scalability

**Current:**
- Single device, single client (adequate for labs)
- Local network only

**Future:**
- Multi-client support (multiple apps per device)
- Cloud connectivity
- Device-to-device communication

### Backend Scalability

**Current:**
- Single server deployment
- PostgreSQL database

**Future:**
- Horizontal scaling (multiple servers)
- Load balancing
- Database replication
- Caching layer (Redis)

### Data Scalability

**Current:**
- Local device storage (SPIFFS)
- In-memory telemetry

**Future:**
- Time-series database (InfluxDB)
- Long-term data retention
- Analytics and reporting

---

## Deployment Architecture

### Development Environment

```
Developer Machine
├── Firmware (PlatformIO/Arduino IDE)
├── Backend (Python local server)
├── Frontend (Next.js dev server)
└── Mobile (Flutter on emulator/device)
```

### Production Environment (Future)

```
Cloud (AWS/GCP/Azure)
├── Backend API (ECS/Cloud Run)
├── Frontend (Vercel/Static hosting)
├── Database (RDS/Cloud SQL)
└── Storage (S3/Cloud Storage)

Devices (ESP32)
├── Firmware (flashed OTA)
└── Local network or cloud-connected
```

---

## Data Flow

### Typical Data Flow (Device Control)

```
1. User Action (Mobile App)
   ↓
2. REST API Request (HTTP POST)
   ↓
3. Device Receives Request
   ↓
4. Device Executes Command
   ↓
5. Device Updates State
   ↓
6. WebSocket Broadcast (Telemetry)
   ↓
7. App Receives Update
   ↓
8. UI Updates
```

### Telemetry Flow

```
1. Device Sensor Read (every 1s)
   ↓
2. WebSocket Broadcast
   ↓
3. Multiple Clients Receive
   ↓
4. UI Real-time Update
```

---

## Technology Stack Summary

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Firmware** | C++/Arduino | Device control |
| | ESP32 | Microcontroller |
| | FreeRTOS | Real-time OS |
| **Backend** | Python 3.12 | Business logic |
| | FastAPI | REST API framework |
| | PostgreSQL | Data storage |
| **Frontend** | Next.js 16 | Web UI |
| | React 19 | UI framework |
| | TypeScript | Type safety |
| **Mobile** | Flutter | Cross-platform UI |
| | Dart | Programming language |
| **DevOps** | Git | Version control |
| | GitHub Actions | CI/CD |
| | Docker | Containerization |

---

## Architecture Diagrams

### High-Level System Diagram

```
┌─────────────┐      ┌─────────────┐
│   Mobile    │◄────►│   Backend   │
│     App     │      │   (FastAPI) │
└──────┬──────┘      └─────────────┘
       │
       │ WiFi/HTTP/WebSocket
       │
       ▼
┌─────────────┐
│   ESP32     │
│   Device    │
│  (Firmware) │
└─────────────┘
```

Detailed diagrams available in component-specific documentation.

---

## Further Reading

- **[System Overview](system-overview.md)** - Complete architecture
- **[Firmware Architecture](firmware/overview.md)** - Device firmware design
- **[Communication Patterns](communication/device-to-app.md)** - How components communicate
- **[Security](communication/security.md)** - Security architecture

---

[← Back to Documentation Home](../README.md)
