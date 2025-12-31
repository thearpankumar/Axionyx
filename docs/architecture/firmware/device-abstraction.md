# Device Abstraction

DeviceBase class hierarchy and polymorphic device handling.

---

## DeviceBase Class

Abstract base class defining the device interface:

```cpp
class DeviceBase {
public:
    virtual bool begin() = 0;
    virtual void loop() = 0;
    virtual JsonDocument getStatus() const = 0;
    virtual bool start(const JsonDocument& params) = 0;
    virtual bool stop() = 0;
    virtual bool pause() = 0;
    virtual bool resume() = 0;
    virtual bool setSetpoint(uint8_t zone, float temperature) = 0;
    virtual String getDeviceType() const = 0;
};
```

---

## Device Implementations

- **DummyDevice** - Single zone, simple control
- **PCRDevice** - 3 zones, thermal cycling
- **IncubatorDevice** - Multi-parameter environmental control

---

[← Back to Firmware Architecture](overview.md)
