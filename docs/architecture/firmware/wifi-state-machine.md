# WiFi State Machine

5-state WiFi management system.

---

## States

1. **WIFI_INIT** - Initialize and load config
2. **WIFI_AP_MODE** - Access Point mode (hotspot)
3. **WIFI_CONNECTING** - Connecting to WiFi
4. **WIFI_CONNECTED** - Connected successfully
5. **WIFI_RECONNECT** - Reconnection with exponential backoff

---

## State Transitions

```
WIFI_INIT
    │
    ├─ No credentials ──► WIFI_AP_MODE
    │
    └─ Has credentials ──► WIFI_CONNECTING
            │
            ├─ Success ──► WIFI_CONNECTED
            │
            └─ Failure ──► WIFI_RECONNECT
                    │
                    ├─ Retry (5 attempts)
                    │
                    └─ Give up ──► WIFI_AP_MODE
```

---

## WiFi Modes

- **AP_ONLY (0)** - Hotspot only, local control
- **STA_ONLY (1)** - WiFi client only
- **AP_STA_DUAL (2)** - Both active simultaneously

---

[← Back to Firmware Architecture](overview.md)
