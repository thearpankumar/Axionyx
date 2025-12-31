# WebSocket Protocol

Real-time bidirectional communication protocol for device telemetry and commands.

---

## Connection

**Endpoint:** `ws://[device-ip]:81`

**Example:**
```javascript
const ws = new WebSocket('ws://192.168.4.1:81');

ws.onopen = () => {
  console.log('Connected to device');
};

ws.onmessage = (event) => {
  const data = JSON.parse(event.data);
  console.log('Received:', data);
};

ws.onerror = (error) => {
  console.error('WebSocket error:', error);
};

ws.onclose = () => {
  console.log('Disconnected from device');
};
```

---

## Message Types

### Server → Client

- **telemetry** - Real-time device data (1 Hz)
- **event** - Event notifications
- **response** - Command responses

### Client → Server

- **command** - Control commands
- **ping** - Keepalive ping

---

## Telemetry Messages

**Frequency:** 1 message per second

**Format:**
```json
{
  "type": "telemetry",
  "timestamp": 1704067200,
  "data": {
    "state": "RUNNING",
    "temperature": 94.8,
    "setpoint": 95.0
  }
}
```

See [Telemetry Documentation](telemetry.md) for details.

---

## Event Messages

**Format:**
```json
{
  "type": "event",
  "event": "cycle_complete",
  "message": "Cycle 10/35 completed",
  "timestamp": 1704067200
}
```

See [Events Documentation](events.md) for details.

---

## Command Messages

**Format:**
```json
{
  "type": "command",
  "command": "start",
  "params": {
    "setpoint": 95.0
  },
  "requestId": "uuid-1234"
}
```

See [Commands Documentation](commands.md) for details.

---

[← Back to API Documentation](../README.md)
