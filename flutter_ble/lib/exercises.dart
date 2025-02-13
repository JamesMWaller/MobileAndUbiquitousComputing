import 'package:flutter/material.dart';
import 'package:animated_appbar/animated_appbar.dart';
import 'home_page.dart';
class Exercises extends StatelessWidget with RoutePage {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: AnimatedAppBar(
        initHeight: 135.0,
        backgroundColor: Color(0xff7a7ad1),
        child: Container(
          key: UniqueKey(),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 600), // Same duration as forward transition
                        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                Text(
                  "Exercises",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                Hero(
                  tag: 'exerciseAvatar',
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.fitness_center_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(padding: EdgeInsets.only(top: 150),
        child: Column(
          children: [
            ExerciseCard(
              title: "Bicep Curl",
              goal: "8/10",
              image: ImgSample.get("bicep_curl_photo.gif"),
              progress: 0.7,
              onTap: () => routePageWithNewAppBar(DetailsPage(), newAppBar()),
            ),
            ExerciseCard(
              title: "Dumbbell Curl",
              goal: "10/10",
              image: ImgSample.get("dumbell_curl_photo.gif"),
              progress: 1.0,
              onTap: () => routePageWithNewAppBar(DetailsPage(), newAppBar()),
            ),
            ExerciseCard(
              title: "Hammer Curl",
              goal: "5/10",
              image: ImgSample.get("hammer_curl_photo.gif"),
              progress: 0.5,
              onTap: () => routePageWithNewAppBar(DetailsPage(), newAppBar()),
            ),
          ],
        ),)
      ),
    );
  }

  Widget newAppBar() {
    return Container(
      key: UniqueKey(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
            onPressed: () =>  previousPage(),
          ),
          Text(
            "Exercise Details",
            style: TextStyle(color: Color(0xfff7f4cc), fontSize: 20),
          ),
          Icon(Icons.settings, color: Colors.white, size: 24.0),
        ],
      )
    );
  }
}

class DetailsPage extends StatelessWidget with RoutePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Exercise Details",
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
