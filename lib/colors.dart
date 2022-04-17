import 'package:flutter/material.dart';

class PoolyColors {
  static List<Color> colors = [
    const Color(0xFF2F20DA), // #2F20DA (dark blue 1)
    const Color(0xFF5CA0FF), // #5CA0FF (light blue 1)
    const Color(0xFF2F1EDD), // #2F1EDD (dark blue 2)
    const Color(0xFF5CA1FE), // #5CA1FE (light blue 2)
    const Color(0xFF5AA3FB), // #5AA3FB (light blue 3)
  ];

  static List<Color> darkBlue = [colors[0], colors[2]];
  static List<Color> lightBlue = [colors[1], colors[3], colors[4]];
}