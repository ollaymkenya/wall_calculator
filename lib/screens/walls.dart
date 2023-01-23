import 'package:flutter/material.dart';
import 'package:wall_calculator/models/wall.dart';

import '../db/walls.dart';

class Walls extends StatefulWidget {
  const Walls({Key? key}) : super(key: key);
  @override
  _WallState createState() => _WallState();
}

class _WallState extends State<Walls> {
  late List<Wall> _walls;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshWalls();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Wall>> getWalls() async {
    return await WallsDatabase.instance.readAllWalls();
  }

  Future refreshWalls() async {
    setState(() => _isLoading = true);
    List<Wall> walls = await getWalls();
    setState(() => _walls = walls);
    setState(() => _isLoading = false);
  }

  deleteWall(int id) async {
    await WallsDatabase.instance.delete(id);
    List<Wall> walls = await getWalls();
    setState(() => _walls = walls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Walls"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _isLoading
            ? const Text(
                'Loading',
                style: TextStyle(fontSize: 32),
              )
            : _walls.isEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'No Walls Saved',
                        style: TextStyle(fontSize: 32),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, '/wall_calculator'),
                        child: const Text('Add new Wall'),
                      )
                    ],
                  )
                : Column(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, '/wall_calculator'),
                        child: const Text('Add new Wall'),
                      ),
                      Column(
                        children: _walls
                            .map((wall) => ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(wall.wallName),
                                                      Text(
                                                          '${wall.createdTime.day.toString()} / ${wall.createdTime.month.toString()} / ${wall.createdTime.year.toString()} (${wall.createdTime.hour}:${wall.createdTime.minute} )')
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Price ${wall.totalCost}'),
                                                      Text(
                                                        'Number of bricks ${wall.bricksNeeded.toString()}',
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () =>
                                                    deleteWall(wall.id!),
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/saved_wall',
                                              arguments: wall);
                                        }),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
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
