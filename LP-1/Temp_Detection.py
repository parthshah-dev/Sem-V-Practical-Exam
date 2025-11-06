import time
from gpiozero import LED
from w1thermsensor import W1ThermSensor

# Initialize temperature sensor
sensor = W1ThermSensor()

# Define LEDs
led_pins = [20, 21, 22, 23, 24, 25, 26, 27]
leds = [LED(pin) for pin in led_pins]

# Turn off all LEDs initially
for led in leds:
    led.off()

try:
    while True:
        temp = sensor.get_temperature()  # Reads temperature in Celsius
        print(f"Current Temperature: {temp:.2f} °C")

        if temp >= 29:
            # Temperature high → turn all LEDs OFF
            for led in leds:
                led.off()
            print("Warning: Temperature limit exceeded!")
        else:
            # Normal temperature → turn all LEDs ON
            for led in leds:
                led.on()

        time.sleep(1)

except KeyboardInterrupt:
    print("\nProgram stopped by user.")
    for led in leds:
        led.off()




'''

Theory: Temperature Sensor Interfacing with Raspberry Pi

Temperature sensors like LM35 or DS18B20 generate output proportional to ambient temperature.
In this program, the W1ThermSensor library reads temperature values from the DS18B20 sensor through the Raspberry Pi’s 1-Wire interface.

Working Principle:

    The DS18B20 sensor outputs digital temperature data.

    The Raspberry Pi reads the data via GPIO and converts it to Celsius.

    LEDs are used as indicators:

        - If temperature < threshold (e.g., 29°C) → LEDs ON (Normal).

        - If temperature ≥ threshold → LEDs OFF (Overheat warning).

    This experiment demonstrates sensor interfacing, data acquisition, and GPIO control on the Raspberry Pi.

⚙️ Algorithm

Start.

Import time, gpiozero, and w1thermsensor libraries.

Initialize the temperature sensor (W1ThermSensor).

Define LED pins and set them as outputs.

Turn all LEDs OFF initially.

Repeat forever:

    - Read temperature from the sensor.

    - Display temperature on the console.

    - If temperature ≥ 29°C:

        + Turn all LEDs OFF.

        + Display warning message.

    - Else:

        + Turn all LEDs ON.

    - Wait 1 second before next reading.

On user interrupt (Ctrl+C), turn all LEDs OFF and exit safely.

Stop.


'''