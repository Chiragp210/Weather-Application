

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/views/additinal_info.dart';

Widget currentWeather(IconData icon,String temp, String location){
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
        color: Colors.orange,
          size: 50.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text("$temp",
        style: TextStyle(
          fontSize: 30.0,
        ),
        ),
        SizedBox(height: 10.0,),
        Text("$location",
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),

      ],
    ),
  );
}