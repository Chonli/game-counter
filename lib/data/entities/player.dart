import 'dart:ui';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:score_counter/model/player.dart';

class PlayerEntity extends HiveObject {
  String id;
  String name;
  int color;

  PlayerEntity({required this.id, required this.name, required this.color});
}

extension PlayerEntityExtension on PlayerEntity {
  Player toModel() {
    return Player(id: id, name: name, color: Color(color));
  }
}
