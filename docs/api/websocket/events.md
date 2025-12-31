# Events

Asynchronous event notifications.

---

## Event Types

- `cycle_complete` - PCR cycle completed
- `error` - Device error occurred
- `warning` - Device warning
- `stable` - Incubator environment stabilized

---

## Event Format

```json
{
  "type": "event",
  "event": "cycle_complete",
  "message": "Cycle 10/35 completed",
  "timestamp": 1704067200,
  "data": {
    "cycleNumber": 10,
    "totalCycles": 35
  }
}
```

---

[← Back to WebSocket Overview](overview.md)
