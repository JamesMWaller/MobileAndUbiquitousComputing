import 'package:flutter/material.dart';
import 'package:flutter_ble/NavToolBar/Items/Bicep_Muscle_Exercises.dart';

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

class MuscleGroupsScreen extends StatefulWidget {
  @override
  _MuscleGroupsScreenState createState() => _MuscleGroupsScreenState();
}

class _MuscleGroupsScreenState extends State<MuscleGroupsScreen> {
  Map<String, bool> selectedMuscles = {
    'Abdominal Muscles': false,
    'Biceps': false,
    'Hamstrings': false,
    'Lateral Muscles': false,
    'Pectoral Muscles': false,
    'Trapezius Muscle': false,
    'Quadriceps': false,
  };

  void highlightMuscleGroup(String category) {
    setState(() {
      selectedMuscles.updateAll((key, value) => false);

      if (category == 'Full Body') {
        selectedMuscles.updateAll((key, value) => true);
      } else if (category == 'Upper Body') {
        selectedMuscles['Biceps'] = true;
        selectedMuscles['Pectoral Muscles'] = true;
        selectedMuscles['Trapezius Muscle'] = true;
      } else if (category == 'Core') {
        selectedMuscles['Abdominal Muscles'] = true;
        selectedMuscles['Lateral Muscles'] = true;
      } else if (category == 'Lower Body') {
        selectedMuscles['Hamstrings'] = true;
        selectedMuscles['Quadriceps'] = true;
      }
    });
  }

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
                "Home",
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
              'Select Your Workout Muscle Group',
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
              'Select a workout category to see general exercises for that region of the body. Alternatively, you can choose a specific muscle group for targeted exercises.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  categoryButton('Full Body'),
                  categoryButton('Upper Body'),
                  categoryButton('Core'),
                  categoryButton('Lower Body'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: selectedMuscles.keys.map((muscle) {
                  return MuscleGroupButton(
                    muscle,
                    selectedMuscles[muscle]! ? Color(0xFFBFFF5A) : Colors.grey.shade800,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () => highlightMuscleGroup(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
        ),
        child: Text(category, style: TextStyle(color: Colors.white)),
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
    Color textColor = (color == Color(0xFFBFFF5A)) ? Colors.black : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (title == 'Biceps') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BicepExercisesScreen()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: TextStyle(color: textColor, fontSize: 18)),
          ),
        ),
      ),
    );
  }
}