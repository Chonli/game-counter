import 'package:game_counter/modules/games/add_game_view.dart';
import 'package:game_counter/modules/games/view.dart';
import 'package:go_router/go_router.dart';
// ignore: implementation_imports
import 'package:go_router/src/typedefs.dart';

class AppRouter extends GoRouter {
  AppRouter()
      : super(
          routes: [
            GoRoute(
              name: AppRoutes.home.name,
              path: AppRoutes.home.path,
              redirect: (state) => AppRoutes.games.path,
            ),
            GoRoute(
              name: AppRoutes.games.name,
              path: AppRoutes.games.path,
              builder: (_, __) => const GameView(),
              routes: [
                GoRoute(
                  name: AppRoutes.createGame.name,
                  path: AppRoutes.createGame.path,
                  builder: (_, __) => const AddGameView(),
                ),
              ],
            ),
          ],
        );
}

class AppRoutes {
  const AppRoutes._(this.name, this.path);
  static const home = AppRoutes._('home', '/');
  static const games = AppRoutes._('games', '/games');
  static const createGame = AppRoutes._('create-game', 'create-game');

  final String name;
  final String path;
}
