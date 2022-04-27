/*
// Rotate a cide according to readings from the serial port. 
// Code modified from FILIPPO SANFILIPPO's post here: 
// http://filipposanfilippo.inspitivity.com/programming/pmodacl-accelerometer-sending-data-from-arduino-to-processing-with-i2c-protocol/163
// to work with Arduino BLE Sense by Matt Jarvis
*/

// Import serial library
import processing.serial.*;

// Open port
Serial myPort; 

//Set up variables
float xmag=0, ymag=0, zmag=0;
float newXmag=0, newYmag=0, newZmag=0;
float x=0, y=0, z=0;

void setup() {
  size(400, 400, P3D);  // We are going into 3D!
  myPort = new Serial(this, Serial.list()[2], 9600);  // Set array pointer to whatever your Arduino port is plugged into
  myPort.bufferUntil('\n');
  noStroke();
  colorMode(RGB, 1);
}

void draw() {
  background(0.5); // Grey is good

  pushMatrix();
  translate(width/2, height/2, 0);
  
  // Calculate difference of spinningness from incoming data
  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) {
    xmag -= diff/8.0;
  }

  diff = ymag-newYmag;
  if (abs(diff) >  0.01) {
    ymag -= diff/8.0;
  }

  diff = zmag-newZmag;
  if (abs(diff) >  0.01) {
    zmag -= diff/8.0;
  }

  // Do the rotation
  rotateX(-ymag);
  rotateY(-xmag);
  rotateZ(-zmag);

  //Set our size
  scale(90);

  //Draw the cube
  beginShape(QUADS);

  fill(0, 1, 1);
  vertex(-1, 1, 1);
  fill(1, 1, 1);
  vertex( 1, 1, 1);
  fill(1, 0, 1);
  vertex( 1, -1, 1);
  fill(0, 0, 1);
  vertex(-1, -1, 1);

  fill(1, 1, 1);
  vertex( 1, 1, 1);
  fill(1, 1, 0);
  vertex( 1, 1, -1);
  fill(1, 0, 0);
  vertex( 1, -1, -1);
  fill(1, 0, 1);
  vertex( 1, -1, 1);

  fill(1, 1, 0);
  vertex( 1, 1, -1);
  fill(0, 1, 0);
  vertex(-1, 1, -1);
  fill(0, 0, 0);
  vertex(-1, -1, -1);
  fill(1, 0, 0);
  vertex( 1, -1, -1);

  fill(0, 1, 0);
  vertex(-1, 1, -1);
  fill(0, 1, 1);
  vertex(-1, 1, 1);
  fill(0, 0, 1);
  vertex(-1, -1, 1);
  fill(0, 0, 0);
  vertex(-1, -1, -1);

  fill(0, 1, 0);
  vertex(-1, 1, -1);
  fill(1, 1, 0);
  vertex( 1, 1, -1);
  fill(1, 1, 1);
  vertex( 1, 1, 1);
  fill(0, 1, 1);
  vertex(-1, 1, 1);

  fill(0, 0, 0);
  vertex(-1, -1, -1);
  fill(1, 0, 0);
  vertex( 1, -1, -1);
  fill(1, 0, 1);
  vertex( 1, -1, 1);
  fill(0, 0, 1);
  vertex(-1, -1, 1);

  endShape();

  popMatrix();
}

void serialEvent (Serial myPort) {

  // using try as the code fails with the wrong serial port set
  try {
    // get the ASCII string:
    String inString = myPort.readStringUntil('\n');

    if (inString != null) {
      println(inString);
      String  temp[]  =  split(inString, ":"); // assuming our string from the arduino is sent like this: "#0.00:0.00:0.00"
      //check  if  the  string  starts  with  #  and  there  are  at  least  3  values
      if (inString.charAt(0)  ==  '#'  &&  temp.length>2) {
        println("OK");
        x =  float(temp[0].replace("#", "")); // need to get rid of that pesky #
        y =  float(temp[1]);
        z =  float(temp[2]);
        println("x:", x, "y:", y, "z:", z);
        newXmag = newXmag + (x/float(width) * TWO_PI); // spin!
        newYmag = newYmag + (y/float(height) * TWO_PI); // spin!
        newZmag = newZmag + ((z-1)/float(width) * TWO_PI); // spin!
        println(newXmag, newYmag, newZmag); // Check numbers for sanity
      }
    }
  }
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}
