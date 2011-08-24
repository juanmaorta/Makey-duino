
#define ledPin      13

#define leftEnable  3
#define leftDir1    2
#define leftDir2    7

#define rightEnable  11
#define rightDir1    12
#define rightDir2    4

int enablePins[] = {rightEnable, leftEnable};
int rightDirPins[] = {leftDir1, leftDir2};
int leftDirPins[] = {rightDir1, rightDir2};

void setup() {
   pinMode(ledPin, OUTPUT);
   pinMode(leftEnable, OUTPUT);
   pinMode(leftDir1, OUTPUT);
   pinMode(leftDir2, OUTPUT);
   
   pinMode(rightEnable, OUTPUT);
   pinMode(rightDir1, OUTPUT);
   pinMode(rightDir2, OUTPUT);
   
   forward(enablePins, rightDirPins, leftDirPins);
   
   // stops motors
   stop(enablePins, rightDirPins, leftDirPins);
   
   backwards(enablePins, rightDirPins, leftDirPins);
   
   // stops motors
   stop(enablePins, rightDirPins, leftDirPins);

}

void loop() {

}
