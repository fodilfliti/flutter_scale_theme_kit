# JSON / Dart generation

JSON is **optional input**. Hand-written Dart `STTheme` is the usual contract. Do not load JSON at runtime. Do not put `dart:io` in `lib/`.

## Why

Apps need extra buttons, cards, containers, colors, and text roles. Named Material slots are not enough. Generate a short `context.st` API:

```dart
context.st.brand                 // Color
context.st.ghostButtonStyle      // ButtonStyle
context.st.productCardDecoration // BoxDecoration
context.st.price                 // TextStyle
context.st.label                 // typography (not generated)
```

without `STButton` / `STCard` widgets.

## Runtime (always available)

`STExtra.*`, `STColors.extra`, `context.st.extraButton('ghost')`, `context.st.color('brand')`. Helpers: `toButtonStyle()` (including `STComponent.states` → `WidgetStateProperty`), `toBoxDecoration()`.

## CLI (simple)

```text
dart run flutter_scale_theme_kit:generate [watch] [file]
```

- **`.dart`** — scan `STExtra.*`, `'name': STColor`, `'name': STComponent`. Write **getters only** (`design.g.dart`). Does not rewrite `appST`. Default `part of` the input basename. Add `part 'design.g.dart';` in the source file.
- **`.json`** — emit full `STTheme` + the same getters.
- **omit file** — `lib/design.dart`, `design.dart`, or `st_theme.json`.
- **`watch`** — regenerate when the input file changes.

Core parse/emit has no Flutter (`generate_core.dart`). `bin/generate.dart` may use `dart:io`.

Generated extra getters (Flutter constructors):

| Kind | Getters |
| --- | --- |
| extra color | `Color get brand` |
| button | component + `ButtonStyle` (`ElevatedButton` / `FilledButton` / …) |
| card / container | component + `BoxDecoration` + fill `Color?` |
| text | `TextStyle` |

Getter names: `ghost` + button → `ghostButton`. Collisions with `STResolved` members get a suffix.

## Do not

Figma. Runtime JSON. `STCard` / `STButton`. `build_runner`. Overwrite the user’s `STTheme`.
