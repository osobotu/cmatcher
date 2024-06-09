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

  List<Color> swapItems(int fromIndex, int toIndex) {
    final newColors = List<Color>.from(gameController.userColors.value);
    final temp = newColors[fromIndex];
    newColors[fromIndex] = newColors[toIndex];
    newColors[toIndex] = temp;
    return newColors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: gameController.correctColors,
            builder: (context, numberOfCorrectColors, _) {
              if (numberOfCorrectColors == 5) {
                return Text(
                  "Whoops! All colors match",
                  style: Theme.of(context).textTheme.titleMedium,
                );
              }
              return Text(
                "$numberOfCorrectColors color(s) are correctly placed",
                style: Theme.of(context).textTheme.titleMedium,
              );
            },
          ),
          const SizedBox(height: 40),
          ValueListenableBuilder(
            valueListenable: gameController.userColors,
            builder: (context, colors, _) {
              return Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    final color = colors[index];
                    return Draggable<Color>(
                      data: colors[index],
                      feedback: FeedbackWidget(color: color),
                      childWhenDragging: WhenDraggingWidget(color: color),
                      child: DragTarget<Color>(
                        onAccept: (Color fromColor) {
                          final fromIndex = colors.indexOf(fromColor);
                          final newColors = swapItems(fromIndex, index);
                          gameController.updateUserColors(colors: newColors);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return ColorWidget(color: color);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {},
                tooltip: 'Undo',
                child: const Icon(Icons.undo),
              ),
              FloatingActionButton(
                onPressed: () {
                  gameController.reset();
                },
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
          const SizedBox(height: 20),
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

class WhenDraggingWidget extends StatelessWidget {
  const WhenDraggingWidget({
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
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: color),
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
