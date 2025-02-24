import 'package:flutter/material.dart';

class DailyWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Set the background color to green
        title: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white), // Thin iOS-style back button
                SizedBox(width: 5),
                Text(
                  "Exercises",
                  style: TextStyle(
                    fontFamily: "SFPro",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:  Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: 44,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.green, // Green background color
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Workout',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text color for better contrast
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (String day in ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
                      Column(
                        children: [
                          Text(day, style: TextStyle(color: Colors.white)),
                          // Example highlight for the current day
                          if (day == 'M')
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding from the sides
              child: Container(
                margin: const EdgeInsets.only(top: 16.0),
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _buildExerciseTile('V-sit', '30 Sec'),
                    _buildExerciseTile('Crossover Crunch', 'x15'),
                    _buildExerciseTile('REST', ''),
                    _buildExerciseTile('Crunch', 'x20'),
                    _buildExerciseTile('Flutter Kick', 'x30'),
                    _buildExerciseTile('REST', ''),
                    _buildExerciseTile('Heel Touch', ''),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseTile(String exercise, String reps) {
    return ListTile(
      title: Text(exercise),
      subtitle: Text(reps),
      trailing: Icon(Icons.check_circle_outline),
    );
  }
}

void main() => runApp(MaterialApp(
  home: DailyWorkoutPage(),
));
