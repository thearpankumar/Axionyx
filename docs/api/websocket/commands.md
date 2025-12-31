# Commands

Bidirectional command execution via WebSocket.

---

## Command Format

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

---

## Available Commands

- `start` - Start device
- `stop` - Stop device
- `pause` - Pause device
- `resume` - Resume device
- `setpoint` - Update setpoint
- `get_status` - Get current status

---

## Response Format

```json
{
  "type": "response",
  "requestId": "uuid-1234",
  "success": true,
  "message": "Command executed successfully",
  "data": {}
}
```

---

[← Back to WebSocket Overview](overview.md)
