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

  void _navigateToExercises() {
    Navigator.of(context).pushReplacement(
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

  void _showProfilePictureDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _profileImage != null
                ? Image.file(_profileImage!, height: 100)
                : Icon(Icons.account_circle, size: 100, color: Colors.grey),
            SizedBox(height: 10),
            TextButton(
              onPressed: _pickImage,
              child: Text("Choose from Gallery"),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: (){
               _navigateToExercises();
            },
            child: Text("Done"),
          )
        ],
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match!")),
        );
        return;
      }
      _showProfilePictureDialog();
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign Up',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'SFPro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  // color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        floatingLabelStyle: TextStyle(color: Color(0xFFBFFF5A)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFBFFF5A)),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty || !value.contains("@") ? "Enter a valid email" : null,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        floatingLabelStyle: TextStyle(color: Color(0xFFBFFF5A)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFBFFF5A)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });},
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        floatingLabelStyle: TextStyle(color: Color(0xFFBFFF5A)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFBFFF5A)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
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
                    SizedBox(height: 55),
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFBFFF5A), // Set the background color to green
                      ),
                        child: Container(
                        width: 250,
                        child: Center(
                          child: Text("Sign Up", style: TextStyle(
                            color: Colors.black,
                            ),
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        )
      ),
    );
  }
}
