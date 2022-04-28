/*
   This example exposes the second half (512KB) of Nano 33 BLE flash
   as a USB disk.
   The user can interact with this disk as a bidirectional communication with the board
   For example, the board could save data in a file to be retrieved later with a drag and drop

   Here, we save the humidity and temperature data as an example...
*/

#include "PluggableUSBMSD.h" // library for accessing USB devices
#include <Arduino_HTS221.h> // library for HTS221 chip 

void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!HTS.begin()) {
    Serial.println("Failed to initialize humidity temperature sensor!");
    while (1);
  }

  MassStorage.begin();

  for (int i = 0; i < 10; i++) {

    float temperature = HTS.readTemperature();
    float humidity    = HTS.readHumidity();

    // print each of the sensor values
    Serial.print("Temperature = ");
    Serial.print(temperature);
    Serial.println(" °C");

    Serial.print("Humidity    = ");
    Serial.print(humidity);
    Serial.println(" %");

    // print an empty line
    Serial.println();


    FILE *f = fopen("/fs/data.txt", "a+");
    String data = ""; // = (string)temperature + "Hello from Nano33BLE Filesystem\n";
    data = String(temperature) + "," + String(humidity) + "\n";
    Serial.print(data);
    fwrite(data.c_str(), data.length(), 1, f);
    fclose(f);
    Serial.println(" written to file.");

    delay(1000);
  }

}

void loop() {
  delay(1000);
}
