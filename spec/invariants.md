# Invariants

Break these and the package lies to users. Tests should cover them when you touch the related code.

## Package independence

`lib/` and the package `pubspec.yaml` **must not** depend on `flutter_scale_kit`, `provider`, or `material_color_utilities`.

`example/` may path-depend on `flutter_scale_kit`. Tests under `test/` must not import scale_kit.

## No scaling system

Do not add `.w`, `.h`, `.sp`, `.rSafe`, breakpoints, device detection, or `SK*` widgets in this package. Radius/padding numbers are **design-px**, unscaled.

## Dark colors are authored

`STColor(light: x)` uses `x` in dark mode. Never invent a dark color (no seed, no auto-shift, no invert). `dark:` is the only way to get a different dark value.

Contrast ink (`onPrimary`, `onError`) may pick black or white from **luminance of the already-resolved fill**. That is readability, not a generated palette.

## ThemeExtension is the access path

Every `STTheme.light` / `.dark` `ThemeData` **must** include `ThemeExtension<STThemeExtension>` so `context.st` works with only:

```dart
MaterialApp(theme: st.light, darkTheme: st.dark)
```

`STScope` is optional (subtree override, tests, access above `MaterialApp`). Lookup order: `STScope` → `ThemeExtension`. Missing both: throw a clear FlutterError in debug.

Optional [STThemeModeScope] owns `MaterialApp.themeMode` so `context.stMode` can switch the app. It is not a token store.

## Short API

Common colors are getters on `context.st` (`primary`, `surface`, `border`, `text`, …). Do not force `context.st.colors.tokens.surface`.

`context.st.radius.md` is `BorderRadius`. `context.st.radius.mdValue` is `double`.

`context.stMode` is the optional [STThemeModeController] (not a color token).

## Default Flutter widgets get look from ThemeData

v1 mapped widgets (see [material-map.md](material-map.md)) must pick up fill/background from `ThemeData` with **no** per-widget color when the user uses stock constructors (`Card()`, `ElevatedButton()`, `Scaffold()`).

`Container` and `SKit.roundedContainerSize` have no Material theme. Callers pass `color: context.st.surface` (documented, not a bug).

## No competing widget family in v1

Do not add `STCard`, `STButton`, `STContainer`, `STInput` in v1. They compete with Flutter widgets and with scale_kit `SK*` / `SKit`.

## ColorScheme is filled from tokens, not fromSeed

`STTheme` must not call `ColorScheme.fromSeed` as the default path. Map semantic tokens → `ColorScheme` using [material-map.md](material-map.md).

## Public API

Public runtime API = what `lib/flutter_scale_theme_kit.dart` exports. Generator API = `lib/generate.dart` (parse/emit only; no `dart:io`). Do not export a class named `ScaleThemeData`. `bin/generate.dart` may use `dart:io`.

## Tests to extend when you touch

`test/` — color resolve, ColorScheme fill, ThemeData slots, `context.st`, extras, generate, independence (no scale_kit or `dart:io` in lib). If you add a v1 ThemeData slot, add a test that the corresponding theme field follows the token.
