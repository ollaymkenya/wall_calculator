import 'package:flutter/material.dart';
import '../widgets/wall_form_widget.dart';

class WallCalculator extends StatefulWidget {
  const WallCalculator({Key? key}) : super(key: key);

  @override
  State<WallCalculator> createState() => _WallCalculatorState();
}

class _WallCalculatorState extends State<WallCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wall Calculator'),
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: WallForm(),
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
        currentIndex: 1,
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
