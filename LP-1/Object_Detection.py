import time
import RPi.GPIO as GPIO

# Pin configuration
DETECT_PIN = 5   # IR sensor output pin
LED_PIN = 8      # LED indicator pin

# Setup function
def init_system():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(DETECT_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(LED_PIN, GPIO.OUT)
    GPIO.output(LED_PIN, GPIO.LOW)
    print("System Initialized...")

# Function to detect object
def detect_object():
    if GPIO.input(DETECT_PIN) == 0:
        return True   # Object detected
    else:
        return False  # No object

try:
    print("\nObject Detection using IR Sensor")
    print("---------------------------------\n")

    init_system()
    count = 0

    while True:
        if detect_object():
            count += 1
            print(f"Object detected! Count = {count}")
            
            GPIO.output(LED_PIN, GPIO.HIGH)  # Turn LED ON
            time.sleep(0.5)
            GPIO.output(LED_PIN, GPIO.LOW)   # Turn LED OFF
            time.sleep(1)                    # Debounce delay

except KeyboardInterrupt:
    print("\nProgram stopped by user.")

finally:
    GPIO.cleanup()
    print("GPIO cleanup done. Exiting safely.")




'''
Theory: Object Detection using IR Sensor and Raspberry Pi

An Infrared (IR) sensor detects objects based on the reflection of infrared light.
It has two parts:

    IR Transmitter (LED): Emits infrared light.

    IR Receiver (Photodiode): Detects reflected IR light from nearby objects.

When an object comes in front of the sensor, IR light is reflected and the receiver outputs a LOW signal, indicating object detection.

In this project:

    The IR sensor is connected to a GPIO input pin.

    An LED connected to another GPIO pin acts as a visual indicator.

    The program continuously checks the sensor’s output and lights up the LED whenever an object is detected.

⚙️ Algorithm

Start.

Import RPi.GPIO and time modules.

Define GPIO pins for IR sensor and LED.

Set GPIO mode to BCM and configure:

    - Sensor pin as INPUT with pull-up resistor.

    - LED pin as OUTPUT (initially LOW).

Initialize object count to 0.

Continuously monitor the IR sensor:

    - If sensor output is LOW, object is detected.

    - Increment count and display it.

    - Turn ON LED for 0.5 seconds, then turn it OFF.

    - Wait briefly to avoid duplicate counts.

On user interrupt (Ctrl+C), clean up GPIO pins and exit safely.

Stop.

'''