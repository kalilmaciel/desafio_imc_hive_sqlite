import 'dart:math';

import 'package:flutter/material.dart';

class Medicao {
  String _id = UniqueKey().toString();
  double _peso = 0.0;
  double _altura = 0.0;

  get id => _id;

  set id(value) => _id = value;

  get peso => _peso;

  set peso(value) => _peso = value;

  get altura => _altura;

  set altura(value) => _altura = value;

  double get imc => _peso / pow((_altura / 100), 2);
}
