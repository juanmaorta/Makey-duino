/*
 * 01_Test_Motor_Rotation
 * 
 * Move left motor:  forward, backward, off.
 * Then, move right motor: forward, backward, off.
 * 
 * Makey Robot, MAKE Magazine, Volume 19, p. 77
 * Created: June 2009 Kris Magri
 * Modified:
 * 
 */

  #define leftDir1      7      // Left motor direction 1, to AIn1
  #define leftDir2      6      // Left motor direction 2, to AIn2
  #define rightDir1     5      // Right motor direction 1, to BIn1
  #define rightDir2     4      // Right motor direction 2, to BIn2
  #define DELAY         350    // (ms) milliseconds


// setup
// All code is here, so that motors move only once.

void setup()                    
{
  pinMode(leftDir1, OUTPUT);        // Set motor direction pins as outputs.
  pinMode(leftDir2, OUTPUT);      
  pinMode(rightDir1, OUTPUT);      
  pinMode(rightDir2, OUTPUT); 

  digitalWrite(leftDir1, LOW);      // Expect left motor to go forward
  digitalWrite(leftDir2, HIGH);     // (counterclockwise).

  delay(DELAY);
  
  digitalWrite(leftDir1, HIGH);     // Expect left motor to go backward.
  digitalWrite(leftDir2, LOW);

  delay(DELAY);
  
  digitalWrite(leftDir1, LOW);      // Expect left motor to turn off.
  digitalWrite(leftDir2, LOW);
  
  delay(DELAY);
  
  digitalWrite(rightDir1, LOW);     // Expect right motor forward.
  digitalWrite(rightDir2, HIGH);   

  delay(DELAY);
  
  digitalWrite(rightDir1, HIGH);    // Expect right motor backward.
  digitalWrite(rightDir2, LOW);
  
  delay(DELAY);
  
  digitalWrite(rightDir1, LOW);     // Expect right motor off.
  digitalWrite(rightDir2, LOW);
  
} // end setup


void loop()                    
{
  // do nothing
} 
