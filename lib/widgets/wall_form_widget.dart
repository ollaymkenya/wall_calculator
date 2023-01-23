import 'package:flutter/material.dart';
import 'package:wall_calculator/models/wall.dart';

import '../db/walls.dart';
import '../models/wall_input.dart';
import 'bottom_sheet_widget.dart';

class WallForm extends StatefulWidget {
  final Wall? savedWall;

  const WallForm({Key? key, this.savedWall}) : super(key: key);

  @override
  State<WallForm> createState() => _WallFormState();
}

class _WallFormState extends State<WallForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _measurements = [
    'centimeter',
    'inch',
    'foot',
    'yard',
    'meter',
    'kilometre',
    'mile'
  ];
  final List _wallInputs = [
    StringWallInput(
      inputName: 'Wall Name',
      keyType: TextInputType.text,
      value: '',
    ),
    DoubleWallInput(
      inputName: 'Wall Length',
      keyType: TextInputType.number,
      value: 0,
      unit: 'centimeter',
    ),
    DoubleWallInput(
      inputName: 'Wall Height',
      keyType: TextInputType.number,
      value: 0,
      unit: 'centimeter',
    ),
    DoubleWallInput(
      inputName: 'Brick Length',
      keyType: TextInputType.number,
      value: 0,
      unit: 'centimeter',
    ),
    DoubleWallInput(
      inputName: 'Brick Height',
      keyType: TextInputType.number,
      value: 0,
      unit: 'centimeter',
    ),
    DoubleWallInput(
      inputName: 'Mortar Joint',
      keyType: TextInputType.number,
      value: 0,
      unit: 'centimeter',
    ),
    DoubleWallInput(
      inputName: 'Waste In %',
      keyType: TextInputType.number,
      value: 0,
    ),
    DoubleWallInput(
      inputName: 'Price per block',
      keyType: TextInputType.number,
      value: 0,
    ),
  ];
  int _bricksNeeded = 0;
  double _totalCost = 0;

  formatInput(Type type, value) {
    if (type == StringWallInput) {
      return value;
    }
    if (type == DoubleWallInput) {
      return value == '' ? 0.0 : double.parse(value);
    }
    return value == '' ? 0 : int.parse(value);
  }

  handleValueChange(String name, String value) {
    Type type = _wallInputs[
            _wallInputs.indexWhere((element) => element.inputName == name)]
        .runtimeType;

    setState(() {
      _wallInputs[
              _wallInputs.indexWhere((element) => element.inputName == name)]
          .value = formatInput(type, value);
    });
  }

  handleMeasurementChange(String name, String measurement) {
    setState(() {
      _wallInputs[
              _wallInputs.indexWhere((element) => element.inputName == name)]
          .unit = measurement;
    });
  }

  resetData() {
    _formKey.currentState?.reset();
    var savedWall = widget.savedWall;
    if (savedWall != null) {
      setState(() {
        _wallInputs[0].value = savedWall.wallName;
        _wallInputs[1].value = savedWall.wallLength;
        _wallInputs[1].unit = savedWall.wallLengthMeasurement;
        _wallInputs[2].value = savedWall.wallHeight;
        _wallInputs[2].unit = savedWall.wallHeightMeasurement;
        _wallInputs[3].value = savedWall.brickLength;
        _wallInputs[3].unit = savedWall.brickLengthMeasurement;
        _wallInputs[4].value = savedWall.brickHeight;
        _wallInputs[4].unit = savedWall.brickHeightMeasurement;
        _wallInputs[5].value = savedWall.mortarJoint;
        _wallInputs[5].unit = savedWall.mortarJointMeasurement;
        _wallInputs[6].value = savedWall.wasteInPercentage;
        _wallInputs[7].value = savedWall.pricePerBrick;
        _bricksNeeded = savedWall.bricksNeeded;
        _totalCost = savedWall.totalCost;
      });
    } else {
      for (var wallInput in _wallInputs) {
        handleValueChange(wallInput.inputName, '');
        if (wallInput.unit != null) {
          handleMeasurementChange(wallInput.name, 'centimeter');
        }
      }
    }
  }

  double converter(wallInput) {
    var converter = {
      'centimeter': 1,
      'inch': 2.54,
      'foot': 30.48,
      'yard': 91.44,
      'meter': 100,
      'kilometre': 100000,
      'mile': 160934,
    };

    return wallInput.value * converter[wallInput.unit];
  }

  calculate() {
    double wallArea = converter(_wallInputs[1]) * converter(_wallInputs[2]);
    double brickArea = (converter(_wallInputs[3]) +
        converter(_wallInputs[5])) * (converter(_wallInputs[4]) +
        converter(_wallInputs[5]));
    double percentageMultiplier = (_wallInputs[6].value + 100) / 100;
    print(wallArea);
    print(brickArea);
    int bricksNeeded = ((wallArea / brickArea) * percentageMultiplier).ceil();
    double totalCost = bricksNeeded * _wallInputs[7].value as double;

    setState(() {
      _bricksNeeded = bricksNeeded;
      _totalCost = totalCost;
    });
  }

  Wall wallCreator() {
    calculate();

    Wall wall = Wall(
      wallName: _wallInputs[0].value,
      wallLength: _wallInputs[1].value,
      wallLengthMeasurement: _wallInputs[1].unit,
      wallHeight: _wallInputs[2].value,
      wallHeightMeasurement: _wallInputs[2].unit,
      brickLength: _wallInputs[3].value,
      brickLengthMeasurement: _wallInputs[3].unit,
      brickHeight: _wallInputs[4].value,
      brickHeightMeasurement: _wallInputs[4].unit,
      mortarJoint: _wallInputs[5].value,
      mortarJointMeasurement: _wallInputs[5].unit,
      wasteInPercentage: _wallInputs[6].value,
      pricePerBrick: _wallInputs[7].value,
      bricksNeeded: _bricksNeeded,
      totalCost: _totalCost,
      createdTime: DateTime.now(),
    );

    return wall;
  }

  submitData() {
    Wall wall = wallCreator();
    WallsDatabase.instance.create(wall);
    resetData();
  }

  updateWallData() {
    Wall wall = wallCreator().copy(id: widget.savedWall?.id);
    WallsDatabase.instance.update(wall);
  }

  @override
  void initState() {
    super.initState();
    resetData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            children: _wallInputs
                .map(
                  (wallInput) => wallInput.unit != null
                      ? Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: wallInput.value == 0
                                    ? ''
                                    : wallInput.value.toString(),
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                        ? 'Please enter ${wallInput.inputName}'
                                        : null,
                                keyboardType: wallInput.keyType,
                                decoration: InputDecoration(
                                  labelText: wallInput.inputName,
                                  border: const UnderlineInputBorder(),
                                ),
                                onChanged: (value) => handleValueChange(
                                    wallInput.inputName, value),
                              ),
                            ),
                            DropdownButton(
                              value: wallInput.unit,
                              items: _measurements
                                  .map(
                                    (measurement) => DropdownMenuItem(
                                      value: measurement,
                                      child: Text(
                                        measurement,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => handleMeasurementChange(
                                  wallInput.name, value as String),
                            )
                          ],
                        )
                      : TextFormField(
                          initialValue: wallInput.value == 0
                              ? ''
                              : wallInput.value.toString(),
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Please enter ${wallInput.inputName}'
                              : null,
                          keyboardType: wallInput.keyType,
                          decoration: InputDecoration(
                            labelText: wallInput.name,
                            border: const UnderlineInputBorder(),
                          ),
                          onChanged: (value) =>
                              handleValueChange(wallInput.name, value),
                        ),
                )
                .toList(),
          ),
          widget.savedWall == null
              ? Row(
                  children: [
                    BottomSheetWidget(
                      bricksNeeded: _bricksNeeded,
                      totalCost: _totalCost,
                      submitData: submitData,
                      formKey: _formKey,
                    ),
                    TextButton(
                      onPressed: () => resetData(),
                      child: const Text('Reset'),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => {
                            if (_formKey.currentState!.validate())
                              updateWallData()
                          },
                          child: const Text('Save'),
                        ),
                        TextButton(
                          onPressed: () => resetData(),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                    Text(
                      'Bricks Needed: ${_bricksNeeded}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.brown,
                      ),
                    ),
                    Text(
                      'Total Cost: ${_totalCost}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
