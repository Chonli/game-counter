import 'package:hive_ce/hive.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/game_options.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/preferences.dart';
import 'package:score_counter/data/entities/round.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<GameEntity>(),
  AdapterSpec<GameOptionsEntity>(),
  AdapterSpec<PlayerEntity>(),
  AdapterSpec<RoundEntity>(),
  AdapterSpec<PreferencesEntity>(),
])
class HiveAdapters {}
