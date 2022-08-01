const int switchPin = 2; // the number of the input pin
long startTime; // store starting time here
long duration; // variable to store how long the timer has been running
float secduration; // variable to store the duration in seconds
int buttonState = HIGH;
int lastButtonState = HIGH;

void setup() {
  pinMode(switchPin, INPUT);
  Serial.begin(9600); //this will allow the Uno to comunicate with the serial monitor
}

void loop() {
  buttonState = digitalRead(switchPin);
  
  if (buttonState != lastButtonState) {
    if (buttonState == LOW) {
      Serial.println("Button pushed");
      startTime = millis();
    }
    if (buttonState == HIGH) {
      duration = millis() - startTime;
      secduration=(float)duration / 1000;
      
      Serial.print("Button released after ");
      Serial.print(secduration);
      Serial.println(" seconds");
    }
  }
  lastButtonState = buttonState;
}
