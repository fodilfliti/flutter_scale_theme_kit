# T01 — Package bootstrap

## Goal

Remove the prototype (seed + provider + scale_kit). Package analyzes with Flutter SDK as the only runtime dep.

## Read first

- [../invariants.md](../invariants.md)
- [../package.md](../package.md)

## Files

- `pubspec.yaml`
- `lib/flutter_scale_theme_kit.dart`
- delete `lib/src/scale_theme*.dart`, `lib/src/scale_component_overrides.dart`, `lib/src/annotations.dart`
- `test/flutter_scale_theme_kit_test.dart` — placeholder that compiles (or empty group)

## Steps

1. `pubspec.yaml`: `sdk: ^3.7.2`, `flutter: ">=3.29.0"`. Dependencies: `flutter` only. Remove `flutter_scale_kit`, `provider`, `material_color_utilities`.
2. Description: look companion for Flutter design tokens / ThemeData (not “new Flutter package project”).
3. Barrel: empty library with a doc comment, or a single `library;` — no broken exports.
4. Delete old `lib/src/*` files listed above.
5. Tests: `test/` must not import deleted types (`ScaleThemeConfig`, etc.).

## Tests

`flutter analyze` on package root is clean. `flutter test` passes (even if tests are placeholders).

## Done when

`pubspec.yaml` has no forbidden deps; `lib/src` has no old ScaleTheme classes.

## Do not

Add STColor yet (T02). Keep `example/` compiling if possible (may break until T10 — if example still imports old API, leave a stub `main.dart` that runs an empty `MaterialApp` so `example` analyze is not required until T10).
