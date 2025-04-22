import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'player.mapper.dart';

@MappableClass() // no need to set caseStyle here
class Player with PlayerMappable {
  Player(this.name, this.color);

  String name;
  Color color;
}
