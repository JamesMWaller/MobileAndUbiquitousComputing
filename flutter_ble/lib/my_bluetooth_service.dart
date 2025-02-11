import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;

class MyBluetoothService {
  static final MyBluetoothService _instance = MyBluetoothService._internal();
  factory MyBluetoothService() => _instance;

  MyBluetoothService._internal();

  final String targetDeviceName = "Team2Arduino";

  fbp.BluetoothDevice? _device;
  List<fbp.BluetoothService> _services = [];
  fbp.BluetoothCharacteristic? _xCharacteristic;
  fbp.BluetoothCharacteristic? _yCharacteristic;
  fbp.BluetoothCharacteristic? _zCharacteristic;

  final StreamController<String> _gravityStreamController = StreamController<String>.broadcast();

  Stream<String> get gravityDirectionStream => _gravityStreamController.stream;

  Timer? _gravityTimer;

  bool get isConnected => _device != null && _xCharacteristic != null && _yCharacteristic != null && _zCharacteristic != null;

  Future<bool> connectToDevice() async {
    var subscription = fbp.FlutterBluePlus.onScanResults.listen(
          (results) async {
        for (fbp.ScanResult result in results) {
          if (result.device.platformName == targetDeviceName) {
            fbp.FlutterBluePlus.stopScan();
            try {
              await result.device.connect();
              _services = await result.device.discoverServices();
              _device = result.device;
              print("Connected to device");

              for (var service in _services) {
                for (var char in service.characteristics) {
                  if (char.uuid == fbp.Guid('2A19')) {
                    _xCharacteristic = char;
                  } else if (char.uuid == fbp.Guid('2A20')) {
                    _yCharacteristic = char;
                  } else if (char.uuid == fbp.Guid('2A21')) {
                    _zCharacteristic = char;
                  }
                }
              }

              if (isConnected) {
                startGravityUpdates();
              }

            } catch (e) {
              print("Error connecting: $e");
            }
          }
        }
      },
      onError: (e) => print("Scan Error: $e"),
    );

    fbp.FlutterBluePlus.cancelWhenScanComplete(subscription);
    await fbp.FlutterBluePlus.startScan();
    await Future.delayed(const Duration(seconds: 5));

    return isConnected;
  }

  Future<void> startGravityUpdates() async {
    while (true) {
      String direction = await getGravityDirection();
      _gravityStreamController.add(direction);
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<String> getGravityDirection() async {
    if (!isConnected) return "NaN";

    try {
      var xRaw = await _xCharacteristic!.read();
      var yRaw = await _yCharacteristic!.read();
      var zRaw = await _zCharacteristic!.read();

      double x = _convertRawData(xRaw);
      double y = _convertRawData(yRaw);
      double z = _convertRawData(zRaw);


      return _determineGravityDirection(x, y, z);
    } catch (e) {
      print("Error reading characteristics: $e");
      return "NaN";
    }
  }

  double _convertRawData(List<int> rawData) {
    if (rawData.isEmpty) return 0.0;
    return rawData[0].toDouble();  // Assuming single-byte integer values (modify if needed)
  }

  String _determineGravityDirection(double x, double y, double z) {

    double absX = x-40;
    double absY = y-40;
    double absZ = z-40;

    absX = absX.abs();
    absY = absY.abs();
    absZ = absZ.abs();


    if (absX > absY && absX > absZ) {
      return "X";
    } else if (absY > absX && absY > absZ) {
      return "Y";
    } else {
      return "Z";
    }
  }

  void dispose() {
    _gravityStreamController.close();
  }
}
