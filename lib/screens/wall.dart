import 'package:flutter/material.dart';
import 'package:wall_calculator/widgets/wall_form_widget.dart';

import '../models/wall.dart';

class SavedWall extends StatelessWidget {
  const SavedWall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wall = ModalRoute.of(context)!.settings.arguments as Wall;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          wall.wallName,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: WallForm(
          savedWall: wall,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Walls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Add Walls',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          value == 0
              ? Navigator.pushReplacementNamed(context, '/')
              : Navigator.pushReplacementNamed(context, '/wall_calculator');
        },
      ),
    );
  }
}
