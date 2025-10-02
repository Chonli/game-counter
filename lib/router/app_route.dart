class AppRoute {
  const AppRoute._(this.path, this.name);

  final String path;
  final String name;

  // Home route
  static const root = AppRoute._('/', 'root');
  static const preferences = AppRoute._('/preferences', 'preferences');
  static const addGame = AppRoute._('addGame', 'addGame');
  static const updateGame = AppRoute._('updateGame/:gameId', 'updateGame');
  static const activeGame = AppRoute._('activeGame/:gameId', 'activeGame');
  static const addRound = AppRoute._('addRound/:roundId', 'addRound');
  static const chart = AppRoute._('chart', 'chart');
}
