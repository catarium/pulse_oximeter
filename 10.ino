// Pin definitions
const int LED_PIN = 2;
const int PHOTODIODE_PIN = A0;

// Variables for the LED timer
unsigned long previousMillis = 0;
const long ledInterval = 500; // Blink every 500 milliseconds (0.5 seconds)
int ledState = LOW;           // Track whether the LED is currently ON or OFF

void setup() {
  pinMode(LED_PIN, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // 1. READ THE PHOTODIODE (Happens continuously, thousands of times a second)
  int photodiodeValue = analogRead(PHOTODIODE_PIN);
  
  // Optional: Print the value to your computer
  Serial.print("Photodiode Value: ");
  Serial.println(photodiodeValue);

  // 2. CHECK THE TIMER FOR THE LED (Asynchronous check)
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= ledInterval) {
    // Save the last time you blinked the LED
    previousMillis = currentMillis;

    // If the LED is off, turn it on and vice-versa:
    if (ledState == LOW) {
      ledState = HIGH;
    } else {
      ledState = LOW;
    }

    // Apply the new state to the physical pin
    digitalWrite(LED_PIN, ledState);
  }
  
  // You can add other immediate tasks here, and they won't interfere
}

