import 'package:flutter/material.dart';
import '../../Bluetooth/my_bluetooth_service.dart';

class ArduinoDataDisplay extends StatefulWidget {
  const ArduinoDataDisplay({super.key});

  @override
  _ArduinoDataDisplayState createState() => _ArduinoDataDisplayState();
}

class _ArduinoDataDisplayState extends State<ArduinoDataDisplay> {
  final MyBluetoothService _bluetoothService = MyBluetoothService();
  int gestureValue = 0;

  @override
  void initState() {
    super.initState();
    _bluetoothService.connectToDevice().then((connected) {
      if (connected) {
        _updateGestureData();
      }
    });
  }

  Future<void> _updateGestureData() async {
    while (mounted) {
      var rawData = await _bluetoothService.gestureCharacteristic?.read() ?? [0];
      setState(() {
        gestureValue = rawData[0];
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
          child: Center(
            child: _buildDataCard(
              "Gesture Value",
              "Value: $gestureValue",
              icon: Icons.touch_app,
              cardColor: Colors.blue.shade200,
            ),
          ),
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