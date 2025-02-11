import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble/exercises.dart';

class Details_Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ElevatedButton(

            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Exercises()));
            },
            child: Text(
                'Go back to the Exercises page'
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white
            ),

          ),
      ),
    );
  }
  
}