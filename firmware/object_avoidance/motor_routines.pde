int motor_start = 20;
int easing = 10;

void forward(int enablePins[], int rightDirPins[], int leftDirPins[], int limit) {
   // enable motors
   digitalWrite(enablePins[0], HIGH);
   digitalWrite(enablePins[1], HIGH);
   
   // gradually increases motor speed
   digitalWrite(leftDirPins[0], HIGH);
   digitalWrite(leftDirPins[1], LOW);
     
   digitalWrite(rightDirPins[0], HIGH);
   digitalWrite(rightDirPins[1], LOW);
    
   for (int value = motor_start; value <= limit; value++) {
     analogWrite(enablePins[0], value);
     analogWrite(enablePins[1], value);
     delay(easing);
   }
}

void backwards(int enablePins[], int rightDirPins[], int leftDirPins[], int limit) {
   // enable motors
   digitalWrite(enablePins[0], HIGH);
   digitalWrite(enablePins[1], HIGH);
   
   // gradually increases motor speed
   digitalWrite(leftDirPins[0], LOW);
   digitalWrite(leftDirPins[1], HIGH);
     
   digitalWrite(rightDirPins[0], LOW);
   digitalWrite(rightDirPins[1], HIGH);
    
   for (int value = motor_start; value <= limit; value++) {
     analogWrite(enablePins[0], value);
     analogWrite(enablePins[1], value);
     delay(easing);
   }
}

 void turn(long dir, int duration, boolean beep) {
  
   // Serial.println(dir);
   if (dir == 0) {
      digitalWrite(leftDir1, HIGH);     // Left motor backward.
      digitalWrite(leftDir2, LOW);
      digitalWrite(rightDir1, LOW);     // Right motor forward.
      digitalWrite(rightDir2, HIGH);
   } else {
      digitalWrite(leftDir1, LOW);     // Left motor backward.
      digitalWrite(leftDir2, HIGH);
      digitalWrite(rightDir1, HIGH);     // Right motor forward.
      digitalWrite(rightDir2, LOW);
   }
   delay(duration);                  // Turning time (ms).
   
   if (beep) {
      blink(buzPin, 2, 200,200);
   }
}

void stop(int enablePins[], int rightDirPins[], int leftDirPins[]) {
   digitalWrite(leftDirPins[0], LOW);
   digitalWrite(leftDirPins[1], LOW);
   
  
   digitalWrite(rightDirPins[0], LOW);
   digitalWrite(rightDirPins[1], LOW);
   
   digitalWrite(enablePins[0], LOW);
   digitalWrite(enablePins[1], LOW);

}
