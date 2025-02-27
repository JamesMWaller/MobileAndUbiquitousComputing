import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_ble/home_page.dart';
import 'package:provider/provider.dart';
import 'Items/settings/settings.dart';
import 'Items/exercises.dart';
import 'Items/arduino_data_display.dart';
import 'Items/settings/theme_provider.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    Exercises(),
    ArduinoDataDisplay(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;


    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        key: _bottomNavigationKey,
        index: _page,
        items: <Widget>[
          Icon(
            Icons.home_filled,
            size: 30,
            color: _page == 0 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.science_rounded,
            size: 30,
            color: _page == 1 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: _page == 2 ? Colors.black : Colors.white,
          ),
        ],
        height: 55,
        buttonBackgroundColor: Color(0xFFA6E64F),
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _pages[_page],
    );

  }
}
