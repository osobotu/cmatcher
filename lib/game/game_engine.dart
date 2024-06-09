import 'package:cmatcher/utils.dart';
import 'package:flutter/material.dart';

class CMatcherGameEngine {
  final int length;
  late List<Color> referenceArray;
  late List<Color> userArray;

  CMatcherGameEngine({required this.length}) {
    initialize(length);
  }

  void initialize(int length) {
    // referenceArray = Utils.generateRandomColors(length);
    referenceArray = Utils.getFixedColors();
    userArray = List.from(referenceArray)..shuffle();
  }

  List<int> getCorrectMatches(List<Color> choice) {
    List<int> correctMatches = [];
    for (int i = 0; i < referenceArray.length; i++) {
      if (referenceArray[i] == choice[i]) {
        correctMatches.add(i);
      }
    }
    return correctMatches;
  }

  List<Color> getUserColors() => userArray;

  List<Color> resetUserColors() => userArray..shuffle();

  bool isGameWon(List<Color> choice) =>
      getCorrectMatches(choice).length == referenceArray.length;
}
