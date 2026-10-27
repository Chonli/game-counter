# AGENTS.md

Single-package Flutter app (Dart SDK ^3.13; CI pins Flutter 3.47.8, Android uses AGP 9.1 + built-in Kotlin).
Package name `score_counter`, entrypoint `lib/main.dart`. Android is the primary build target
(no need to check iOS/Windows/Linux/macOS builds).

## Commands

- Setup: `flutter pub get`
- Codegen (required after editing any `@riverpod`, `@GenerateAdapters`, or `@MappableClass` file):
  `dart run build_runner build --delete-conflicting-outputs`
- Verify in CI order: `dart analyze` → `flutter test`
  (`riverpod_lint` is a native analyzer plugin now — see the `plugins:` section of
  `analysis_options.yaml` — so it runs inside `dart analyze`; there is no `dart run custom_lint` step anymore)
- Single test: `flutter test test/notifier/games_test.dart`
- Release: push a `v*` tag (builds obfuscated appbundle → Google Play internal track). Don't do this casually.

## Architecture (lib/)

- `data/entities/` — Hive CE persistence objects (`*Entity`), adapters generated via `@GenerateAdapters` in `hive_adapters.dart`. `hive_adapters.g.yaml` is the schema used for auto-migration; existing entities are versioned — don't rename/retype fields casually.
- `data/sources/` — DAOs over Hive boxes; `data/repositories/` — repositories wrapping DAOs.
- `model/` — pure domain objects with `dart_mappable` mappers (`.mapper.dart`). Domain models and Hive entities are deliberately separate types; map between them at the repository boundary.
- `notifier/` — global Riverpod notifiers; `module/<feature>/` — feature UI plus feature-scoped notifiers. State = hooks_riverpod + codegen (`@riverpod class X extends _$X`); widgets use flutter_hooks.
- `router/` — go_router; `l10n/` — ARB files (`app_en.arb`, `app_fr.arb` — keep both in sync).

## Quirks

- Never hand-edit generated files: `*.g.dart`, `*.mapper.dart`, `lib/l10n/app_localizations*.dart`, `hive_registrar.g.dart`.
- After adding/changing ARB strings run `scripts/gen_l10n.sh` (needs `arb_utils` activated globally: `dart pub global activate arb_utils`); it sorts ARBs then runs `flutter gen-l10n`.
- Tests use `mocktail` (shared mocks in `test/common/mock.dart`). DAO tests open a real Hive box on disk (`Hive.init` + `registerAdapters` in `setUpAll`) — no mocks there, and they clean up in `tearDownAll`.
- Hive boxes (`'games'`, `'preferences'`) are opened in `main()` before `runApp`; DAO providers `Hive.box(...)` at build time, so providers/DAO tests need the box opened first.
- `download/`, `scripts/update_objectbox_lib.sh`, and `obfuscation_debug_files/` are legacy/release artifacts — storage is Hive CE, not ObjectBox. Ignore `custom_lint.log` and `build/`.
