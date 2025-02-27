import 'package:flutter/material.dart';
import 'package:flutter_ble/home_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'NavToolBar/bottom_nav_bar.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  File? _profileImage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match!")),
        );
        return;
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              child: Row(
                children:  [
                  SizedBox(width: 10),
                  Icon(Icons.arrow_back_ios_new, color: Color(0xFFBFFF5A), size: 20), // Thin iOS-style back button
                  SizedBox(width: 5),
                  Text(
                    "Sign in",
                    style: TextStyle(
                      fontFamily: "SFPro",
                      color: Color(0xFFBFFF5A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
        ),
        toolbarHeight: 44,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Hello! Register to get started",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                      value!.isEmpty || !value.contains("@") ? "Enter a valid email" : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureConfirmPassword,
                      validator: (value) => value!.isEmpty ? "Confirm your password" : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFBFFF5A),
                        foregroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text("Register"),
                    ),
                    SizedBox(height: 20),
                    Center(child: Text("Or Register with")),
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
                          icon: Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
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
                          "Already have an account? Login Now",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}