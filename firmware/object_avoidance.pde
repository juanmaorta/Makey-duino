
  /*
  const int motor1Pin = 3;    // H-bridge leg 1 (pin 2, 1A)
  const int motor2Pin = 4;    // H-bridge leg 2 (pin 7, 2A)

  const int enablePin = 9;    // H-bridge enable pin
  const int enablePin2 = 8;
  const int ledPin = 13;      // LED 
  */
  
  #define pingPin       9
  
  #define  leftEnable   3
  #define leftDir1      2 // sustituir por 2 (antes 6)
  #define  leftDir2     7
  
  
  #define  rightEnable   11
  #define  rightDir1     12 // sustituir por 12 (antes 5)
  #define  rightDir2     4
  
  #define  ledPin       13
  
  #define BOUNDARY     20      // (cm) Avoid objects closer than 20cm.
  #define INTERVAL     25      // (ms) Interval between distance readings.

  void setup() {
    Serial.begin(9600);

    
    pinMode(leftEnable, OUTPUT); 
    pinMode(leftDir1, OUTPUT); 
    pinMode(leftDir2, OUTPUT);
    
    
    pinMode(rightEnable, OUTPUT); 
    pinMode(rightDir1, OUTPUT); 
    pinMode(rightDir2, OUTPUT);
    

    pinMode(ledPin, OUTPUT);

    // set enablePin high so that motor can turn on:
    
    digitalWrite(leftEnable, LOW); 
    // digitalWrite(leftEnable, HIGH); 
    analogWrite(leftEnable, 255);
    
   
    digitalWrite(rightEnable, LOW); 
    // digitalWrite(rightEnable, HIGH);
    analogWrite(rightEnable, 255);
    
    
    blink(ledPin, 4, 500);
    stop();
  }

  void loop() {
  long distance;                    // Distance reading from rangefinder.
  
  forward();                        // Robot moves forward continuously.
  do 
  {
    distance = readDistance();      // Take a distance reading.
    Serial.println(distance);       // Print it out.             
    delay(INTERVAL);                // Delay between readings.
  }
  while(distance >= BOUNDARY);      // Loop while no objects close-by.
  
  // Robot has sensed a nearby object and exited the while loop.
  // Take evasive action to avoid object.          
  backward();                       // Move backward 500ms.
  delay(500);               
  rightTurn(300);                   // Turn right 300ms.
  }

  /*
    blinks an LED
   */
  void blink(int whatPin, int howManyTimes, int milliSecs) {
    int i = 0;
    for ( i = 0; i < howManyTimes; i++) {
      digitalWrite(whatPin, HIGH);
      delay(milliSecs/2);
      digitalWrite(whatPin, LOW);
      delay(milliSecs/2);
    }
  }

 void stop() {
       digitalWrite(leftEnable, LOW); 
    digitalWrite(leftEnable, HIGH); 
    
   
    digitalWrite(rightEnable, LOW); 
    digitalWrite(rightEnable, HIGH); 
   /*
   digitalWrite(rightDir1, LOW);   // set leg 1 of the H-bridge low
   digitalWrite(rightDir2, LOW);  // set leg 2 of the H-bridge high

    // delay(2000);
   digitalWrite(leftDir1, LOW);   // set leg 1 of the H-bridge low
   digitalWrite(leftDir2, LOW);  // set leg 2 of the H-bridge high
   */
   Serial.println("stop");
 }

 // Move the robot forward
 // 
 void forward() {
   Serial.println("Go!");
   digitalWrite(rightDir1, HIGH);   // set leg 1 of the H-bridge low
   digitalWrite(rightDir2, LOW);  // set leg 2 of the H-bridge high

    // delay(2000);
   digitalWrite(leftDir1, HIGH);   // set leg 1 of the H-bridge low
   digitalWrite(leftDir2, LOW);  // set leg 2 of the H-bridge high
 }
 
  void backward() {
  Serial.println("Back!");
   digitalWrite(rightDir1, LOW);   // set leg 1 of the H-bridge low
   digitalWrite(rightDir2, HIGH);  // set leg 2 of the H-bridge high

    // delay(2000);
   digitalWrite(leftDir1, LOW);   // set leg 1 of the H-bridge low
   digitalWrite(leftDir2, HIGH);  // set leg 2 of the H-bridge high
 }
 
 void rightTurn(int duration) {
   Serial.println("Right!");
   digitalWrite(leftDir1, HIGH);     // Left motor backward.
  digitalWrite(leftDir2, LOW);
  digitalWrite(rightDir1, LOW);     // Right motor forward.
  digitalWrite(rightDir2, HIGH);
  delay(duration);                  // Turning time (ms).
}

// readDistance
// Take a distance reading from Ping ultrasonic rangefinder.
// from http://arduino.cc/en/Tutorial/Ping?from=Tutorial.UltrasoundSensor
 
long readDistance() {
  long duration, inches, cm;

  // The Ping is triggered by a HIGH pulse of 2 or more microseconds.
  // We give a short LOW pulse beforehand to ensure a clean HIGH pulse.
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  // The same pin is used to read the signal from the Ping: a HIGH
  // pulse whose duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off an object.
  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);

  // Convert the time into a distance.
  cm = microsecondsToCentimeters(duration);
  return(cm);
}

long microsecondsToCentimeters(long microseconds) {
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the
  // object we take half of the distance traveled.
  return microseconds / 29 / 2;
}
