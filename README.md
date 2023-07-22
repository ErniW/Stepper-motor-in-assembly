# Stepper-motor-in-assembly
Controlling stepper motor using A4988 driver written from scratch in ARM assembly. It has a very basic code but enough to properly run it. Maybe I will add some additional features if I have free time.

### Hardware used:
- **STM32F446RE** with Cortex-M4F.
- **A4988** Stepper motor driver. It operates on 3 - 5.5V logic so no logic level converter is required. Remember to configure the driver properly.
- Stepper motor. I'm using **42BYGHM809** *(400 steps, 3V, Current per coil: 1,7 A, 1.8 Ohm)*. Of course you can use different one.
- External power supply for stepper motor. Depends on motor requirements.