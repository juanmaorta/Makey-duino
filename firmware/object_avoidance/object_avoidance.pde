
/*
  const int motor1Pin = 3;    // H-bridge leg 1 (pin 2, 1A)
 const int motor2Pin = 4;    // H-bridge leg 2 (pin 7, 2A)
 
 const int enablePin = 9;    // H-bridge enable pin
 const int enablePin2 = 8;
 const int ledPin = 13;      // LED 
 */

#include "pitches.h"
#include "TimedAction.h"


// notes in the melody:
int melody[] = {NOTE_C4, NOTE_G3,NOTE_G3, NOTE_A3, NOTE_G3,0, NOTE_B3, NOTE_C4};

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {4, 8, 8, 4,4,4,4,4 };

// driving motor pins
#define  leftEnable   3
#define leftDir1      2 // sustituir por 2 (antes 6)
#define  leftDir2     7

#define  rightEnable   11
#define  rightDir1     12 // sustituir por 12 (antes 5)
#define  rightDir2     4

// misc pins
#define pingPin       9
#define servoPin      10
#define  ledPin       13
#define buzPin       8

#define  debug        true
#define  sound_on     false

// distance options
#define BOUNDARY   20      // (cm) Avoid objects closer than 20cm.
#define INTERVAL   25        // (ms) Interval between distance readings.

// servo options
#define SERVOMAX     2400    // Max travel at 2.4ms = 2400 microseconds
#define SERVOMIN     600     // Min travel at 0.6ms =  600 microseconds
#define SERVOCENTER  1500    // Center at 1.5ms = 1500 microseconds
#define STEP         35      // Decrease for slower motion
int servoSpeed = 15;



int enablePins[] = {rightEnable, leftEnable};
int rightDirPins[] = {leftDir1, leftDir2};
int leftDirPins[] = {rightDir1, rightDir2};

// "Global" variables
boolean ledState = false;
boolean buzzState = false;
long distance = 200;

boolean followMode = false;

const int baseSpeed = 50;
int motorSpeed = baseSpeed;
boolean resetSpeed = true;

long previousMillis = 0;

// TimedActions
TimedAction blinkAction  = TimedAction(300,blink);
TimedAction buzzAction   = TimedAction(800, buzz);
TimedAction readAction   = TimedAction(INTERVAL, readDistance);

TimedAction forwardAction  = TimedAction(20, forward);
TimedAction backwardAction = TimedAction(20, backwards);
TimedAction turnAction = TimedAction(20, turn);


void setup() {
  if (debug){
    Serial.begin(9600);
  }

  pinMode(leftEnable, OUTPUT); 
  pinMode(leftDir1, OUTPUT); 
  pinMode(leftDir2, OUTPUT);

  pinMode(rightEnable, OUTPUT); 
  pinMode(rightDir1, OUTPUT); 
  pinMode(rightDir2, OUTPUT);

  pinMode(ledPin, OUTPUT);
  pinMode(servoPin, OUTPUT);

  // center the servo
  digitalWrite(servoPin, HIGH);	    // Send high-going part of pulse
  delayMicroseconds(1500);          // to servo for 1500us,
  digitalWrite(servoPin, LOW);      // then low.

  // start buzz... useful for detecting resetting of the Arduino
  blink(buzPin, 2, 200,200);
  if (sound_on) {
    on_melody();
  }
  stop(enablePins, rightDirPins, leftDirPins);
}

void loop() {
  blinkAction.check();
  buzzAction.check();
  
  buzzAction.disable();
  
  readAction.check();
  forwardAction.check();
  backwardAction.check();
  backwardAction.disable();
  turnAction.check();
  turnAction.disable();

  
  if (distance < BOUNDARY) {
    
    forwardAction.disable();
    // motorSpeed = baseSpeed;
    if (followMode) {
      if (resetSpeed) {
        motorSpeed = baseSpeed;
        resetSpeed = false;
      }
      backwardAction.enable();
      buzzAction.enable();
    } else {
      stop(enablePins, rightDirPins, leftDirPins);
      backwards(enablePins,rightDirPins,leftDirPins, 180);
      turn(0, 200, false);
    }
    
  } else {
    if (followMode) {
       backwardAction.disable();
       buzzAction.disable();
       digitalWrite(buzPin, LOW);
       buzzState = false;
       resetSpeed = true;
       // motorSpeed = baseSpeed;
    }
    
    forwardAction.enable();
  }
    
  
  /*
  long distance;                    // Distance reading from rangefinder.

  forward(enablePins, rightDirPins, leftDirPins, 255);                        // Robot moves forward continuously.
  do {
    distance = readDistance();      // Take a distance reading.
    // Serial.println(distance);       // Print it out.             
    delay(INTERVAL);                // Delay between readings.
  } 
  while(distance >= BOUNDARY);      // Loop while no objects close-by.

  // Robot has sensed a nearby object and exited the while loop.
  // Take evasive action to avoid object.          
  stop(enablePins, rightDirPins, leftDirPins);
  backwards(enablePins, rightDirPins, leftDirPins, 80);
  delay(800);

  turn(0, 200, sound_on);                   // Turn right 300ms.
  stop(enablePins, rightDirPins, leftDirPins);
  servoSweep(servoSpeed);
  */
}

/*
    blinks an LED
 */
void blink(int whatPin, int howManyTimes, int milliSecs, int pauseMillis) {
  int i = 0;
  for ( i = 0; i < howManyTimes; i++) {
    digitalWrite(whatPin, HIGH);
    delay(milliSecs/2);
    digitalWrite(whatPin, LOW);
    delay(pauseMillis/2);
  }
}

void blink() {
  ledState ? ledState=false : ledState=true;
  digitalWrite(ledPin,ledState);
}

void buzz() {
  buzzState ? buzzState=false : buzzState=true;
  digitalWrite(buzPin,buzzState);
}

void on_melody () {
  // iterate over the notes of the melody:
  for (int thisNote = 0; thisNote < 8; thisNote++) {

    // to calculate the note duration, take one second 
    // divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    int noteDuration = 1000/noteDurations[thisNote];
    tone(buzPin, melody[thisNote],noteDuration);

    // to distinguish the notes, set a minimum time between them.
    // the note's duration + 30% seems to work well:
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    noTone(buzPin);
  }

}

