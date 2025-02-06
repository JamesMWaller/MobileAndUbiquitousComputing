import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

// Import the welcome page
import 'home_page.dart';

void main() => runApp(const MyApp());

const String TARGET_DEVICE_NAME =
    "Team2Arduino"; // Change this to your device's name

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'BLE Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // On reload, this sends the user to the welcome page defined in home_page.dart
        home: const HomePage(),
      );
}
