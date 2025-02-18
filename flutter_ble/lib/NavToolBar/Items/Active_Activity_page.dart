import 'package:flutter/material.dart';
import 'dart:async';
import 'Bicep_Curl_Details_Page.dart';

class RunningPage extends StatefulWidget {
  @override
  _RunningExercisePage createState() => _RunningExercisePage();
}

class _RunningExercisePage extends State<RunningPage> {
  bool toggle = true;
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Start the stopwatch when the page loads
    stopwatch.start();
    // Update the UI every second
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
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // reps, icon to start exercise, stop
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Repititions", style: TextStyle(fontSize: 30)),
            Text("0", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text("Duration", style: TextStyle(fontSize: 30),),
            Text(
              formattedDuration(),
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      toggle = !toggle;
                      if (toggle) {
                        stopwatch.start();
                      } else {
                        stopwatch.stop();
                      }
                    });
                  },
                  icon: toggle
                      ? Icon(Icons.pause_circle_outline, size: 50)
                      : Icon(Icons.play_circle_outline, color: Colors.green, size: 50),
                ),
                IconButton(
                  onPressed: () {
                    stopwatch.stop();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.stop_circle_outlined, color: Colors.red, size: 50),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
