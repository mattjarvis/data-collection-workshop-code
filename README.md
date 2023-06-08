# data-collection-workshop-code
Example code for collecting data with the Arduino BLE

**Data collection workshop**

Introduction to the Arduino BLE Sense:

**Download Arduino IDE & example code**

-   <https://www.arduino.cc/en/software>

-   Install Arduino BLE Sense board

-   <https://www.arduino.cc/en/Guide/NANO33BLESense>

1.  Install Arduino BLE Sense examples

-   Matt's github: <https://github.com/mattjarvis/data-collection-workshop-code>

a.  Upload blink sketch to test everything works ok!

b\. Set up real-time serial connection to computer

c.  Send real-time humidity & temperature data from sensors through the serial port:

-   Install the HTS221 library from the library manager
-   Open the HTS221 example from the example sketches menu
-   Upload the example sketch
-   Open the serial monitor and check you are getting data

d.  Send the audio analysis through the serial port:

-   Open the PDM Serial Plotter example
-   Upload the PDM example sketch
-   Open the Serial Plotter
-   Make some noise!
-   Review the documentation: <https://docs.arduino.cc/learn/built-in-libraries/pdm>
-   What happens if you change the number of channels? How about the frequency?

e.  Run a program on the computer to use the data in something

-   Change the channel number back to 1 in the PDM example sketch
-   Open the ***GraphProcessingCode*** Processing 3 sketch (Install Processing, if you don't have it: <https://processing.org/download>)
-   Change the number of the serial array index (line 29) to match your serial port (you can run the sketch and it will print the array)
-   Run the sketch and watch the results
-   What happens if you change the input and output of the map() function (on line 63)?

f.  Let's try getting some data in really fast, using the built in accelerometer

-   Open the Arduino sketch at <https://github.com/mattjarvis/data-collection-workshop-code/blob/main/2%20-%20AccelerometerTest/AccelerometerTest.ino>
-   Upload it to the arduino
-   Open the Processing sketch from <https://github.com/mattjarvis/data-collection-workshop-code/blob/main/ProcessingSketches/2%20-RotateCubeSerialInput/RotateCubeSerialInput.pde>

**Extra challenge:** How would you add the sound from point 2, the PDM Serial Plotter example to point 4, the accelerometer example? (An answer is [here](https://github.com/mattjarvis/data-collection-workshop-code/tree/main/2.1%20-%20AccelerometerTestWithSound) and [here](https://github.com/mattjarvis/data-collection-workshop-code/tree/main/ProcessingSketches/2.1%20RotateCubeSerialInputSizeIncreasing))

2\. Data logging

Now we are familiar in having the Arduino give us data, let's try and do something with it. Let's start by saving the data:

a.  Upload the ENV sensing Arduino sketch

-   <https://github.com/mattjarvis/data-collection-workshop-code/tree/main/3.1_SendEnvData>

b.  Run a bridge program to save your data

-   <https://github.com/mattjarvis/data-collection-workshop-code/tree/main/ProcessingSketches/sketch_3_SaveSerialInputAsTable>

3\. Going online

Now let's look at ways to use the data with MQTT:

a.  Upload the ENV sensing Arduino sketch

-   <https://github.com/mattjarvis/data-collection-workshop-code/tree/main/3.1_SendEnvData>

b.  Run a bridge program to send data to MQTT on cci server

-   <https://github.com/mattjarvis/data-collection-workshop-code/tree/main/ProcessingSketches/sketch_4_PublishSerialToMQTT>

c.  Show incoming MQTT data with <http://mqtt-explorer.com/>
