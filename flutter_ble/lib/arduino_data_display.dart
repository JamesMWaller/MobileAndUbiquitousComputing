import 'package:flutter/material.dart';
import 'my_bluetooth_service.dart';

class ArduinoDataDisplay extends StatefulWidget {
  const ArduinoDataDisplay({super.key});

  @override
  _ArduinoDataDisplayState createState() => _ArduinoDataDisplayState();
}

class _ArduinoDataDisplayState extends State<ArduinoDataDisplay> {
  final MyBluetoothService _bluetoothService = MyBluetoothService();

  double x = 0.0, y = 0.0, z = 0.0;
  double gyroX = 0.0, gyroY = 0.0, gyroZ = 0.0;
  double roll = 0.0, pitch = 0.0;

  @override
  void initState() {
    super.initState();
    _bluetoothService.connectToDevice().then((connected) {
      if (connected) _updateSensorData();
    });
  }

  Future<void> _updateSensorData() async {
    while (mounted) {
      var xRaw = await _bluetoothService.xCharacteristic?.read() ?? [0];
      var yRaw = await _bluetoothService.yCharacteristic?.read() ?? [0];
      var zRaw = await _bluetoothService.zCharacteristic?.read() ?? [0];
      var gyroXRaw = await _bluetoothService.gyroXCharacteristic?.read() ?? [0];
      var gyroYRaw = await _bluetoothService.gyroYCharacteristic?.read() ?? [0];
      var gyroZRaw = await _bluetoothService.gyroZCharacteristic?.read() ?? [0];
      var rollRaw = await _bluetoothService.rollCharacteristic?.read() ?? [0];
      var pitchRaw = await _bluetoothService.pitchCharacteristic?.read() ?? [0];

      setState(() {
        x = (xRaw[0] / 10.0) - 4; // Convertir a rango original
        y = (yRaw[0] / 10.0) - 4;
        z = (zRaw[0] / 10.0) - 4;
        gyroX = (gyroXRaw[0] - 128) / 10.0; // Convertir a valores correctos
        gyroY = (gyroYRaw[0] - 128) / 10.0;
        gyroZ = (gyroZRaw[0] - 128) / 10.0;
        roll = (rollRaw[0] * 2) - 180;  // Convertir a grados reales
        pitch = (pitchRaw[0] * 2) - 180;
      });

      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  void dispose() {
    _bluetoothService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datos del Arduino Nano 33 BLE"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataCard("Accelerometer", "X: $x m/s² | Y: $y m/s² | Z: $z m/s²"),
            _buildDataCard("Gyroscope", "GyroX: $gyroX°/s | GyroY: $gyroY°/s | GyroZ: $gyroZ°/s"),
            _buildDataCard("Angle", "Roll: $roll° | Pitch: $pitch°"),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
