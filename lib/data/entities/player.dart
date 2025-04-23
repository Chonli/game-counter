import 'dart:ui';

import 'package:objectbox/objectbox.dart';
import 'package:score_counter/model/player.dart';

@Entity()
class PlayerEntity {
  @Id()
  int id;
  String name;
  int score;
  int color;

  PlayerEntity({
    this.id = 0,
    required this.name,
    required this.color,
    this.score = 0,
  });
}

extension PlayerEntityExtension on PlayerEntity {
  Player toModel() {
    return Player(id: id, name: name, color: Color(color), score: score);
  }
}
