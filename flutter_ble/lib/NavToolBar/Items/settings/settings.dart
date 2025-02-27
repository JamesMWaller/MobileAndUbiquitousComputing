import 'package:flutter/material.dart';
import 'package:flutter_ble/welcomepage.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    // Define the green box color and text styles for dark mode.
    final Color greenBoxColor = Color(0xFFBFFF5A);
    final TextStyle boxTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    final TextStyle boxSubtitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    // Helper to wrap each field based on the theme.
    Widget buildField(Widget child) {
      if (isDarkMode) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: greenBoxColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: child,
        );
      } else {
        return Column(
          children: [
            child,
            Divider(),
          ],
        );
      }
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          // Profile Header Section remains unchanged.
          SizedBox(
            height: 90,
          ),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: isDarkMode ? Colors.green : Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "jun",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "xxxxxx@student.bham.ac.uk",
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? Colors.white70 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Additional Profile Information
          buildField(
            ListTile(
              leading: Icon(Icons.phone,
                  color: isDarkMode ? Colors.black : Colors.grey),
              title: Text("Phone Number",
                  style: isDarkMode
                      ? boxTitleStyle
                      : TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("+44 123 456 7890",
                  style: isDarkMode ? boxSubtitleStyle : TextStyle()),
            ),
          ),
          buildField(
            ListTile(
              leading: Icon(Icons.cake,
                  color: isDarkMode ? Colors.black : Colors.grey),
              title: Text("Birthday",
                  style: isDarkMode
                      ? boxTitleStyle
                      : TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("January 1, 1990",
                  style: isDarkMode ? boxSubtitleStyle : TextStyle()),
            ),
          ),
          buildField(
            ListTile(
              leading: Icon(Icons.location_on,
                  color: isDarkMode ? Colors.black : Colors.grey),
              title: Text("Location",
                  style: isDarkMode
                      ? boxTitleStyle
                      : TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Birmingham, UK",
                  style: isDarkMode ? boxSubtitleStyle : TextStyle()),
            ),
          ),
          buildField(
            ListTile(
              leading: Icon(Icons.lock,
                  color: isDarkMode ? Colors.black : Colors.grey),
              title: Text("Contact Support",
                  style: isDarkMode
                      ? boxTitleStyle
                      : TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // Add functionality for contacting support.
              },
            ),
          ),
          // App Settings Section
          buildField(
            ListTile(
              leading: Icon(Icons.dark_mode,
                  color: isDarkMode ? Colors.black : Colors.grey),
              title: Text("Dark Mode",
                  style: isDarkMode
                      ? boxTitleStyle
                      : TextStyle(fontWeight: FontWeight.bold)),
              trailing: Switch(
                value: isDarkMode,
                activeColor: Colors.green,
                inactiveThumbColor: Colors.grey,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
          ),
          buildField(
            ListTile(
              leading: Icon(Icons.lock,
                  color: isDarkMode ? Colors.black : Colors.grey),
              title: Text("Change Password",
                  style: isDarkMode
                      ? boxTitleStyle
                      : TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // Add functionality for changing password.
              },
            ),
          ),
          buildField(
            ListTile(
              leading: Icon(Icons.info,
                  color: isDarkMode ? Colors.black : Colors.grey),
              title: Text("App Version",
                  style: isDarkMode
                      ? boxTitleStyle
                      : TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("v1.0.0",
                  style: isDarkMode ? boxSubtitleStyle : TextStyle()),
            ),
          ),
          buildField(
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout",
                  style: isDarkMode
                      ? boxTitleStyle.copyWith(color: Colors.red)
                      : TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
