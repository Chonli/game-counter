import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/extension/go_router.dart';
import 'package:score_counter/module/add_game/add_game_page.dart';
import 'package:score_counter/module/game/active_game.dart';
import 'package:score_counter/module/game/add_round/add_round_page.dart';
import 'package:score_counter/module/home/home_page.dart';
import 'package:score_counter/module/preferences/preferences_page.dart';
import 'package:score_counter/router/app_route.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoute.root.path,
        name: AppRoute.root.name,
        builder: (context, state) => const MyHomePage(),
        routes: [
          GoRoute(
            path: AppRoute.addGame.path,
            name: AppRoute.addGame.name,
            builder: (context, state) => AddGamePage(),
          ),
          GoRoute(
            path: AppRoute.activeGame.path,
            name: AppRoute.activeGame.name,
            builder: (context, state) => ActiveGamePage(gameId: state.gameId),
            routes: [
              GoRoute(
                path: AppRoute.addRound.path,
                name: AppRoute.addRound.name,
                builder:
                    (context, state) => AddRoundPage(
                      gameId: state.gameId,
                      roundId: state.roundId,
                    ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.preferences.path,
        name: AppRoute.preferences.name,
        builder: (context, state) => const PreferencesPage(),
      ),
    ],
  );

  return router;
}
