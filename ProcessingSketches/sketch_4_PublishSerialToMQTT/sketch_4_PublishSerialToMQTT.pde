// Install the MQTT library
// This script works as a bridge to take serial data and send it to an MQTT server

import mqtt.*;
import processing.serial.*;

// Create MQTT Client
MQTTClient client;

// Open port
Serial myPort;

//Set up variables
String userName = "userName"; // set this to your username
String password = "";
float temp=0, hum=0;
String time;


class Adapter implements MQTTListener {
  void clientConnected() {
    println("client connected");
    // client.subscribe("env_sensors/envsense1"); we can use this funtion to subscribe to data
  }

  void messageReceived(String topic, byte[] payload) {
    println("new message: " + topic + " - " + new String(payload));
  }

  void connectionLost() {
    println("connection lost");
  }
}

Adapter adapter;

void setup() {
  size(40, 40);
  myPort = new Serial(this, Serial.list()[2], 9600);  // Set array pointer to whatever your Arduino port is plugged into
  myPort.bufferUntil('\n');

  adapter = new Adapter();
  client = new MQTTClient(this, adapter);
  client.connect("mqtt://matt:"+password+"@cci.arts.ac.uk", "matt");
}

void draw() {
  background(0.5); // Grey is good
}


void serialEvent (Serial myPort) {

  String dateMy, timeMy="";

  dateMy = nf(year(), 4)+"/"
    +nf(month(), 2)+"/"
    +nf(day(), 2);

  timeMy= nf(hour(), 2)+":"
    +nf(minute(), 2)+":"
    +nf(second(), 2);

  time = dateMy + " " + timeMy;

  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    println(inString);
    String  data[]  =  split(inString, ":"); // assuming our string from the arduino is sent like this: "#0.00:0.00:0.00"
    //check  if  the  string  starts  with  #  and  there  are  at  least  2  values
    if (data.length>1) {
      println("OK");
      temp = float(data[0]);
      hum =  float(data[1]);
      println("time", time, "temp:", temp, "hum:", hum);
      client.publish(userName+"/time", time);
      client.publish(userName+"/temp", str(temp));
      client.publish(userName+"/hum", str(hum));
    }
  }
}
