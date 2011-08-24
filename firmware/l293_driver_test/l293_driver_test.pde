
  /*
  const int motor1Pin = 3;    // H-bridge leg 1 (pin 2, 1A)
  const int motor2Pin = 4;    // H-bridge leg 2 (pin 7, 2A)

  const int enablePin = 9;    // H-bridge enable pin
  const int enablePin2 = 8;
  const int ledPin = 13;      // LED 
  */
  
  #define  leftEnable   3
  #define leftDir1      2 // sustituir por 2 (antes 6)
  #define  leftDir2     7
  
  
  #define  rightEnable   11
  #define  rightDir1     12 // sustituir por 12 (antes 5)
  #define  rightDir2     4
  
  #define  ledPin       13

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
    digitalWrite(leftEnable, HIGH); 
    
   
    digitalWrite(rightEnable, LOW); 
    digitalWrite(rightEnable, HIGH); 
    
    
    blink(ledPin, 4, 500);
    stop();
  }

  void loop() {
    forward();
    delay(2000);
    stop();
    delay(1000);
    backward();
    delay(2000);
    stop();
    delay(1000);
    stop();
    rightTurn(500);
    stop();
    delay(1000);
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
