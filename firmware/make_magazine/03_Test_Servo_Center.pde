/*
 * 03_Test_Servo_Center
 * 
 * Move the servomotor to the center position.
 * 
 * Makey Robot, MAKE Magazine, Volume 19, p. 77
 * Created: June 2009 Kris Magri
 * Modified:
 *
 */

  #define servoPin     10      // Servomotor on pin D10

// setup
// Set servo as OUTPUT pin.

void setup()                                                 
{
  pinMode(servoPin, OUTPUT);     
}


// Main program
// Center the servomotor by sending it a 1500us (1.5ms)
// pulse every 20ms.

void loop()                    
{
  digitalWrite(servoPin, HIGH);	    // Send high-going part of pulse
  delayMicroseconds(1500);          // to servo for 1500us, 
  digitalWrite(servoPin, LOW);      // then low.

  delay(20);                        // Repeat pulse every 20ms.
} 
