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
      _errorMessage = null;
    });

    if (username.isEmpty) {
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
        title: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.arrow_back_ios_new, color: Color(0xFFBFFF5A), size: 20),
                SizedBox(width: 5),
                Text(
                  "Welcome Screen",
                  style: TextStyle(
                    fontFamily: "SFPro",
                    color: Color(0xFFBFFF5A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
        toolbarHeight: 44,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView( 
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                SizedBox(height: 20),
                Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  focusNode: _idFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFBFFF5A),
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                Center(child: Text("Or Login with")),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.facebook, color: Colors.blue, size: 40),
                      onPressed: () {},
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Image.asset(
                        'assets/images/google_logo.png',
                        fit: BoxFit.cover,
                        height: 40,
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.apple, size: 40,),
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Don't have an account? Register Now",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
