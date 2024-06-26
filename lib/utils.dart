import 'dart:math';

import 'package:flutter/material.dart';

class Utils {
  static List<Color> generateRandomColors(int length) {
    final rand = Random.secure();
    return List.generate(
      length,
      (index) => Color.fromARGB(
        rand.nextInt(255),
        rand.nextInt(255),
        rand.nextInt(255),
        rand.nextInt(255),
      ),
    );
  }

  static List<Color> getFixedColors() {
    return [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
    ];
  }

  static String getColorName(Color c) {
    switch (c) {
      case Colors.red:
        return "Red";
      case Colors.orange:
        return "Orange";
      case Colors.yellow:
        return "Yellow";
      case Colors.green:
        return "Green";
      case Colors.blue:
        return "Blue";
      default:
        return "";
    }
  }

  static String printList(List<Color> colors) {
    String colorsString = '';
    for (var color in colors) {
      colorsString += " ";
      colorsString += getColorName(color);
    }
    return colorsString;
  }

  static String getMessage(int numberOfCorrectColors) {
    switch (numberOfCorrectColors) {
      case 0:
        return "You have no colors matched.";
      case 1:
        return "You have matched 1 color";
      case 5:
        return "Hooray! All colors match!";
      default:
        return "You have matched $numberOfCorrectColors colors";
    }
  }
}
