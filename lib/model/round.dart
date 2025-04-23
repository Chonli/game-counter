import 'package:dart_mappable/dart_mappable.dart';

part 'round.mapper.dart';

@MappableClass() // no need to set caseStyle here
class Round with RoundMappable {
  Round({required this.id, required this.index, required this.playerByScores});

  int id;
  int index;
  Map<int, int> playerByScores;
}
