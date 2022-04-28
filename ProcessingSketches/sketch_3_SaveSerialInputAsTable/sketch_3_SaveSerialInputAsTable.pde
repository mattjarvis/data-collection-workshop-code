/*
  Save data from serial port into a CSV file
 */

// Import serial library
import processing.serial.*;
import java.io.FileWriter;
import java.io.*;

// Open port
Serial myPort;

//Set up variables
float temp=0, hum=0;
String time;
Table table;

void setup() {
  size(40, 40);
  myPort = new Serial(this, Serial.list()[2], 9600);  // Set array pointer to whatever your Arduino port is plugged into
  myPort.bufferUntil('\n');
  table = new Table();
  table.addColumn("time");
  table.addColumn("temp");
  table.addColumn("hum");
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

  time = dateMy + timeMy;

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
      TableRow newRow = table.addRow();
      newRow.setString("time", time);
      newRow.setFloat("temp", temp);
      newRow.setFloat("hum", hum);
      saveTable(table, "data/myData.csv");
    }
  }
}
