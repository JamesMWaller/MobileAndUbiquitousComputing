import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Bluetooth/my_bluetooth_service.dart';
import 'settings/theme_provider.dart'; // Adjust path as needed

class ArduinoDataDisplay extends StatefulWidget {
  const ArduinoDataDisplay({Key? key}) : super(key: key);

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
      var rawData =
          await _bluetoothService.gestureCharacteristic?.read() ?? [0];
      setState(() {
        gestureValue = rawData[0];
      });
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  @override
  void dispose() {
    _bluetoothService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode from the provider
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Container(
        decoration: isDarkMode
            ? const BoxDecoration(color: Colors.black)
            : const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: _buildDataCard(
              "Gesture Value",
              "$gestureValue",
              cardColor: isDarkMode ? const Color(0xFFBFFF5A) : Colors.white,
              textColor: isDarkMode ? Colors.black : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard(
    String title,
    String value, {
    Color cardColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    return Card(
      elevation: 4,
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: textColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
