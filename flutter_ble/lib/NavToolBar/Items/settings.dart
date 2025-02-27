import 'package:flutter/material.dart';
import 'package:flutter_ble/welcomepage.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: isDarkMode ? Colors.green : Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "jun",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "xxxxxx@student.bham.ac.uk",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.dark_mode,
              color: isDarkMode ? Colors.green : Colors.grey,
            ),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: isDarkMode,
              activeColor: Colors.green, // Color when dark mode is enabled
              inactiveThumbColor:
                  Colors.grey, // Color when dark mode is disabled
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.green),
            title: Text("App version"),
            subtitle: Text("v.1.0.0"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout"),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
