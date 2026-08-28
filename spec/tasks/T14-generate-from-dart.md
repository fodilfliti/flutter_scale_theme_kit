# T14 — Generate typed getters from Dart extras

## Goal

Users who write `STTheme` by hand (`STExtra.button('ghost', …)` in `design.dart`) can generate **only** the short `context.st` getters (`ghostButton`, `ghostButtonStyle`, `productCard`, `price`). They should not have to use JSON or call `extraButton('ghost')`.

Today: JSON → full `STTheme` Dart + extension (T13). Dart-only extras have no `ghostButton` unless the user writes the extension.

## Read first

- [../generate.md](../generate.md)
- [../invariants.md](../invariants.md)
- [T13-generate.md](T13-generate.md) (already done; do not redo JSON → full theme)

## Files

- `lib/src/generate/` — parse extras from Dart, emit extension only
- `bin/generate.dart` — new CLI flag
- `test/st_generate_test.dart` — fixture Dart snippet
- `spec/generate.md` — document the Dart path
- `example/` — optional demo after tests pass (`part` + gallery using `ghostButton`)

## Steps

1. Emit **extension only** from a list of extras (`name` + `kind`). Reuse existing getter rules (`ghost` + button → `ghostButton`). Do **not** overwrite the user’s `STTheme` / `appST`.
2. CLI input is a Dart file that contains `STExtra.button('…')` / `.card(` / `.container(` / `.text(`. Parse names + kinds only (no full Dart analyzer package unless it stays a **dev** dependency of the CLI and `lib/` stays free of it).
3. Suggested CLI:

   ```text
   dart run flutter_scale_theme_kit:generate --from-dart lib/design.dart --out lib/design.extras.g.dart --part-of design.dart
   ```

   Default `--part-of` to the basename of the input Dart file when `--from-dart` is set.
4. User adds `part 'design.extras.g.dart';` next to `final appST = STTheme(extras: […])`.
5. Keep JSON → full file as-is. `--in` JSON and `--from-dart` are two inputs; do not require both.

## Tests

- Fixture Dart with `STExtra.button('ghost')`, `STExtra.card('product')`, `STExtra.text('price')` emits `ghostButton` / `productCard` / `price`.
- Does not emit `final appST = STTheme(`.
- `--part-of` emits `part of 'design.dart';` and no imports.
- Invalid / missing names throw `FormatException`.
- `generate_core` still has no Flutter / `dart:io`.

## Done when

`flutter analyze` and `flutter test` are clean. README has a short “from Dart extras” recipe.

Implemented: Dart scan + extension-only emit, extra **colors**, card/container **Color?** fill, simple CLI (`generate [watch] [file]`). See [../generate.md](../generate.md).

## Do not

- Parse or rewrite the whole `STTheme` constructor.
- Add `build_runner` / codegen annotations unless the user asks.
- Figma. Runtime JSON. `STCard` / `STButton`.
- Change `extraButton('ghost')` — it stays the runtime API; getters are sugar.
