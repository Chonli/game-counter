import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:score_counter/data/entities/player.dart';

part 'player.mapper.dart';

@MappableClass() // no need to set caseStyle here
class Player with PlayerMappable {
  Player({
    required this.id,
    required this.name,
    required this.color,
    this.totalScore = 0,
  });

  int id;
  String name;
  Color color;
  int totalScore;
}

extension PlayerExtension on Player {
  PlayerEntity toEntity() {
    return PlayerEntity(id: id, name: name, color: color.toARGB32());
  }
}
