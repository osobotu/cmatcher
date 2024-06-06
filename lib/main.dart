import 'package:cmatcher/game/game_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Matcher Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      // home: const CMatcherGamePage(title: 'Color Matcher'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Drag and Drop Example'),
        ),
        body: WidgetList(),
      ),
    );
  }
}
