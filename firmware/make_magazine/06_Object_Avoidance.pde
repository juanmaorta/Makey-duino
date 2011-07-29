/*
 * 06_Object_Avoidance
 * 
 * Makey robot roams around, while avoiding objects
 * sensed with the Ping ultrasonic rangefinder.
 *
 * Makey Robot, MAKE Magazine, Volume 19, p. 77
 * Created: June 2009 Kris Magri
 * Modified:
 * 
 */

  #define pingPin       9      // Ping ultrasonic sensor on pin D9.
  #define leftDir1      7      // Left motor direction 1, to AIn1.
  #define leftDir2      6      // Left motor direction 2, to AIn2.
  #define rightDir1     5      // Right motor direction 1, to BIn1.
  #define rightDir2     4      // Right motor direction 2, to BIn2.
  
  #define BOUNDARY     20      // (cm) Avoid objects closer than 20cm.
  #define INTERVAL     25      // (ms) Interval between distance readings.

// setup
// Set motor pins as OUTPUTS, initialize Serial

void setup()                                                 
{
  pinMode(leftDir1, OUTPUT);        // Set motor direction pins as outputs.
  pinMode(leftDir2, OUTPUT);      
  pinMode(rightDir1, OUTPUT);      
  pinMode(rightDir2, OUTPUT); 
  Serial.begin(9600);
}


// Main program
// Roam around while avoiding objects.
// 
// Set motors to move forward,
// Take distance readings over and over, 
// as long as no objects are too close (determined by BOUNDARY).
// If object is too close, avoid it -- back up and turn.
// Repeat.

void loop()                     
{
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
  
 } // end Main program


// forward
//
// Move robot forward by setting both wheels forward.
// Will persist until something else changes the
// motors' directions.

void forward()
{
  digitalWrite(leftDir1, LOW);      // Left motor forward.             
  digitalWrite(leftDir2, HIGH);
  digitalWrite(rightDir1, LOW);     // Right motor forward.
  digitalWrite(rightDir2, HIGH);
}  


// backward
//
// Move robot backward by setting both wheels backward.
// Will persist until something else changes the
// motors' directions.

void backward()
{
  digitalWrite(leftDir1, HIGH);     // Left motor backward.
  digitalWrite(leftDir2, LOW);
  digitalWrite(rightDir1, HIGH);    // Right motor backward.
  digitalWrite(rightDir2, LOW);
}


// rightTurn
//
// Turn robot to right by moving wheels in opposite directions.
// Amount of turning is determined by duration argument (ms).

void rightTurn(int duration)
{
  digitalWrite(leftDir1, HIGH);     // Left motor backward.
  digitalWrite(leftDir2, LOW);
  digitalWrite(rightDir1, LOW);     // Right motor forward.
  digitalWrite(rightDir2, HIGH);
  delay(duration);                  // Turning time (ms).
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
  // of the ping to the reception of its echo off an object.
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
