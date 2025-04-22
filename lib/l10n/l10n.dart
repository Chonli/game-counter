import 'package:flutter/material.dart';

import 'app_localizations.dart';

extension AppLocalizationsExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
