import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/hive_registrar.g.dart';
import 'package:score_counter/data/entities/preferences.dart';
import 'package:score_counter/l10n/app_localizations.dart';
import 'package:score_counter/notifier/preferences.dart';
import 'package:score_counter/router/app_router.dart';
import 'package:score_counter/services/package_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Init Database
  final dir = await getApplicationSupportDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapters();
  await Hive.openBox<PreferencesEntity>('preferences');
  await Hive.openBox<GameEntity>('games');

  final packageInfo = await PackageInfo.fromPlatform();

  runApp(
    ProviderScope(
      overrides: [
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
