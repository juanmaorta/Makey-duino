
#define ledPin      13

#define leftEnable  3
#define leftDir1    2
#define leftDir2    7

#define rightEnable  11
#define rightDir1    12
#define rightDir2    4

void setup() {
  Serial.begin(9600); 
  
   pinMode(ledPin, OUTPUT);
   pinMode(leftEnable, OUTPUT);
   pinMode(leftDir1, OUTPUT);
   pinMode(leftDir2, OUTPUT);
   
   pinMode(rightEnable, OUTPUT);
   pinMode(rightDir1, OUTPUT);
   pinMode(rightDir2, OUTPUT);
   
   // enable motors
   digitalWrite(leftEnable, HIGH);
   digitalWrite(rightEnable, HIGH);
   
   // gradually increases motor speed
   digitalWrite(leftDir1, HIGH);
   digitalWrite(leftDir2, LOW);
   
  
   digitalWrite(rightDir1, HIGH);
   digitalWrite(rightDir2, LOW);
  
  
   for (int value = 40; value <= 250; value++) {
     analogWrite(leftEnable, value);
     analogWrite(rightEnable, value);
     delay(20);
   }
   
   // stops motors
   digitalWrite(leftEnable, LOW);
   digitalWrite(rightEnable, LOW);
   
   // changes direction
   digitalWrite(leftDir1, LOW);
   digitalWrite(leftDir2, HIGH);
   
  
   digitalWrite(rightDir1, LOW);
   digitalWrite(rightDir2, HIGH);
   
   for (int value = 40; value <= 250; value++) {
     analogWrite(leftEnable, value);
      analogWrite(rightEnable, value);
      delay(20);
   }
   
   // stops motors
   digitalWrite(leftDir1, LOW);
   digitalWrite(leftDir2, LOW);
   
  
   digitalWrite(rightDir1, LOW);
   digitalWrite(rightDir2, LOW);
   
   digitalWrite(leftEnable, LOW);
   digitalWrite(rightEnable, LOW);

}

void loop() {
  
}
