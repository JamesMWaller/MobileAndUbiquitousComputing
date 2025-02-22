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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _bluetoothService.connectToDevice();
  }

  @override
  void dispose() {
    _bluetoothService.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _idFocusNode.dispose();
    super.dispose();
  }

  void _navigateToExercises() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
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

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    setState(() {
      _errorMessage = null;  // 로그인 시 오류 메시지 초기화
    });

    if (username == "admin" && password == "password") {
      Future.delayed(Duration.zero, () {
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      });
    } else {
      setState(() {
        _errorMessage = "Check your ID or Password";
      });
    }
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.fitness_center_rounded,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  TextField(
                    controller: _usernameController,
                    focusNode: _idFocusNode,
                    decoration: InputDecoration(labelText: 'ID or Email'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        'Don\'t have an account? Sign up here',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ArduinoDataDisplay()));
                      },
                      child: Text(
                        'Variables data',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




