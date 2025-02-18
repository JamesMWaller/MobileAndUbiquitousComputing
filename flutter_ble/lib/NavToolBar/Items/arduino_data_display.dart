import 'package:flutter/material.dart';
import '../../Bluetooth/my_bluetooth_service.dart';

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
      // Read the gravity direction (even if you don't need to set it here)
      String gravityDirection = await _bluetoothService.getGravityDirection();

      // Read raw data from characteristics
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
        title: const Text("Arduino Data"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Real-time Sensor Values',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child:
                            _buildAxisCard("X-Axis", x, Icons.arrow_right_alt)),
                    const SizedBox(width: 8),
                    Expanded(
                        child: _buildAxisCard("Y-Axis", y, Icons.arrow_upward)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildAxisCard("Z-Axis", z, Icons.height)),
                  ],
                ),
                const SizedBox(height: 20),
                StreamBuilder<String>(
                  stream: _bluetoothService.gravityDirectionStream,
                  builder: (context, snapshot) {
                    String gravityDirection = snapshot.data ?? "Loading...";
                    return _buildDataCard(
                      "Gyroscope",
                      "Gravity Direction: $gravityDirection",
                      icon: Icons.rotate_right,
                      cardColor: Colors.blue.shade200,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAxisCard(String axisLabel, double value, IconData icon) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.blueAccent),
            const SizedBox(height: 6),
            Text(
              axisLabel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(
    String title,
    String value, {
    IconData? icon,
    Color cardColor = Colors.white,
  }) {
    return Card(
      elevation: 4,
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading:
            icon != null ? Icon(icon, size: 36, color: Colors.black87) : null,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
