import 'package:cmatcher/game/game_engine.dart';
import 'package:flutter/material.dart';

class GameController {
  final CMatcherGameEngine _gameEngine;

  GameController({required CMatcherGameEngine gameEngine})
      : _gameEngine = gameEngine {
    _getInitialUserColors();
    _getCorrectColors();
  }

  void _getInitialUserColors() {
    _userColors.value = _gameEngine.getUserColors();
  }

  final ValueNotifier<List<Color>> _userColors = ValueNotifier([]);
  ValueNotifier<List<Color>> get userColors => _userColors;

  final ValueNotifier<int> _correctColors = ValueNotifier(0);
  ValueNotifier<int> get correctColors => _correctColors;

  void _getCorrectColors() {
    _correctColors.value =
        _gameEngine.getCorrectMatches(_userColors.value).length;
  }

  String updateUserColors({
    required int fromIndex,
    required int toIndex,
  }) {
    if (fromIndex < 0 ||
        fromIndex >= _userColors.value.length ||
        toIndex < 0 ||
        toIndex >= _userColors.value.length) {
      return "Invalid index";
    }

    Color temp = _userColors.value[fromIndex];
    _userColors.value[fromIndex] = _userColors.value[toIndex];
    _userColors.value[toIndex] = temp;
    _getCorrectColors();
    return "Exchanged ${_userColors.value[fromIndex]} and ${_userColors.value[toIndex]}";
  }
}
