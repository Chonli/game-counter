// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get add_game => 'Ajouter une partie';

  @override
  String get add_game_name_field => 'Nom de la partie';

  @override
  String get add_game_title => 'Ajouter une nouvelle partie';

  @override
  String get error_loading_games => 'Erreur lors du chargement des parties.';

  @override
  String get game => 'Partie';

  @override
  String get home_title => 'Compteur de Score';

  @override
  String get no_games => 'Aucune partie disponible.';

  @override
  String get player => 'Joueur';

  @override
  String get score => 'Score';
}
