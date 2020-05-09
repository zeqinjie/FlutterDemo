

import 'dart:math';

import 'package:flutter/material.dart';

class MyToolWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("hello");
  }

  static Color getRandomColor() {
    return Color.fromARGB(
        255,
        Random.secure().nextInt(255),
        Random.secure().nextInt(255),
        Random.secure().nextInt(255));
  }

}