import 'package:flutter/material.dart';
import 'package:flutter_ble/welcomepage.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'NavToolBar/Items/settings/settings.dart';
import 'NavToolBar/Items/settings/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: WelcomeScreen(),
    );
  }
}
