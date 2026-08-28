# Flutter Scale Theme Kit

Pub package `flutter_scale_theme_kit` (**1.0.1**). Lightweight **look** layer for Flutter: semantic colors, light/dark tokens, component visual defaults, and Material `ThemeData` generation.

Constraints: Dart `^3.7.2`, Flutter `>=3.29.0`. Match `flutter_scale_kit` **2.0.0** so apps can install both. Do not raise the Dart floor to 3.13.

Sibling folder: `../flutter_scale_kit` (size). Do not import it from `lib/`.

Runtime dependencies: **Flutter SDK only**.

## What it is / is not

- **Is:** design tokens + `context.st` shortcuts + `ThemeData` projection so stock Flutter widgets (and SK widgets, if present) look consistent.
- **Is not:** a scaling/responsive engine, a second `.w`/`.sp` system, a required widget kit (`STCard`), a seed-based Material palette generator, or a Figma importer. JSON is optional **input** for codegen, not a runtime format.

Philosophy:

- `flutter_scale_kit` = how the UI **sizes**
- `flutter_scale_theme_kit` = how the UI **looks**

## Layout

```
lib/flutter_scale_theme_kit.dart    public barrel (runtime)
lib/generate.dart                   JSON → STTheme (Flutter)
lib/generate_core.dart              JSON → Dart source (no Flutter; CLI)
lib/src/color/                      STColor
lib/src/tokens/                     colors, radius, shadows, typography, components, extras
lib/src/theme/                      STTheme, ThemeData factory, ThemeExtension, scope, context.st
lib/src/generate/                   parse + emit (no dart:io)
bin/generate.dart                   CLI
example/                            demo (may depend on flutter_scale_kit)
test/                               package tests
spec/                               agent memory (this folder)
```

## Runtime architecture

```
STTheme (tokens, brightness-independent)
        │
        ├─ light / dark  →  ThemeData
        │                     ├─ ColorScheme, component themes
        │                     └─ ThemeExtension<STThemeExtension>  (resolved colors)
        │
        └─ context.st  ←  ThemeExtension, or optional STScope override
```

Optional: `STThemeModeScope` → `MaterialApp.themeMode`; descendants use `context.stMode` / `STThemeModeSwitch`.

No `provider`. Look tokens are not a ChangeNotifier. Light/dark switching is optional [STThemeModeScope]; you can still pass `themeMode` yourself.

## Public surface

| Area | Types / entry points |
| --- | --- |
| Color pair | `STColor` (`light` required, `dark` optional → light) |
| Palettes | `STColors`, `STRadius`, `STShadows`, `STTypography`, `STComponent` / `STComponentStates`, `STComponents`, `STExtra` / `STKind` / `STTextToken` |
| Theme | `STTheme` → `.light` / `.dark` (`ThemeData`), `extras` |
| Access | `context.st` (`STResolved`) including `label` / `extraButton` / `extraCard` / `extraContainer` / `extraText` |
| Theme mode | `STThemeModeScope`, `context.stMode`, `STThemeModeSwitch` (optional) |
| Optional | `STScope` (override / tests / above `MaterialApp`) |
| Extras | `context.st.color('brand')`, `context.st.container('highlighted')`, typed extras |
| Generate | `package:flutter_scale_theme_kit/generate.dart` + `dart run flutter_scale_theme_kit:generate` |

Public exports live in `lib/flutter_scale_theme_kit.dart`. The generator is extra libraries: `lib/generate_core.dart` (CLI, no Flutter) and `lib/generate.dart` (Flutter `STTheme` conversion).

## Usage levels

1. **Flutter widgets + tokens** — `Container` / `Card` / `ElevatedButton` with `context.st.*` or inherited `ThemeData`.
2. **Shortcuts** — `context.st.surface`, `context.st.radius.md`.
3. **No ST\* widgets in v1** — use Flutter widgets or scale_kit `SK*` / `SKit`.

## Out of v1

Figma import, `STColors.fromSeed` as default, Cupertino, `STCard`/`STButton`. Material widget ThemeData slots are mapped in [material-map.md](material-map.md). JSON generation is in [generate.md](generate.md). Ranked post-v1 look work (states, type scale, motion, …) is in [future.md](future.md); do not implement it as one dump.
