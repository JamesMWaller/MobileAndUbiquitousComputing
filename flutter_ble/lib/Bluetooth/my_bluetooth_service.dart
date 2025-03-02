import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:permission_handler/permission_handler.dart';

class MyBluetoothService {
  static final MyBluetoothService _instance = MyBluetoothService._internal();
  factory MyBluetoothService() => _instance;

  MyBluetoothService._internal();

  final String targetDeviceName = "Team2Arduino";

  fbp.BluetoothDevice? _device;
  fbp.BluetoothCharacteristic? gestureCharacteristic;

  final StreamController<int> _gestureStreamController = StreamController<int>.broadcast();
  Stream<int> get gestureStream => _gestureStreamController.stream;

  bool get isConnected => _device != null && gestureCharacteristic != null;

  Future<bool> connectToDevice() async {
    print("Requesting permissions...");
    await _requestPermissions();

    print("Starting scan...");
    fbp.FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    // Listen for scan results
    var subscription = fbp.FlutterBluePlus.onScanResults.listen((results) async {
      for (fbp.ScanResult result in results) {
        print("Found device: ${result.device.platformName}");

        if (result.device.platformName == targetDeviceName) {
          print("Target device found! Stopping scan...");
          fbp.FlutterBluePlus.stopScan();

          try {
            await result.device.connect();
            _device = result.device;
            print("Connected to $targetDeviceName");

            // Discover services AFTER connecting
            await Future.delayed(const Duration(seconds: 2));
            List<fbp.BluetoothService> services = await _device!.discoverServices();

            for (var service in services) {
              for (var char in service.characteristics) {
                if (char.uuid == fbp.Guid('2A19')) {
                  gestureCharacteristic = char;
                  await gestureCharacteristic!.setNotifyValue(true);
                  print("Subscribed to gesture notifications");

                  // Listen for data

                }
              }
            }
          } catch (e) {
            print("Connection failed: $e");
          }
        }
      }
    });

    // Stop listening after scan completes
    fbp.FlutterBluePlus.cancelWhenScanComplete(subscription);

    // Wait for connection
    await Future.delayed(const Duration(seconds: 5));
    return isConnected;
  }

  Future<void> _requestPermissions() async {
    if (await Permission.bluetooth.isDenied) {
      await Permission.bluetooth.request();
    }
    if (await Permission.bluetoothScan.isDenied) {
      await Permission.bluetoothScan.request();
    }
    if (await Permission.bluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }


  void dispose() {
    _gestureStreamController.close();
  }
}
