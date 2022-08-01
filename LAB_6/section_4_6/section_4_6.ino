// The following program was taken from the Arduino website: 
// https://www.arduino.cc/en/Tutorial/ToneMelody?from=Tutorial.Tone 
#define NOTE_C4  262
#define NOTE_G3  196
#define NOTE_A3  220
#define NOTE_B3  247

// notes in the melody:
int melody[] = {
  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
};

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 8, 8, 4, 4, 4, 4, 4
};

void setup() {
// Attach interrupt here BME students!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
pinMode(9, OUTPUT);
pinMode(2, INPUT_PULLUP);
digitalWrite(9,LOW);
attachInterrupt(digitalPinToInterrupt(2), ISR_blink, CHANGE);
}

void ISR_blink() {
  digitalWrite(9, HIGH);
  delay(100);
}

void loop() {
  // iterate over the notes of the melody:
  for (int thisNote = 0; thisNote < 8; thisNote++) {

    // to calculate the note duration, take one second divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    int noteDuration = 1000 / noteDurations[thisNote];
    tone(8, melody[thisNote], noteDuration);

    // to distinguish the notes, set a minimum time between them.
    // the note's duration + 30% seems to work well:
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    noTone(8);
    digitalWrite(9, LOW);
  }
}
