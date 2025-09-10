import 'package:go_router/go_router.dart';

extension GoRouterStateExtension on GoRouterState {
  String get gameId => pathParameters['gameId'] ?? '-1';

  String get roundId => pathParameters['roundId'] ?? '-1';
}
