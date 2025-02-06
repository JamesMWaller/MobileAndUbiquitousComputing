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
