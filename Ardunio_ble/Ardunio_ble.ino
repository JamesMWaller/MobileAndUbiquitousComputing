/*
  Battery Monitor

  This example creates a Bluetooth® Low Energy peripheral with the standard battery service and
  level characteristic. The A0 pin is used to calculate the battery level.

  The circuit:
  - Arduino MKR WiFi 1010, Arduino Uno WiFi Rev2 board, Arduino Nano 33 IoT,
    Arduino Nano 33 BLE, or Arduino Nano 33 BLE Sense board.

  You can use a generic Bluetooth® Low Energy central app, like LightBlue (iOS and Android) or
  nRF Connect (Android), to interact with the services and characteristics
  created in this sketch.

  This example code is in the public domain.
*/

#include <ArduinoBLE.h>
#include <Arduino_LSM9DS1.h>

 // Bluetooth® Low Energy Battery Service
BLEService dataService("180F");

// Bluetooth® Low Energy Battery Level Characteristic
BLEUnsignedCharCharacteristic xVal("2A19",  // standard 16-bit characteristic UUID
    BLERead | BLENotify); // remote clients will be able to get notifications if this characteristic changes

BLEUnsignedCharCharacteristic yVal("2A20",  // standard 16-bit characteristic UUID
    BLERead | BLENotify); // remote clients will be able to get notifications if this characteristic changes

BLEUnsignedCharCharacteristic zVal("2A21",  // standard 16-bit characteristic UUID
    BLERead | BLENotify); // remote clients will be able to get notifications if this characteristic changes



int oldBatteryLevel = 0;  // last battery level reading from analog input
long previousMillis = 0; // last time the battery level was checked, in ms
float xAverageList[5] = {0, 0, 0, 0, 0};
float yAverageList[5] = {0, 0, 0, 0, 0};
float zAverageList[5] = {0, 0, 0, 0, 0};



void setup() {
  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (1);
  }
  Serial.println("X\tY\tZ");
  Serial.begin(9600);    // initialize serial communication
  while (!Serial);

  pinMode(LED_BUILTIN, OUTPUT); // initialize the built-in LED pin to indicate when a central is connected

  // begin initialization
  if (!BLE.begin()) {
    Serial.println("starting BLE failed!");

    while (1);
  }

  /* Set a local name for the Bluetooth® Low Energy device
     This name will appear in advertising packets
     and can be used by remote devices to identify this Bluetooth® Low Energy device
     The name can be changed but maybe be truncated based on space left in advertisement packet
  */
  BLE.setLocalName("Team2Arduino");
  BLE.setAdvertisedService(dataService); // add the service UUID
  dataService.addCharacteristic(xVal);
  dataService.addCharacteristic(yVal);
  dataService.addCharacteristic(zVal); // add the battery level characteristic
  BLE.addService(dataService); // Add the battery service
   // set initial value for this characteristic

  /* Start advertising Bluetooth® Low Energy.  It will start continuously transmitting Bluetooth® Low Energy
     advertising packets and will be visible to remote Bluetooth® Low Energy central devices
     until it receives a new connection */

  // start advertising
  BLE.advertise();

  Serial.println("Bluetooth® device active, waiting for connections...");
}

void loop() {
  // wait for a Bluetooth® Low Energy central
  BLEDevice central = BLE.central();

  // if a central is connected to the peripheral:
  if (central) {
    Serial.print("Connected to central: ");
    // print the central's BT address:
    Serial.println(central.address());
    // turn on the LED to indicate the connection:
    digitalWrite(LED_BUILTIN, HIGH);

    // check the battery level every 200ms
    // while the central is connected:
    while (central.connected()) {
      long currentMillis = millis();
      // if 200ms have passed, check the battery level:
      if (currentMillis - previousMillis >= 50) {
        previousMillis = currentMillis;
        updateValues();
      }
    }
    // when the central disconnects, turn off the LED:
    digitalWrite(LED_BUILTIN, LOW);
    Serial.print("Disconnected from central: ");
    Serial.println(central.address());
  }
}

void updateValues() {
  float x,y,z;
  
  

  /* Read the current voltage level on the A0 analog input pin.
     This is used here to simulate the charge level of a battery.
  */
  if (IMU.accelerationAvailable()) {
    IMU.readAcceleration(x, y, z);

    shiftAndInsert(xAverageList , 5 , x);
    shiftAndInsert(yAverageList , 5 , y);
    shiftAndInsert(zAverageList , 5 , z);

    float xAverage = getAverage(xAverageList, 5);
    float yAverage = getAverage(yAverageList, 5);
    float zAverage = getAverage(zAverageList, 5);



    
    Serial.print(xAverage);
    Serial.print('\t');
    Serial.print(yAverage);
    Serial.print('\t');
    Serial.print(zAverage);
    Serial.print(x); 
    Serial.print('\t');//ble only allows integer positives hence the x100 +400
    Serial.print(y);
    Serial.print('\t');
    Serial.println(z); 
    

    // if the battery level has changed
    
    xVal.writeValue((x+4)*10); //ble only allows integers between 0 and 256
    yVal.writeValue((y+4)*10); // so detail is being lost atm
    zVal.writeValue((z+4)*10);  // and update the battery level characteristic           // save the level for next comparison
  }
}

void shiftAndInsert(float arr[], int size, float newValue) {
    // Shift all elements to the right
    for (int i = size - 1; i > 0; i--) {
        arr[i] = arr[i - 1];
    }
    // Insert the new value at the beginning
    arr[0] = newValue;
}

float getAverage(float arr[], int size) {
    float sum = 0;
    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }
    return sum / size;
}