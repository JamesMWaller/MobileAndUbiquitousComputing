import 'package:flutter/material.dart';
import 'home_page.dart';

class Exercises extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Exercises')
      ),
      body: Column(
        children: [
          Card(
            // Define the shape of the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            // Define how the card's content should be clipped
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // Define the child widget of the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Add padding around the row widget
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Add an image widget to display an image
                      Image.asset(
                        ImgSample.get("bicep_curl_photo.gif"),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      // Add some spacing between the image and the text
                      Container(width: 20),
                      // Add an expanded widget to take up the remaining horizontal space
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Add some spacing between the top of the card and the title
                            Container(height: 5),
                            // Add a title widget
                            Text(
                              "Bicep Curl",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.grey[800],
                              ),
                            ),
                            // Add some spacing between the title and the subtitle
                            Container(height: 5),
                            // Add a subtitle widget
                            Text(
                              "Sub title",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey[500],
                              ),
                            ),
                            // Add some spacing between the subtitle and the text
                            Container(height: 10),
                            // Add a text widget to display some text
                            Text(
                              "Your Card Text Here",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            // Define the shape of the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            // Define how the card's content should be clipped
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // Define the child widget of the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Add padding around the row widget
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Add an image widget to display an image
                      Image.asset(
                        ImgSample.get("dumbell_curl_photo.gif"),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      // Add some spacing between the image and the text
                      Container(width: 20),
                      // Add an expanded widget to take up the remaining horizontal space
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Add some spacing between the top of the card and the title
                            Container(height: 5),
                            // Add a title widget
                            Text(
                              "Dumbbell Curl",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.grey[800],
                              ),
                            ),
                            // Add some spacing between the title and the subtitle
                            Container(height: 5),
                            // Add a subtitle widget
                            Text(
                              "Sub title",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey[500],
                              ),
                            ),
                            // Add some spacing between the subtitle and the text
                            Container(height: 10),
                            // Add a text widget to display some text
                            Text(
                              "Your Card Text Here",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            // Define the shape of the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            // Define how the card's content should be clipped
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // Define the child widget of the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Add padding around the row widget
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Add an image widget to display an image
                      Image.asset(
                        ImgSample.get("hammer_curl_photo.gif"),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      // Add some spacing between the image and the text
                      Container(width: 20),
                      // Add an expanded widget to take up the remaining horizontal space
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Add some spacing between the top of the card and the title
                            Container(height: 5),
                            // Add a title widget
                            Text(
                              "Hammer Curl",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.grey[800],
                              ),
                            ),
                            // Add some spacing between the title and the subtitle
                            Container(height: 5),
                            // Add a subtitle widget
                            Text(
                              "Sub title",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey[500],
                              ),
                            ),
                            // Add some spacing between the subtitle and the text
                            Container(height: 10),
                            // Add a text widget to display some text
                            Text(
                              "Your Card Text Here",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text(
                  'Go back to the home page'
              )
          )
        ],
      ),
    );
  }
}

class ImgSample {
  static String get(String imageName) {
    return 'assets/$imageName'; // Adjust the path as needed
  }
}