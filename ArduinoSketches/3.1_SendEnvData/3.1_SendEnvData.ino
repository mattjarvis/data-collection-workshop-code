// Simple sketch to send temperature and humidity

#include <Arduino_HTS221.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("Started");


  if (!HTS.begin()) {
    Serial.println("Failed to initialize humidity temperature sensor!");
    while (1);
  }
}

void loop() {
  // read all the sensor values
  float temperature = HTS.readTemperature();
  float humidity    = HTS.readHumidity();

  Serial.print(temperature);
  Serial.print(':');
  Serial.println(humidity);

  // wait 10 second to print again
  delay(10000);
}
