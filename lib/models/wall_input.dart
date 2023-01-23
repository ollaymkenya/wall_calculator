import 'package:flutter/material.dart';

class WallInput {
  String name;
  TextInputType kType;
  String? measurement;

  WallInput(this.name, this.kType, this.measurement);
}

class DoubleWallInput extends WallInput {
  String inputName;
  TextInputType keyType;
  double value;
  String? unit;

  DoubleWallInput(
      {required this.inputName,
        required this.keyType,
        required this.value,
        this.unit})
      : super(inputName, keyType, unit);
}

class StringWallInput extends WallInput {
  String inputName;
  TextInputType keyType;
  String value;
  String? unit;

  StringWallInput(
      {required this.inputName,
        required this.keyType,
        required this.value,
        this.unit})
      : super(inputName, keyType, unit);
}

class IntWallInput extends WallInput {
  String inputName;
  TextInputType keyType;
  int value;
  String? unit;

  IntWallInput(
      {required this.inputName,
        required this.keyType,
        required this.value,
        this.unit})
      : super(inputName, keyType, unit);
}