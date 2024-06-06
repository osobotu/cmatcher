import 'package:cmatcher/game/game_controller.dart';
import 'package:cmatcher/game/game_engine.dart';
import 'package:cmatcher/utils.dart';
import 'package:flutter/material.dart';

class CMatcherGamePage extends StatefulWidget {
  const CMatcherGamePage({super.key, required this.title});

  final String title;

  @override
  State<CMatcherGamePage> createState() => _CMatcherGamePageState();
}

class _CMatcherGamePageState extends State<CMatcherGamePage> {
  late GameController gameController;

  @override
  void initState() {
    super.initState();
    final gameEngine = CMatcherGameEngine(length: 5);
    gameController = GameController(gameEngine: gameEngine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: gameController.correctColors,
            builder: (context, numberOfCorrectColors, _) {
              return Text(
                "$numberOfCorrectColors color(s) are correctly placed",
                style: Theme.of(context).textTheme.titleMedium,
              );
            },
          ),
          const SizedBox(height: 100),
          ValueListenableBuilder(
            valueListenable: gameController.userColors,
            builder: (context, colors, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...colors.map(
                    (e) => DragTarget<Color>(
                      builder: (context, accepted, rejected) {
                        return Draggable(
                          feedback: FeedbackWidget(color: e),
                          child: ColorWidget(color: e),
                        );
                      },
                      onAcceptWithDetails: (details) {
                        // todo: replace this color with the dropped one and move this color to the picked position
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Undo',
            child: const Icon(Icons.undo),
          ),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Reset',
            child: const Icon(Icons.restore),
          ),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Redo',
            child: const Icon(Icons.redo),
          ),
        ],
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Text(
            Utils.getColorName(color),
          ),
        ),
      ),
    );
  }
}

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Text(
            Utils.getColorName(color),
          ),
        ),
      ),
    );
  }
}
