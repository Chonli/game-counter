import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  @HiveType(typeId: 1, adapterName: 'GameClassAdapter')
  const factory Game({
    @HiveField(1) required String name,
    @HiveField(2) required int numberPalyer,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
