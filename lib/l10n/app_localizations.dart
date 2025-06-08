import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @active_game_title.
  ///
  /// In en, this message translates to:
  /// **'Active Game'**
  String get active_game_title;

  /// No description provided for @add_game.
  ///
  /// In en, this message translates to:
  /// **'Add Game'**
  String get add_game;

  /// No description provided for @add_game_name_field.
  ///
  /// In en, this message translates to:
  /// **'Game Name'**
  String get add_game_name_field;

  /// No description provided for @add_game_title.
  ///
  /// In en, this message translates to:
  /// **'Add New Game'**
  String get add_game_title;

  /// No description provided for @add_players.
  ///
  /// In en, this message translates to:
  /// **'Add Players'**
  String get add_players;

  /// No description provided for @add_round.
  ///
  /// In en, this message translates to:
  /// **'Add Round'**
  String get add_round;

  /// No description provided for @add_round_add_1.
  ///
  /// In en, this message translates to:
  /// **'+1'**
  String get add_round_add_1;

  /// No description provided for @add_round_add_10.
  ///
  /// In en, this message translates to:
  /// **'+10'**
  String get add_round_add_10;

  /// No description provided for @add_round_add_5.
  ///
  /// In en, this message translates to:
  /// **'+5'**
  String get add_round_add_5;

  /// No description provided for @add_round_add_50.
  ///
  /// In en, this message translates to:
  /// **'+50'**
  String get add_round_add_50;

  /// No description provided for @add_round_button.
  ///
  /// In en, this message translates to:
  /// **'Add Round'**
  String get add_round_button;

  /// No description provided for @add_round_error_game_not_found.
  ///
  /// In en, this message translates to:
  /// **'Game not found'**
  String get add_round_error_game_not_found;

  /// No description provided for @add_round_error_load_game.
  ///
  /// In en, this message translates to:
  /// **'Load Game error'**
  String get add_round_error_load_game;

  /// No description provided for @add_round_score.
  ///
  /// In en, this message translates to:
  /// **'Score:'**
  String get add_round_score;

  /// No description provided for @add_round_subtract_1.
  ///
  /// In en, this message translates to:
  /// **'-1'**
  String get add_round_subtract_1;

  /// No description provided for @add_round_subtract_10.
  ///
  /// In en, this message translates to:
  /// **'-10'**
  String get add_round_subtract_10;

  /// No description provided for @add_round_subtract_5.
  ///
  /// In en, this message translates to:
  /// **'-5'**
  String get add_round_subtract_5;

  /// No description provided for @add_round_subtract_50.
  ///
  /// In en, this message translates to:
  /// **'-50'**
  String get add_round_subtract_50;

  /// No description provided for @add_round_title.
  ///
  /// In en, this message translates to:
  /// **'Add a round'**
  String get add_round_title;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @delete_game.
  ///
  /// In en, this message translates to:
  /// **'Delete Game'**
  String get delete_game;

  /// No description provided for @delete_game_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this game?'**
  String get delete_game_confirmation;

  /// No description provided for @error_loading_games.
  ///
  /// In en, this message translates to:
  /// **'Error loading games.'**
  String get error_loading_games;

  /// No description provided for @game.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// No description provided for @game_not_found.
  ///
  /// In en, this message translates to:
  /// **'Game not found'**
  String get game_not_found;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Score Counter'**
  String get home_title;

  /// No description provided for @lang_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lang_english;

  /// No description provided for @lang_french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get lang_french;

  /// No description provided for @load_game_error.
  ///
  /// In en, this message translates to:
  /// **'Load Game error'**
  String get load_game_error;

  /// No description provided for @no_games.
  ///
  /// In en, this message translates to:
  /// **'No games available.'**
  String get no_games;

  /// No description provided for @player.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// No description provided for @preferences_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get preferences_language;

  /// No description provided for @preferences_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get preferences_theme;

  /// No description provided for @preferences_title.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences_title;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @theme_mode_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_mode_dark;

  /// No description provided for @theme_mode_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_mode_light;

  /// No description provided for @theme_mode_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get theme_mode_system;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
