import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MuscleGroupsScreen(),
    );
  }
}

class MuscleGroupsScreen extends StatelessWidget {
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
                  Icon(Icons.arrow_back_ios_new, color: Colors.green, size: 20), // Thin iOS-style back button
                  SizedBox(width: 5),
                  Text(
                    "Exercises",
                    style: TextStyle(
                      fontFamily: "SFPro",
                      color: Colors.green,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Currently creating a routine for Intermediates, using no equipment. Tap to change.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                  child: Text('Full Body', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                  child: Text('Upper Body', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  MuscleGroupButton('Abdominal', Colors.green),
                  MuscleGroupButton('Back', Colors.grey.shade800),
                  MuscleGroupButton('Biceps', Colors.green),
                  MuscleGroupButton('Lateral Muscles', Colors.grey.shade800),
                  MuscleGroupButton('Pectoral Muscles', Colors.grey.shade800),
                  MuscleGroupButton('Hamstrings', Colors.grey.shade800),
                  // Add more muscle groups as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MuscleGroupButton extends StatelessWidget {
  final String title;
  final Color color;

  MuscleGroupButton(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Adjust this value to control the rounding
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
