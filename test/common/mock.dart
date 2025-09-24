import 'package:mocktail/mocktail.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/data/repositories/preferences.dart';

// Mock de la classe GamesRepository
class MockGamesRepository extends Mock implements GamesRepository {}

class MockPreferencesRepository extends Mock implements PreferencesRepository {}
