import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:score_counter/core/database.dart';
import 'package:score_counter/l10n/app_localizations.dart';
import 'package:score_counter/notifier/preferences.dart';
import 'package:score_counter/objectbox.g.dart';
import 'package:score_counter/router/app_router.dart';
import 'package:score_counter/services/package_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Init Database
  final dir = await getApplicationSupportDirectory();
  // build the database path
  final dbPath = join(dir.path, 'my_database.db');
  final db = await openStore(directory: dbPath);

  final packageInfo = await PackageInfo.fromPlatform();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        packageInfoProvider.overrideWithValue(AppPackageInfo(packageInfo)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final preferences = ref.watch(preferencesNotifierProvider);

    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(preferences.language),
      themeMode: preferences.themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent.shade700,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
