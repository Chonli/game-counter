import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'player.mapper.dart';

@MappableClass() // no need to set caseStyle here
class Player with PlayerMappable {
  Player({required this.name, required this.color, this.score = 0});

  String name;
  Color color;
  int score;
}
