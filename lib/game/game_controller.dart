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

  void updateUserColors({required List<Color> colors}) {
    _userColors.value = colors;
    _getCorrectColors();
  }

  void reset() {
    final newColors = List<Color>.from(_gameEngine.resetUserColors());
    _getCorrectColors();
    _userColors.value = newColors;
  }
}
