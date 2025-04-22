class AppRoute {
  const AppRoute._(this.path, this.name);

  final String path;
  final String name;

  // Home route
  static const root = AppRoute._('/', 'root');
  static const preferences = AppRoute._('/preferences', 'preferences');
  static const addGame = AppRoute._('addGame', 'addGame');
  static const activeGame = AppRoute._('activeGame', 'activeGame');
  static const addRound = AppRoute._('addRound', 'addRound');
}
