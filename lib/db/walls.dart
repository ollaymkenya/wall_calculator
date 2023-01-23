import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wall_calculator/models/wall.dart';

class WallsDatabase {
  static final WallsDatabase instance = WallsDatabase._init();

  static Database? _database;

  WallsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('walls.db');
    return _database!;
  }

  Future<Database> _initDB(String filPath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filPath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE $tableWalls (
        ${WallFields.id} $idType,    
        ${WallFields.wallName} $textType,    
        ${WallFields.wallLength} $doubleType,
        ${WallFields.wallLengthMeasurement} $textType,
        ${WallFields.wallHeight} $doubleType,
        ${WallFields.wallHeightMeasurement} $textType,
        ${WallFields.brickLength} $doubleType,
        ${WallFields.brickLengthMeasurement} $textType,
        ${WallFields.brickHeight} $doubleType,
        ${WallFields.brickHeightMeasurement} $textType,
        ${WallFields.mortarJoint} $doubleType,
        ${WallFields.mortarJointMeasurement} $textType,
        ${WallFields.wasteInPercentage} $doubleType,
        ${WallFields.pricePerBrick} $doubleType,
        ${WallFields.bricksNeeded} $integerType,
        ${WallFields.totalCost} $doubleType,
        ${WallFields.createdTime} $textType
      )
    ''');
  }

  Future<Wall> create(Wall wall) async {
    final db = await instance.database;

    final id = await db.insert(tableWalls, wall.toJson());
    return wall.copy(id: id);
  }

  Future<Wall> readWall(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableWalls,
      columns: WallFields.values,
      where: '${WallFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Wall.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Wall>> readAllWalls() async {
    final db = await instance.database;
    const orderBy = '${WallFields.createdTime} DESC';

    final results = await db.query(tableWalls, orderBy: orderBy);
    return results.map((json) => Wall.fromJson(json)).toList();
  }

  Future<int> update(Wall wall) async {
    final db = await instance.database;

    return db.update(
      tableWalls,
      wall.toJson(),
      where: '${WallFields.id} = ?',
      whereArgs: [wall.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableWalls,
      where: '${WallFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
