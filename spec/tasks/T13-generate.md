# T13 — Typed extras + JSON generator

## Goal

Users can define extra buttons, cards, containers, and text roles. Optional JSON generates a short typed Dart API.

## Read first

- [../generate.md](../generate.md)
- [../tokens.md](../tokens.md)
- [../invariants.md](../invariants.md)

## Files

- `lib/src/tokens/st_extra.dart`, `st_typography.dart`
- `lib/src/theme/*` resolve extras
- `lib/src/generate/*`, `lib/generate.dart`, `bin/generate.dart`
- `test/st_extras_test.dart`, `test/st_generate_test.dart`

## Steps

1. `STKind` / `STExtra` / `STTextToken`; `STTheme.extras`; typography `label` / `sublabel` / `description`.
2. Resolve onto the extension. `context.st.extraButton('ghost')`, `extraText('price')`, `context.st.label`.
3. `toButtonStyle` / `toBoxDecoration` on `STResolvedComponent`.
4. JSON parse + Dart emit (no `dart:io` in `lib/`). CLI writes a file.
5. Keep `STComponents.extra` as untyped containers.

## Tests

Typed extras on `context.st`. JSON fixture emits `ghostButton` / `productCard` / `price`. Missing `kind` throws. `lib/` has no `dart:io`.

## Done when

`flutter analyze` and `flutter test` are clean.

## Do not

Figma. Runtime JSON. `STCard` / `STButton`. Import generate from the main barrel.
