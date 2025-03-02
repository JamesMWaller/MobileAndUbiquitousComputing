import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_ble/NavToolBar/Items/exercise_controlling_page.dart';
import 'package:url_launcher/url_launcher.dart';
class LatDetailsPage extends StatefulWidget {
  @override
  _LatDetailsPageState createState() => _LatDetailsPageState();
}

class _LatDetailsPageState extends State<LatDetailsPage> {
  String selectedValue = 'Days';
  final List<String> tips = [
    "Control the movement – Lower the weight slowly for max activation.",
    "Keep your elbows fixed – Prevent excessive shoulder movement.",
    "Use full range of motion – Extend fully at the bottom, squeeze at the top.",
    "Focus on mind-muscle connection – Let your biceps do the work!",
    "Mix up your routine – Try different curls like hammer or preacher curls."
  ];
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    // Detect brightness (light or dark mode)
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color containerColor = Color(0xFF23232C);
    Color textColor = isDarkMode ? Colors.black : Colors.white;
    return Scaffold(
        appBar: AppBar(title: Text("Lat Raises Activity")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width, // Adjust this value as needed
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFFBFFF5A) : Color(0xFF23232C),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // This will place items on opposite sides
                    children: [
                      Text(
                        "Start recording exercise",
                        style: TextStyle(
                          fontSize: 21,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ExercisePage()));
                        },
                        icon: Icon(Icons.play_circle, color: textColor, size: 40.0),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF23232C),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      //Text("You're this close to your daily goal ",),
                      Text(
                        "Lat Raises History",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'Days', label: Text('Days')),
                          ButtonSegment(value: 'Weeks', label: Text('Weeks')),
                          ButtonSegment(value: 'Months', label: Text('Months')),
                        ],
                        selected: {selectedValue},
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            selectedValue = newSelection.first;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => states.contains(MaterialState.selected)
                                ? Colors.white
                                : Color(0xFFBFFF5A),
                          ),
                          foregroundColor: MaterialStateProperty.resolveWith(
                                (states) => states.contains(MaterialState.selected)
                                ? Colors.black
                                : Colors.black,

                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildGraph(selectedValue),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 400,
                  height: 200, // Adjust this based on content
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: tips.length,
                    scrollDirection: Axis.horizontal, // Swipe horizontally
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adds spacing between cards
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Color(0xFFBFFF5A)
                                :Color(0xFF23232C),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Useful Tip- Swipe",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                tips[index], // Swipe changes this text
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: textColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              // This remains static
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: containerColor,
                    // color: Color(0xFFFF00FF),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text('Additional Links',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildHelpfulLinks(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        )

    );
  }
  Widget _buildHelpfulLinks() {
    return Column(
      children: [

        _buildLink("How to Master Lateral Raises: Form, Technique, & Benefits", "https://www.onepeloton.com/blog/lateral-raises"),
        _buildLink("Stop Doing Lateral Raises Like This! (8 MISTAKES)", "https://www.youtube.com/watch?v=K5hFLVJnnsw"),
        _buildLink("Lateral Raise", "https://www.youtube.com/watch?v=OuG1smZTsQQ"),
        _buildLink("Why Your Biceps Won't Grow", "https://www.muscleandstrength.com/articles/top-10-biceps-mistakes"),
      ],
    );
  }
  Widget _buildLink(String text, String url) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color textColor =  Colors.white;
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                    fontSize: 16,
                    height: 1.55,
                    color: textColor
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      decoration: TextDecoration.underline,
                      decorationColor: textColor,
                    ),
                  ),
              ),
            ],
          )
      ),
    );
  }
  Widget _buildGraph(String timeFrame) {
    List<int> data = _getDataForTimeFrame(timeFrame);

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,

          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  List<String> labels = _getLabelsForTimeFrame(timeFrame);
                  return Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      labels[value.toInt()],
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  );
                },
                reservedSize: 20,
              ),
            ),
          ),
          barGroups: data.asMap().entries.map((entry) {
            int index = entry.key;
            int value = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value.toDouble(),
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Color(0xFFBFFF5A),
                  width: 16,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            );
          }).toList(),
          barTouchData: BarTouchData(enabled: true),
        ),
        swapAnimationDuration: Duration(milliseconds: 1000), // Animation duration
        swapAnimationCurve: Curves.easeInOut,
      ),
    );
  }
  List<int> _getDataForTimeFrame(String timeFrame) {
    if (timeFrame == 'Days') return [10, 12, 8, 15, 20, 18, 22]; // Hourly reps
    if (timeFrame == 'Weeks') return [50, 60, 70, 80, 90, 75, 85]; // Daily reps
    return [300, 320, 290, 400, 370, 390, 410 ]; // Weekly reps in a month
  }

  List<String> _getLabelsForTimeFrame(String timeFrame) {
    if (timeFrame == 'Days') return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (timeFrame == 'Weeks') return ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7'];
    return ['J', 'F', 'M', 'A', 'M', 'J', 'J', ];
  }
}
