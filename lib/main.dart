import 'package:flutter/material.dart';
import 'package:game_counter/core/router.dart';
import 'package:game_counter/data/sources/bdd.dart';
import 'package:game_counter/modules/games/notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  final bdd = HiveBdd();
  await bdd.init();
  runApp(MyApp(bdd: bdd));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.bdd,
  }) : super(key: key);

  final HiveBdd bdd;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();

    return MultiProvider(
      providers: [
        Provider<HiveBdd>.value(value: bdd),
        ChangeNotifierProvider<GameNotifier>(
          create: (context) => GameNotifier(context.read),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        title: 'Game couter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
