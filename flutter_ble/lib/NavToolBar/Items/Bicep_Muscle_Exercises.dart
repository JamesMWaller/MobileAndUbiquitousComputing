import 'package:flutter/material.dart';
import 'package:flutter_ble/NavToolBar/Items/Bicep_Curl_Details_Page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BicepExercisesScreen(),
    );
  }
}

class BicepExercisesScreen extends StatelessWidget {
  final List<String> exercises = [
    'Bicep Curl',
    'Hammer Curl',
    'Concentration Curl',
    'Preacher Curl',
    'Cable Rope Curl',
    'Incline Dumbbell Curl',
    'Zottman Curl',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFFBFFF5A)
                    : Colors.black,
                size: 20,
              ),
              SizedBox(width: 5),
              Text(
                "Muscle Groups",
                style: TextStyle(
                  fontFamily: "SFPro",
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFFBFFF5A)
                      : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
              'Bicep Exercises',
              style: TextStyle(
                fontFamily: "SFPro",
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFFBFFF5A)
                    : Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Choose an exercise to learn more about its form and benefits.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: exercises.map((exercise) {
                  return ExerciseButton(exercise);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseButton extends StatelessWidget {
  final String title;

  ExerciseButton(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (title == 'Bicep Curl') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsPage()),
            );
          } else {
            // Handle other exercises if needed
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFBFFF5A),
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
