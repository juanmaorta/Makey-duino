/*
 * 05_Test_Sensor_Distance
 * 
 * Take readings from Ping ultrasonic rangefinder
 * and print them.
 *
 * Makey Robot, MAKE Magazine, Volume 19, p. 77
 * Created: June 2009 Kris Magri
 * Modified:
 * 
 */

#define pingPin       9      // Ping ultrasonic sensor on pin D9

// setup
// Initialize Serial.
// Don't set Ping pin as OUTPUT because it is used
// as both input and output in readDistance().

void setup()
{
  Serial.begin(9600);
}


// Main program
// Take distance readings and print them.

void loop()
{
  long distance;

  distance = readDistance();
  
  Serial.print(distance);
  Serial.print(" cm");
  Serial.println();

  delay(100);  
}


// readDistance subroutine
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
