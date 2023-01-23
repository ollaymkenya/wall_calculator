const String tableWalls = 'walls';

class WallFields {
  static final List<String> values = [
    id,
    wallName,
    wallLength,
    wallLengthMeasurement,
    wallHeight,
    wallHeightMeasurement,
    brickLength,
    brickLengthMeasurement,
    brickHeight,
    brickHeightMeasurement,
    mortarJoint,
    mortarJointMeasurement,
    wasteInPercentage,
    pricePerBrick,
    bricksNeeded,
    totalCost,
    createdTime
  ];

  static const String id = '_id';
  static const String wallName = 'wallName';
  static const String wallLength = 'wallLength';
  static const String wallLengthMeasurement = 'wallLengthMeasurement';
  static const String wallHeight = 'wallHeight';
  static const String wallHeightMeasurement = 'wallHeightMeasurement';
  static const String brickLength = 'brickLength';
  static const String brickLengthMeasurement = 'brickLengthMeasurement';
  static const String brickHeight = 'brickHeight';
  static const String brickHeightMeasurement = 'brickHeightMeasurement';
  static const String mortarJoint = 'mortarJoint';
  static const String mortarJointMeasurement = 'mortarJointMeasurement';
  static const String wasteInPercentage = 'wasteInPercentage';
  static const String pricePerBrick = 'pricePerBrick';
  static const String bricksNeeded = 'bricksNeeded';
  static const String totalCost = 'totalCost';
  static const String createdTime = 'createdTime';
}

class Wall {
  final int? id;
  final String wallName;
  final double wallLength;
  final String wallLengthMeasurement;
  final double wallHeight;
  final String wallHeightMeasurement;
  final double brickLength;
  final String brickLengthMeasurement;
  final double brickHeight;
  final String brickHeightMeasurement;
  final double mortarJoint;
  final String mortarJointMeasurement;
  final double wasteInPercentage;
  final double pricePerBrick;
  final int bricksNeeded;
  final double totalCost;
  final DateTime createdTime;

  const Wall({
    this.id,
    required this.wallName,
    required this.wallLength,
    required this.wallLengthMeasurement,
    required this.wallHeight,
    required this.wallHeightMeasurement,
    required this.brickLength,
    required this.brickLengthMeasurement,
    required this.brickHeight,
    required this.brickHeightMeasurement,
    required this.mortarJoint,
    required this.mortarJointMeasurement,
    required this.wasteInPercentage,
    required this.pricePerBrick,
    required this.bricksNeeded,
    required this.totalCost,
    required this.createdTime,
  });

  Wall copy({
    int? id,
    String? wallName,
    double? wallLength,
    String? wallLengthMeasurement,
    double? wallHeight,
    String? wallHeightMeasurement,
    double? brickLength,
    String? brickLengthMeasurement,
    double? brickHeight,
    String? brickHeightMeasurement,
    double? mortarJoint,
    String? mortarJointMeasurement,
    double? wasteInPercentage,
    double? pricePerBrick,
    int? bricksNeeded,
    double? totalCost,
    DateTime? createdTime,
  }) =>
      Wall(
        id: id ?? this.id,
        wallName: wallName ?? this.wallName,
        wallLength: wallLength ?? this.wallLength,
        wallLengthMeasurement:
            wallLengthMeasurement ?? this.wallLengthMeasurement,
        wallHeight: wallHeight ?? this.wallHeight,
        wallHeightMeasurement:
            wallHeightMeasurement ?? this.wallHeightMeasurement,
        brickLength: brickLength ?? this.brickLength,
        brickLengthMeasurement:
            brickLengthMeasurement ?? this.brickLengthMeasurement,
        brickHeight: brickHeight ?? this.brickHeight,
        brickHeightMeasurement:
            brickHeightMeasurement ?? this.brickHeightMeasurement,
        mortarJoint: mortarJoint ?? this.mortarJoint,
        mortarJointMeasurement:
            mortarJointMeasurement ?? this.mortarJointMeasurement,
        wasteInPercentage: wasteInPercentage ?? this.wasteInPercentage,
        pricePerBrick: pricePerBrick ?? this.pricePerBrick,
        bricksNeeded: bricksNeeded ?? this.bricksNeeded,
        totalCost: totalCost ?? this.totalCost,
        createdTime: createdTime ?? this.createdTime,
      );

  static Wall fromJson(Map<String, Object?> json) => Wall(
        id: json[WallFields.id] as int,
        wallName: json[WallFields.wallName] as String,
        wallLength: json[WallFields.wallLength] as double,
        wallLengthMeasurement: json[WallFields.wallLengthMeasurement] as String,
        wallHeight: json[WallFields.wallHeight] as double,
        wallHeightMeasurement: json[WallFields.wallHeightMeasurement] as String,
        brickLength: json[WallFields.brickLength] as double,
        brickLengthMeasurement:
            json[WallFields.brickLengthMeasurement] as String,
        brickHeight: json[WallFields.brickHeight] as double,
        brickHeightMeasurement:
            json[WallFields.brickHeightMeasurement] as String,
        mortarJoint: json[WallFields.mortarJoint] as double,
        mortarJointMeasurement:
            json[WallFields.mortarJointMeasurement] as String,
        wasteInPercentage: json[WallFields.wasteInPercentage] as double,
        pricePerBrick: json[WallFields.pricePerBrick] as double,
        bricksNeeded: json[WallFields.bricksNeeded] as int,
        totalCost: json[WallFields.totalCost] as double,
        createdTime: DateTime.parse(json[WallFields.createdTime] as String),
      );

  Map<String, Object?> toJson() => {
        WallFields.id: id,
        WallFields.wallName: wallName,
        WallFields.wallLength: wallLength,
        WallFields.wallLengthMeasurement: wallLengthMeasurement,
        WallFields.wallHeight: wallHeight,
        WallFields.wallHeightMeasurement: wallHeightMeasurement,
        WallFields.brickLength: brickLength,
        WallFields.brickLengthMeasurement: brickLengthMeasurement,
        WallFields.brickHeight: brickHeight,
        WallFields.brickHeightMeasurement: brickHeightMeasurement,
        WallFields.mortarJoint: mortarJoint,
        WallFields.mortarJointMeasurement: mortarJointMeasurement,
        WallFields.wasteInPercentage: wasteInPercentage,
        WallFields.pricePerBrick: pricePerBrick,
        WallFields.bricksNeeded: bricksNeeded,
        WallFields.totalCost: totalCost,
        WallFields.createdTime: createdTime.toIso8601String(),
      };
}
