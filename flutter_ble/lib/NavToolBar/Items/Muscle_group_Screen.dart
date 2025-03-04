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
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).brightness == Brightness.dark ? Color(0xFFBFFF5A) : Colors.black,
                    size: 20,
                  ), // Thin iOS-style back button
                  SizedBox(width: 5),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontFamily: "SFPro",
                      color: Theme.of(context).brightness == Brightness.dark ? Color(0xFFBFFF5A) : Colors.black,
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
              'Select Your Workout Muscle Group',
              style: TextStyle(
                fontFamily: "SFPro",
                color: Theme.of(context).brightness == Brightness.dark ? Color(0xFFBFFF5A) : Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Select a workout category to see general exercises for that region of the body. Alternatively, you can choose a specific muscle group for targeted exercises."',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                    child: Text('Full Body', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 8), // Add space between buttons
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                    child: Text('Upper Body', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                    child: Text('Core', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                    child: Text('Lower Body', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  MuscleGroupButton('Abdominal Muscles', Color(0xFFBFFF5A)),
                  MuscleGroupButton('Biceps', Color(0xFFBFFF5A)),
                  MuscleGroupButton('Hamstrings', Colors.grey.shade800),
                  MuscleGroupButton('Lateral Muscles', Colors.grey.shade800),
                  MuscleGroupButton('Pectoral Muscles', Colors.grey.shade800),
                  MuscleGroupButton('Trapezius  Muscle', Colors.grey.shade800),
                  MuscleGroupButton('Quadriceps ', Colors.grey.shade800)
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
    // Determine the text color based on the button color
    Color textColor = (color == Color(0xFFBFFF5A)) ? Colors.black : Colors.white;

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
            child: Text(title, style: TextStyle(color: textColor, fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
