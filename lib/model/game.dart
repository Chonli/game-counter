import 'package:dart_mappable/dart_mappable.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';

part 'game.mapper.dart';

@MappableClass()
class Game with GameMappable {
  String name;
  DateTime createDate;
  int id;
  List<Player> players;
  List<Round> rounds;

  Game({
    required this.id,
    required this.name,
    required this.createDate,
    this.players = const [],
    this.rounds = const [],
  });
}
