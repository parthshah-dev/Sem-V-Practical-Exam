import time
import RPi.GPIO as GPIO

# Define LED pins
led_pins = [20, 21, 22, 23, 24, 25, 26, 27]

# Setup
GPIO.setmode(GPIO.BCM)
for pin in led_pins:
    GPIO.setup(pin, GPIO.OUT)
    GPIO.output(pin, GPIO.LOW)

def ledState(led_index, state):
    GPIO.output(led_pins[led_index], state)

try:
    print("All LEDs ON for 1 second at start...")
    for i in range(8):
        ledState(i, 1)
    time.sleep(1)

    print("Starting LED blink sequence. Press Ctrl+C to stop.")
    while True:
        for i in range(8):
            ledState(i, 1)
            time.sleep(0.5)
            ledState(i, 0)
            time.sleep(0.5)

except KeyboardInterrupt:
    print("\nProgram stopped by user.")

finally:
    GPIO.cleanup()
    print("GPIO cleanup done. Exiting safely.")


'''

🧠 Theory: LED Interfacing with Raspberry Pi

An LED (Light Emitting Diode) is an electronic component that emits light when current passes through it.
In Raspberry Pi, LEDs can be controlled through GPIO (General Purpose Input/Output) pins.
By programming these pins using Python and the RPi.GPIO library, we can turn LEDs ON or OFF to create blinking or pattern-based effects.

Concepts used:

    GPIO setup: Defines the board mode and configures pins as outputs.

    Digital output control: Sends HIGH (1) or LOW (0) signals to LEDs.

    Loop and delay: Used for blinking and sequencing LEDs.

⚙️ Algorithm

Start.

Import RPi.GPIO and time modules.

Define the LED pins to be used (e.g., 20–27).

Set GPIO mode to BCM and configure pins as OUTPUT.

Turn ON all LEDs for 1 second.

Enter an infinite loop:

    For each LED:

        - Turn it ON.

        - Wait 0.5 seconds.

        - Turn it OFF.

        - Wait 0.5 seconds.

On user interrupt (Ctrl+C), clean up GPIO pins and exit safely.

Stop.



'''