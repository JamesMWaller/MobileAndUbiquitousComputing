import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import '../../Bluetooth/my_bluetooth_service.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  bool isRunning = true;
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  int repetitions = 0;
  final Stopwatch repStopwatch = Stopwatch();

  int arduinoVariable = 0;

  final MyBluetoothService _bluetoothService = MyBluetoothService();
  int gestureValue = 0;
  bool topOfRep = false;
  String currentRepQuality = "Start Curling";

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    repStopwatch.start();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
    _bluetoothService.connectToDevice().then((connected) {
      if (connected) {
        _updateGestureData();
      }
    });
  }

  Future<void> _updateGestureData() async {
    while (mounted) {
      var rawData = await _bluetoothService.gestureCharacteristic?.read() ?? [0];
      setState(() {
        gestureValue = rawData[0];
      });
      await Future.delayed(const Duration(milliseconds: 200));

    }
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


  String evaluateRep() {

    Random random = Random();
    int time = 0;

    _updateGestureData();

    int position = gestureValue;

    if (position == 2){
      topOfRep = true;
    }

    if (topOfRep && position == 1){

      time = repStopwatch.elapsedMilliseconds;

      repStopwatch.reset();

      topOfRep = false;
      repetitions+=1;
      if (time >= 3000 ) {
        currentRepQuality =  "Good rep";
      } else if (time >= 2000 ) {
        currentRepQuality = "Regular rep";
      } else {
        currentRepQuality =  "Bad rep";
      }
    }

    // 0: bottom, 1: top, 2: undecided

   // 0: unstable, 1: regular, 2: stable

    print("Posición: $position, Tiempo: $time, topOfRep: $topOfRep");




    return currentRepQuality;


  }

  int rep(){
    if(evaluateRep() == 'Good rep'){
      return 2;
    }else if(evaluateRep() == 'Regular rep'){
      return 1;
    }else{
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                      evaluateRep(),
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
