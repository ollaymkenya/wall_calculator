import 'package:flutter/material.dart';
import 'package:wall_calculator/screens/wall.dart';
import 'package:wall_calculator/screens/walls.dart';
import 'package:wall_calculator/screens/wall_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const Walls(),
      '/wall_calculator': (context) => const WallCalculator(),
      '/saved_wall': (context) => const SavedWall(),
    });
  }
}
