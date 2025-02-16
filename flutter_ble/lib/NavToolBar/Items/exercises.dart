import 'package:flutter/material.dart';
import 'package:animated_appbar/animated_appbar.dart';
import 'package:flutter_ble/NavToolBar/Items/LatRaisesDetailsPage.dart';
import 'BicepCurlDetailsPage.dart';

class Exercises extends StatelessWidget with RoutePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercises")),
      body:
      Column(
        children: [
          ExerciseCard(
            title: "Bicep Curl",
            goal: "8/10",
            image: ImgSample.get("bicep_curl_photo.gif"),
            progress: 0.7,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage()));
            },

          ),
          ExerciseCard(
            title: "Lat Raises",
            goal: "10/10",
            image: ImgSample.get("dumbell_curl_photo.gif"),
            progress: 1.0,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LatDetailsPage()));
            },
          ),
        ],
      ),
    );
  }
}


class RunningExercisePage extends StatelessWidget with RoutePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // reps, icon to start exericse, stop
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(onPressed: ,
            //     icon: Icon(Icons.pause_circle_outline, color: Colors.white, size: 24,))
            Text(
              "Bicep Curl",
              style: TextStyle(fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String title;
  final String goal;
  final String image;
  final double progress;
  final VoidCallback onTap;

  ExerciseCard({
    required this.title,
    required this.goal,
    required this.image,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(image, height: 100, width: 100, fit: BoxFit.cover),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.grey[800]),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Goal: $goal",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.grey[500]),
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      minHeight: 8.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImgSample {
  static String get(String imageName) {
    return 'assets/$imageName';
  }
}
