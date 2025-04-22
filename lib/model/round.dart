import 'package:dart_mappable/dart_mappable.dart';

part 'round.mapper.dart';

@MappableClass() // no need to set caseStyle here
class Round with RoundMappable {
  Round(this.index, this.score);

  int index;
  int score;
}
