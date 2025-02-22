import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:flutter_ble/home_page.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text("Account"),
            subtitle: Text("Name: jun\nEmail: xxxxxx@student.bham.ac.uk"),
            onTap: () {
              // 계정 설정 화면으로 이동하는 코드 추가 가능
            },
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
                MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

