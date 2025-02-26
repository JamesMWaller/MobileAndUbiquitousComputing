/*
  IMU Classifier

  This example uses the on-board IMU to start reading acceleration
  data from on-board IMU, once enough samples are read, it then uses a
  TensorFlow Lite (Micro) model to try to classify the movement as a known gesture.

  Note: The direct use of C/C++ pointers, namespaces, and dynamic memory is generally
        discouraged in Arduino examples, and in the future the TensorFlowLite library
        might change to make the sketch simpler.

  The circuit:
  - Arduino Nano 33 BLE or Arduino Nano 33 BLE Sense board.

  Created by Abhirup Ghosh for MUC lab, University of Birmingham

  This example code is inspired by https://github.com/arduino/ArduinoTensorFlowLiteTutorials/tree/master
*/

#include <Arduino_LSM9DS1.h>

#include <TensorFlowLite.h>
#include "tensorflow/lite/micro/all_ops_resolver.h"
#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include <ArduinoBLE.h>


#include "model.h"

#include "mbed.h"
#include "mbed_stats.h"

void print_memory_info() { // FOR WHATEVER FUCKING REASON THE ARDUINO CRASHES IF THIS ISNT RUN?????????
    // Get stack statistics
    int cnt = osThreadGetCount();
    mbed_stats_stack_t *stats = (mbed_stats_stack_t*) malloc(cnt * sizeof(mbed_stats_stack_t));

    if (stats) {
        cnt = mbed_stats_stack_get_each(stats, cnt);
        for (int i = 0; i < cnt; i++) {
            Serial.print("Thread: 0x");
            Serial.print((unsigned long)stats[i].thread_id, HEX);
            Serial.print(", Stack size: ");
            Serial.print(stats[i].max_size);
            Serial.print(" / ");
            Serial.println(stats[i].reserved_size);
        }
        free(stats);
    }

    // Get heap statistics
    mbed_stats_heap_t heap_stats;
    mbed_stats_heap_get(&heap_stats);
    
    Serial.print("Heap usage: ");
    Serial.print(heap_stats.current_size);
    Serial.print(" / ");
    Serial.print(heap_stats.reserved_size);
    Serial.println(" bytes");
}


const int numSamples = 50;

int samplesRead = 0;

BLEService movementService("180F");



BLEUnsignedCharCharacteristic positionChar("2A19",
    BLERead | BLENotify);

// pull in all the TFLM ops, you can remove this line and
// only pull in the TFLM ops you need, if would like to reduce
// the compiled size of the sketch.
tflite::AllOpsResolver tflOpsResolver;

const tflite::Model* tflModel = nullptr;
tflite::MicroInterpreter* tflInterpreter = nullptr;
TfLiteTensor* tflInputTensor = nullptr;
TfLiteTensor* tflOutputTensor = nullptr;

// Create a static memory buffer for TFLM, the size may need to
// be adjusted based on the model you are using
constexpr int tensorArenaSize = 8 * 1024;
byte tensorArena[tensorArenaSize] __attribute__((aligned(16)));

// array to map gesture index to a name
const char* GESTURES[] = {
  "rest",
  "bicep_in_lab",
  "topPos",
  "other_but_still"
};

#define NUM_GESTURES (sizeof(GESTURES) / sizeof(GESTURES[0]))

void setup() {
  Serial.begin(9600);
  while (!Serial);

  // initialize the IMU
  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (1);
  }

  if (!BLE.begin()) {
    Serial.println("starting BLE failed!");

    while (1);
  }

  BLE.setLocalName("Team2Arduino");
  BLE.setAdvertisedService(movementService);
  movementService.addCharacteristic(positionChar);
  BLE.addService(movementService);
  positionChar.writeValue(2);


  BLE.advertise();

  // print out the samples rates of the IMUs
  Serial.print("Accelerometer sample rate = ");
  Serial.print(IMU.accelerationSampleRate());
  Serial.println(" Hz");

  Serial.println();

  // get the TFL representation of the model byte array
  tflModel = tflite::GetModel(model);
  if (tflModel->version() != TFLITE_SCHEMA_VERSION) {
    Serial.println("Model schema mismatch!");
    return;
  }

  
  // Create an interpreter to run the model
  tflInterpreter = new tflite::MicroInterpreter(tflModel, tflOpsResolver, tensorArena, tensorArenaSize);

  

  // Allocate memory from the tensor_arena for the model's tensors.
  TfLiteStatus allocate_status = tflInterpreter->AllocateTensors();
  if (allocate_status != kTfLiteOk) {
    MicroPrintf("AllocateTensors() failed");
    return;
  }

  

  // Get pointers for the model's input and output tensors
  tflInputTensor = tflInterpreter->input(0);
  tflOutputTensor = tflInterpreter->output(0);

  
}

void loop() {
  float aX, aY, aZ;
  int gestureVal;

  



  if (samplesRead < numSamples) {
    // check if new acceleration data is available
    if (IMU.accelerationAvailable()) {
      // read the acceleration
      IMU.readAcceleration(aX, aY, aZ);

      // normalize the IMU data between 0 to 1 and store in the model's
      // input tensor
      tflInputTensor->data.f[samplesRead * 3 + 0] = aX;
      tflInputTensor->data.f[samplesRead * 3 + 1] = aY;
      tflInputTensor->data.f[samplesRead * 3 + 2] = aZ;
      samplesRead++;
    }
  }

  

  if (samplesRead == numSamples) {

    // Run inferencing
    print_memory_info();
    TfLiteStatus invokeStatus = tflInterpreter->Invoke();
    if (invokeStatus != kTfLiteOk) {
      Serial.println("Invoke failed!");
      while (1);
      return;
    }

 

    BLEDevice central = BLE.central();


    // Loop through the output tensor values from the model
    for (int i = 0; i < NUM_GESTURES; i++) {
      Serial.print(GESTURES[i]);
      Serial.print(": ");
      Serial.println(tflOutputTensor->data.f[i], 6);

      if (central) {
        Serial.print("Connected to central:");
        Serial.println(central.address());
        digitalWrite(LED_BUILTIN, HIGH);

        if (tflOutputTensor->data.f[i] > 0.9){
          if (i == 0 ){
            positionChar.writeValue(1);
            Serial.println("written 1 to ble");
          }
          if (i==2){
            positionChar.writeValue(2);
            Serial.println("written 2 to ble");
          }
          
        } 
      }
    
    }

    

    // Clean up the data buffer before filling up for the next batch.
    int i = 0;
    for (; i< numSamples; i ++) {
      tflInputTensor->data.f[i * 3 + 0];
    }

    Serial.println();
    samplesRead = 0;
  }
}





