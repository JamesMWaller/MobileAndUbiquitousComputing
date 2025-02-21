import 'package:flutter/material.dart';
import 'package:flutter_ble/sign_up_page.dart';
import 'NavToolBar/Items/exercises.dart';
import 'Bluetooth/my_bluetooth_service.dart';
import 'NavToolBar/Items/arduino_data_display.dart';
import 'NavToolBar/bottom_nav_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MyBluetoothService _bluetoothService = MyBluetoothService();

  @override
  void initState() {
    super.initState();
    _bluetoothService.connectToDevice();
  }

  @override
  void dispose() {
    _bluetoothService.dispose();
    super.dispose();
  }

  void _navigateToExercises() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600), // Increased duration
        pageBuilder: (context, animation, secondaryAnimation) => BottomNavBar(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'GYM HELPER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _navigateToExercises,
              child: Hero(
                tag: 'exerciseAvatar',
                child: const CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.fitness_center_rounded,
                    size: 150,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Click Here To Continue!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: StreamBuilder<String>(
                stream: _bluetoothService.gravityDirectionStream,
                builder: (context, snapshot) {
                  String gravityText =
                  snapshot.hasData ? snapshot.data! : "Loading...";
                  return Text(
                    'Vertical Axis: $gravityText',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ArduinoDataDisplay()));
              },
              child: const Text('Variables data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUpPage()));
              },
              child: const Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
