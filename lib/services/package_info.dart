import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info.g.dart';

@Riverpod(keepAlive: true)
AppPackageInfo packageInfo(Ref ref) {
  throw UnimplementedError();
}

class AppPackageInfo {
  const AppPackageInfo(this.plugin);

  final PackageInfo plugin;

  String get version => plugin.version;

  String get buildNumber => plugin.buildNumber;

  String get fullVersion => '${plugin.version}+${plugin.buildNumber}';
}
