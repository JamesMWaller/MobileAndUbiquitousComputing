import 'package:flutter/material.dart';
import 'dart:async';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  bool isRunning = true;
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  int repetitions = 0;
  Color backgroundColor = Colors.black;

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formattedDuration() {
    final duration = stopwatch.elapsed;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Good Technique!",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFBFFF5A),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(0.4),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: Text(
                        "Time: ${formattedDuration()}",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: repetitions / 10),
                      duration: Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        return CircularProgressIndicator(
                          value: value,
                          backgroundColor: Colors.grey.shade700,
                          color: Colors.greenAccent,
                          strokeWidth: 10,
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Repetitions: $repetitions",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Center(
                child: Container(
                  width: 180,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFBFFF5A),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isRunning = !isRunning;
                            isRunning ? stopwatch.start() : stopwatch.stop();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Icon(
                            isRunning ? Icons.pause : Icons.play_arrow,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          stopwatch.reset();
                          setState(() {
                            repetitions = 0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Icon(
                            Icons.stop,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
