import 'package:flutter/material.dart';
import 'package:flutter_ble/NavToolBar/Items/Lateral_Raises_Details_Page.dart';
import 'package:flutter_ble/NavToolBar/Items/Muscle_group_Screen.dart';
import 'package:flutter_ble/NavToolBar/Items/daily_workout_page.dart';
import 'Bicep_Curl_Details_Page.dart';

class Exercises extends StatelessWidget  {
  final TextEditingController _searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('Hi Jun,',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
         Text("Lets get Exercising",
           style: TextStyle(
             fontSize: 26,
             fontWeight: FontWeight.w700,
           ),
         )
        ],),
        toolbarHeight: 100,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 30),

            Container(
              padding: EdgeInsets.all(15),
              // height: 70,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for an exercise',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ?  Colors.white:Colors.black,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark ?  Colors.black:Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xFFBFFF5A),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xFFBFFF5A),
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: Color(0xFFBFFF5A),
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Change input text color based on theme
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("Today's Workout Plan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            ExerciseCard(
              title: "Bicep Curl",
              goal: "8/10",
              image: ImgSample.get("Biceps_curl_exercise.jpg"),
              progress: 0.7,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsPage()));
              },

            ),
            ExerciseCard(
              title: "Lateral Raises",
              goal: "10/10",
              image: ImgSample.get("lateral_raises_photo.png"),
              progress: 1.0,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LatDetailsPage()));
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15.0), // Adjust the padding value as needed
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('More Exercises',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: (){
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => MuscleGroupsScreen()),
            //           );
            //         },
            //         child: Text('See all',
            //           style: TextStyle(
            //             color: Color(0xFFBFFF5A),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFBFFF5A), // Set the background color to green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Adjust this value to change the roundness
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DailyWorkoutPage(),
                      ),
                    );
                  },
                  child: Container(
                    // width: 250,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Set Today\'s Daily Workout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFBFFF5A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the page with more exercises or muscle groups
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MuscleGroupsScreen()),
                    );
                  },
                  child: Container(
                    // width: double.infinity,  // Set the width to double.infinity
                    height: 50,
                    child: Center(
                      child: Text(
                        'View More Exercises',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //       SingleChildScrollView(
      //         scrollDirection: Axis.horizontal,
      //         padding: EdgeInsets.symmetric(horizontal: 15),
      //         child: Row(
      //           children: [
      //             Container(
      //               width: 125,
      //               height: 150,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12),
      //                 color: Colors.black,
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color:Colors.white.withOpacity(0.25),
      //                     spreadRadius: 1,
      //                     blurRadius: 8,
      //                     offset: Offset(0, 4), // changes the position of the shadow
      //                   ),
      //                 ],
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Image.asset(ImgSample.get("Abdominal_Muscles.png"), width: 100, height: 100, fit: BoxFit.contain,),
      //                   Text(
      //                     'Abs',
      //                     style: TextStyle(
      //                         color: Color(0xFFBFFF5A),
      //                         fontSize: 18
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //
      //             const SizedBox(width: 10), // Add spacing between containers
      //             Container(
      //               width: 125,
      //               height: 150,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12),
      //                 color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.25) : Colors.black.withOpacity(0.25),
      //                     spreadRadius: 1,
      //                     blurRadius: 8,
      //                     offset: Offset(0, 4), // changes the position of the shadow
      //                   ),
      //                 ],
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Image.asset(ImgSample.get("Hamstrings_Muscle.png"), width: 100, height: 100, fit: BoxFit.contain),
      //                   // fit:  BoxFit.cover,
      //                   Text(
      //                     'Hamstring',
      //                     style: TextStyle(color: Color(0xFFBFFF5A), fontSize: 18),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             const SizedBox(width: 10), // Add spacing between containers
      //             Container(
      //               width: 125,
      //               height: 150,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12),
      //                 color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.25) : Colors.black.withOpacity(0.25),
      //                     spreadRadius: 1,
      //                     blurRadius: 8,
      //                     offset: Offset(0, 4), // changes the position of the shadow
      //                   ),
      //                 ],
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Image.asset(ImgSample.get("Bicep_Muscle.png"), width: 100, height: 100, fit: BoxFit.contain),
      //                   // fit:  BoxFit.cover,
      //                   Text(
      //                     'Biceps',
      //                     style: TextStyle(color: Color(0xFFBFFF5A), fontSize: 18),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             const SizedBox(width: 10),
      //             Container(
      //               width: 125,
      //               height: 150,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12),
      //                 color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.25) : Colors.black.withOpacity(0.25),
      //                     spreadRadius: 1,
      //                     blurRadius: 8,
      //                     offset: Offset(0, 4), // changes the position of the shadow
      //                   ),
      //                 ],
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Image.asset(ImgSample.get("Pectoral_Muscle.png"), width: 100, height: 100, fit: BoxFit.contain),
      //                   // fit:  BoxFit.cover,
      //                   Text(
      //                     'Pectoral',
      //                     style: TextStyle(color: Color(0xFFBFFF5A), fontSize: 18),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       const SizedBox(height: 10),
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
      child:Padding(
        padding:EdgeInsets.all(15),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              // Image at the bottom
              Image.asset(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Text and other content overlaid on the image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  // color: Colors.black.withOpacity(0.5), // Optional: Add a semi-transparent background for better readability
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                          color: Colors.white, // Text color set to white for better contrast
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Goal: $goal",
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.white, // Text color set to white for better contrast
                        ),
                      ),
                      SizedBox(height: 10),
                      // Removed the LinearProgressIndicator from here
                    ],
                  ),
                ),
              ),
              // Progress bar at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  color: Color(0xFFBFFF5A),
                  minHeight: 8.0,
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
    return 'assets/images/$imageName';
  }
}
