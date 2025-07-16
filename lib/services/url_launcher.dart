import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart' as url;

part 'url_launcher.g.dart';

@riverpod
AppUrlLauncher urlLauncher(Ref ref) {
  return AppUrlLauncher();
}

class AppUrlLauncher {
  const AppUrlLauncher();

  Future<void> launch(String path) => url.launchUrl(Uri.parse(path));
}
