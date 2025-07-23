import 'dart:ui';

import 'package:objectbox/objectbox.dart';
import 'package:score_counter/model/player.dart';

@Entity()
class PlayerEntity {
  @Id(assignable: true)
  int id;
  String name;
  int color;

  PlayerEntity({this.id = 0, required this.name, required this.color});
}

extension PlayerEntityExtension on PlayerEntity {
  Player toModel() {
    return Player(id: id, name: name, color: Color(color));
  }
}
