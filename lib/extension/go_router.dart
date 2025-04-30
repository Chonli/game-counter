import 'package:go_router/go_router.dart';

extension GoRouterStateExtension on GoRouterState {
  int get gameId => int.tryParse(pathParameters['gameId'] ?? '-1') ?? -1;

  int get roundId => int.tryParse(pathParameters['roundId'] ?? '-1') ?? -1;
}
