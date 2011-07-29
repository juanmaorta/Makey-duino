/*
 * 07_Object_Following
 * 
 * Makey robot follows an object ahead of it
 * by keeping the object at a set distance away.
 * 
 * Makey Robot, MAKE Magazine, Volume 19, p. 77
 * Created: June 2009 Kris Magri
 * Modified:
 * 
 */

  #define servoPin     10      // Servomotor on pin D10.
  #define pingPin       9      // Ping ultrasonic sensor on pin D9.
                               // 2 drive motors, motor driver TB6612FNG.
  #define leftSpeedPin 11      // Left motor speed control, to PWM_A.
  #define leftDir1      7      // Left motor direction 1, to AIn1.
  #define leftDir2      6      // Left motor direction 2, to AIn2.
  #define rightDir1     5      // Right motor direction 1, to BIn1.
  #define rightDir2     4      // Right motor direction 2, to BIn2.
  #define rightSpeedPin 3      // Right motor speed control, to PWM_B.

  #define SERVOCENTER   1500   // Tweak so sensor looks straight ahead.
  #define SERVORIGHT    1800   // Servo position when looking right.
  #define SERVOLEFT     1200   // Servo position when looking left.
  #define MAXSPEED      125    // Limit speed of both drive motors.


// setup
// Delays for 5 seconds and centers servo.
// Gives time so Makey doesn't run away on you.
// Sets I/O pins. Don't set Ping sensor as OUTPUT b/c 
// it is used as both in and out in readDistance() subroutine.

void setup()                                                 
{
  pinMode(leftDir1, OUTPUT);        // Set motor direction pins as outputs.
  pinMode(leftDir2, OUTPUT);      
  pinMode(rightDir1, OUTPUT);      
  pinMode(rightDir2, OUTPUT); 
  pinMode(servoPin, OUTPUT);        // Servomotor as output.
  centerServo();                    // Move servo to center position.
  delay(5000);                      // Wait 5 seconds.
}


// Main program
// Makey attempts to keep objects at a fixed distance away, if object is 
// very far away, Makey will speed up to catch up.  If object is just  
// a bit too far away, Makey will go forward, but slowly, so as not to 
// slam into the object.  If object is too close, Makey backs up.
// 
// Sets speed of motors in proportion to the error between the desired
// distance and the actual distance reading from rangefinder.
// Calculates error, multiplies it by some constant to obtain a motor
// speed.  Takes distance readings to left and right independently, 
// then calculates speed and direction for each wheel independently.
// 
// Look left, take distance reading, calculate speed & direction 
//   of left motor, move left motor.
// Look right,take distance reading, calculate speed & direction 
//   of right motor, move right motor. 
// Repeat.

void loop()                    
{
  int leftDistance, rightDistance;  // Distance readings from Ping sensor. 
  int leftError, rightError;        // Difference between desired distance 
                                    //   and actual distance reading.
  int leftMotorSpeed;               // From 0->255, slow->fast.
  int rightMotorSpeed;
  int numPulses;                    // Number of pulses to servomotor.

  #define desiredDistance 20        // Desired distance from object (cm),  
                                    //    Makey tries to keep 20 cm away.
  #define multiplier 16             // Tweak for best results.
                                    // error * multiplier = speed
                                    // Error  | x16 | x12 | x20 | 
                                    //         Speed
                                    // 1        16    12    20
                                    // 2        32    24    40
                                    // 3        48    36    60
                                    // 4        64    48    80
                                    // 5        80    60    100
                                    // 6        96    72    120     
                                    // 7        112   84    140
                                    // 8        128   96    160
                                    // 9        144   108   180
                                    // 10       160   120   200
                                    // 11       176   132   220
  // Note that motor speed will be limited to MAXSPEED by the program.

  // Look left.
  // Send 10 pulses to move servomotor to the left.

  for (numPulses = 0; numPulses < 10; numPulses++)
  {
    pulseOut(servoPin, SERVOLEFT);
    delay(20);
  } 

  // Take a distance reading, looking left.
  leftDistance = readDistance();
  
  // Calculate left motor speed and direction settings.
  // Error: Negative -- Object too far away, go foward.  
  // Positive -- Too close, back up.  Zero:  Perfect.

  // Calculate error.
  leftError = desiredDistance - leftDistance;  
 
  // Calculate motor speed, force positive.                       
  leftMotorSpeed = (abs(leftError) * multiplier); 
 
  // Limit motor speed to some maximum.         
  leftMotorSpeed = constrain(leftMotorSpeed, 0, MAXSPEED); 
  
  // Decide what to do and move left motor.
  if ( leftError > 0)                                      
  // Object too Close -- back up. 
  {
    // Set the speed as calculated.
    analogWrite(leftSpeedPin, leftMotorSpeed);
  
    // Set the direction -- left motor backward.            
     digitalWrite(leftDir1, HIGH);                          
     digitalWrite(leftDir2, LOW);                           
  }

  if (leftError < 0)   
  // Object too far away -- go forward.                                    
  {
    // Set the speed. 
    analogWrite(leftSpeedPin, leftMotorSpeed);    

    // Set the direction -- left motor forward.         
    digitalWrite(leftDir1, LOW);                           
    digitalWrite(leftDir2, HIGH);
  }

 
  // Look right -- move servomotor to the right
  for (numPulses = 0; numPulses < 10; numPulses++)
  {
    pulseOut(servoPin, SERVORIGHT);
    delay(20);
  }

  // Take a distance reading, looking right.
  rightDistance = readDistance();

  // Calculate right motor speed and direction settings.
  rightError = desiredDistance - rightDistance;
  rightMotorSpeed = (abs(rightError) * multiplier);
  rightMotorSpeed = constrain(rightMotorSpeed, 0, MAXSPEED);  

  // Decide what to do and move right motor.  
  if ( rightError > 0)   
  // Object too close -- back up.                                    
  {
    analogWrite(rightSpeedPin, rightMotorSpeed);          
    digitalWrite(rightDir1, HIGH);                           
    digitalWrite(rightDir2, LOW);
  }

  if (rightError < 0)  
  // Object too far away -- go forward.                                      
  {
    analogWrite(rightSpeedPin, rightMotorSpeed);          
    digitalWrite(rightDir1, LOW);                           
    digitalWrite(rightDir2, HIGH);
  }
} // End main program.


// pulseOut
// Send a single pulse to a servomotor for specified duration, 
// in microseconds.

void pulseOut(byte pinNumber, int duration)
{
  digitalWrite(servoPin, HIGH);
  delayMicroseconds(duration);
  digitalWrite(servoPin, LOW);
}


// centerServo
// Center servomotor so Makey's Ping sensor is looking 
// straight ahead. Move the servomotor to midpoint of its range,
// 1500us (1.5ms).

void centerServo()
{
  byte index;
  
  for (index = 0; index < 20; index++)
  {
    pulseOut(servoPin, SERVOCENTER);
    delay(20);
  }
}


// readDistance
// Take a distance reading from Ping ultrasonic rangefinder.
// from http://arduino.cc/en/Tutorial/Ping?from=Tutorial.UltrasoundSensor
 
long readDistance()
{
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
  // of the ping to the reception of its echo off of an object.
  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);

  // Convert the time into a distance.
  cm = microsecondsToCentimeters(duration);
  return(cm);
}

long microsecondsToCentimeters(long microseconds)
{
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the
  // object we take half of the distance traveled.
  return microseconds / 29 / 2;
}



