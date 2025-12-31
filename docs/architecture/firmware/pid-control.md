# PID Control

Proportional-Integral-Derivative temperature control algorithm.

---

## PID Formula

```
output = Kp × error + Ki × ∫error dt + Kd × d(error)/dt
```

**Where:**
- `error = setpoint - currentTemp`
- `Kp` = Proportional gain (2.0)
- `Ki` = Integral gain (0.5)
- `Kd` = Derivative gain (1.0)

---

## Control Loop

1. Read current temperature
2. Calculate error
3. Compute PID output
4. Apply heating/cooling
5. Update temperature
6. Repeat every 100ms

---

[← Back to Firmware Architecture](overview.md)
