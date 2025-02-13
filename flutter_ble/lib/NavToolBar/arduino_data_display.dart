import 'package:flutter/material.dart';
import '../Bluetooth/my_bluetooth_service.dart';
class ArduinoDataDisplay extends StatefulWidget {
  const ArduinoDataDisplay({super.key});
  @override
  _ArduinoDataDisplayState createState() => _ArduinoDataDisplayState();
}
class _ArduinoDataDisplayState extends State<ArduinoDataDisplay> {
  final MyBluetoothService _bluetoothService = MyBluetoothService();
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  @override
  void initState() {
    super.initState();
    _bluetoothService.connectToDevice().then((connected) {
      if (connected) {
        _updateSensorData();
      }
    });
  }
  Future<void> _updateSensorData() async {
    while (mounted) {
      String gravityDirection = await _bluetoothService.getGravityDirection();
      var xRaw = await _bluetoothService.xCharacteristic?.read() ?? [0];
      var yRaw = await _bluetoothService.yCharacteristic?.read() ?? [0];
      var zRaw = await _bluetoothService.zCharacteristic?.read() ?? [0];
      setState(() {
        x = xRaw[0].toDouble();
        y = yRaw[0].toDouble();
        z = zRaw[0].toDouble();
      });
      await Future.delayed(const Duration(seconds: 1));
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
        title: const Text("Datos del Arduino"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataCard("Axes", "X: $x | Y: $y | Z: $z"),
            StreamBuilder<String>(
              stream: _bluetoothService.gravityDirectionStream,
              builder: (context, snapshot) {
                String gravityDirection = snapshot.data ?? "Loading...";
                return _buildDataCard("Gyroscope", gravityDirection);
              },
            ),
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