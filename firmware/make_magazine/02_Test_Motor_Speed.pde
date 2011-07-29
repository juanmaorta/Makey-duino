/*
 * 02_Test_Motor_Speed
 * 
 * Left motor forward, ramping up in speed
 * Left motor backward full speed
 * Right motor forward, ramping up in speed
 * Right motor backward full speed
 *
 * Includes Serial.print() for debugging.
 *
 * Makey Robot, MAKE Magazine, Volume 19, p. 77
 * Created: June 2009 Kris Magri
 * Modified:
 * 
 */

  #define leftSpeedPin 11      // Left motor speed control, to PWM_A
  #define leftDir1      7      // Left motor direction 1, to AIn1
  #define leftDir2      6      // Left motor direction 2, to AIn2
  #define rightDir1     5      // Right motor direction 1, to BIn1
  #define rightDir2     4      // Right motor direction 2, to BIn2
  #define rightSpeedPin 3      // Right motor speed control, to PWM_B 
  #define DELAY         350    // (ms) milliseconds


// setup
// All code is here, so that motions don't repeat.

void setup()                   
{
  int motorSpeed;                   // From 0->255, slow->fast.

  pinMode(leftDir1, OUTPUT);        // Set motor direction pins as outputs.
  pinMode(leftDir2, OUTPUT);      
  pinMode(rightDir1, OUTPUT);      
  pinMode(rightDir2, OUTPUT); 
  Serial.begin(9600);

  Serial.println("Start left motor forward");  
  digitalWrite(leftSpeedPin, HIGH); // Needed, but why?? --km
  digitalWrite(leftDir1, LOW);      // Expect left motor to go forward
  digitalWrite(leftDir2, HIGH);     // (counterclockwise).

  // Ramp speed up from 0 to 255.
  // Expect motor speed to slowly increase to full speed.
  
  for (motorSpeed = 0; motorSpeed <= 255; motorSpeed++) 
  {
    analogWrite(leftSpeedPin, motorSpeed);
    delay(10);
  }

  // Cancel PWM initiated by analogWrite().
  digitalWrite(leftSpeedPin, HIGH); 

  Serial.println("Start left motor backward");  
  digitalWrite(leftDir1, HIGH);     // Expect left motor to go backward
  digitalWrite(leftDir2, LOW);      // full speed. 

  delay(DELAY);

  Serial.println("Start left motor off"); 
  digitalWrite(leftDir1, LOW);     // Expect left motor to turn off.
  digitalWrite(leftDir2, LOW);
  
  delay(DELAY);

  Serial.println("Start right motor forward");  
  digitalWrite(rightSpeedPin, HIGH);// Needed, but why?? --km
  digitalWrite(rightDir1, LOW);     // Expect right motor forward.
  digitalWrite(rightDir2, HIGH);   

  // Ramp speed up from 0 to 255.
  // Expect motor speed to slowly increase to full speed.
 
  for (motorSpeed = 0; motorSpeed <= 255; motorSpeed++) 
  {
    analogWrite(rightSpeedPin, motorSpeed);
    delay(10);
  }

  // Cancel PWM initiated by analogWrite()
  digitalWrite(rightSpeedPin, HIGH);   
  
  Serial.println("Start right motor backward");    
  digitalWrite(rightDir1, HIGH);    // Expect right motor backward
  digitalWrite(rightDir2, LOW);     // full speed.

  delay(DELAY);  

  Serial.println("Start right motor off");  
  digitalWrite(rightDir1, LOW);     // Expect right motor off.
  digitalWrite(rightDir2, LOW);  

} // end setup


void loop()  
{
  // do nothing
}
