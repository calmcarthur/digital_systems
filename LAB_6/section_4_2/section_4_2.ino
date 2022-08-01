const int switchPin = 2; // the input pin
long startcount; // Store the first time value returned from millis
long duration; // Store the duratation of a period or part there of of the incoming signal
float frequency; // Store the calculated frequency in Hz
bool sameEdge = false;

int pinState = HIGH;

void setup()
{
  pinMode(switchPin, INPUT);
  Serial.begin(9600); //sets up communication wit the serial monitor
}

void loop() {
  pinState = digitalRead(switchPin); // Read the state of the pin and use it to determine where you are in the clock cycle

  if (pinState == LOW) {
    if (sameEdge == true){
      duration = millis() - startcount;
      frequency = 1000 / (float)duration;
      Serial.print(" Frequency is = ");
      Serial.println(frequency);
      sameEdge = false;
    }
    if (sameEdge == false){
      startcount = millis();
      while (pinState == LOW) {
        pinState = digitalRead(switchPin); // Read the state of the pin and use it to determine where you are in the clock cycle
      }
      sameEdge = true;
    }
    
  }
}
