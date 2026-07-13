# 8086-Based DC Motor Speed Control Using PWM

Assignment for the Microprocessor, Assembly Language & Interfacing course (ECE 3112, RUET). Implements closed-loop DC motor speed control on an 8086 microprocessor system, using an 8255 PPI and 8253 PIT to read an ADC and drive a PWM signal.

## Overview

- **8255 PPI (Programmable Peripheral Interface)**: Port A drives ADC control signals, Port B reads the converted digital value, Port C handles handshaking (EOC / start-conversion) and a push-button input.
- **8253 PIT (Programmable Interval Timer)**: Counter 0 generates the base PWM rate; Counter 1 (monostable) sets the pulse width, which is updated live from the ADC reading.
- **Control flow**: The main loop reads the ADC value (set via a potentiometer), converts it into a PWM duty cycle, and lets a push button re-trigger the conversion cycle to update motor speed.

## Structure

```
.
├── Code_2010025.asm                    # 8086 assembly source
├── Schema_2010025.png                  # Circuit schematic
├── MALI_Assignment_Final_2010025.pdsprj  # Proteus simulation project
├── Assignment_2010025.pdf              # Full report
└── Demo_Video_2010025.mkv              # Local only — see note below
```

## Demo Video

The demo video (~30 MB) is kept out of git history to keep the repo lightweight. It's available locally / upload it to YouTube or Drive and link it here:

**Demo video:** _add link here_

## Tools Used

- MASM (8086 Assembly)
- Proteus Design Suite (schematic capture + simulation)

## Author

Md. Tajim An Noor — Dept. of Electrical & Computer Engineering, RUET
