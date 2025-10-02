import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'generator_utilities.g.dart';

@riverpod
GeneratorUtility generatorUtilities(Ref ref) {
  return GeneratorUtility(Uuid());
}

class GeneratorUtility {
  const GeneratorUtility(this.uuid);

  final Uuid uuid;

  String newId() => uuid.v4();
}
