#include <Arduino_LSM9DS1.h>

  float ax, ay, az;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("Started");

  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (1);
  }

  Serial.print("Accelerometer sample rate = ");
  Serial.print(IMU.accelerationSampleRate());
  Serial.println(" Hz");
  Serial.println();
  Serial.println("Acceleration in g's");
  Serial.println("X\tY\tZ");
}

void loop() {


  if (IMU.accelerationAvailable()) {
    IMU.readAcceleration(ax, ay, az);
    
    Serial.print('#');
    Serial.print(ax);
    Serial.print(':');
    Serial.print(ay);
    Serial.print(':');
    Serial.println(az);
  }
}
