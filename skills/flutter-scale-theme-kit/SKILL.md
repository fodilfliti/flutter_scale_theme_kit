---
name: flutter-scale-theme-kit
description: >
  Use flutter_scale_theme_kit for look (STTheme, context.st, ThemeData). Size stays
  in flutter_scale_kit. If the app has flutter_scale_kit, merge fonts with
  appST.light.copyWith(textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme))
  under ScaleKitBuilder — never ResponsiveThemeData.create alone. Apply when adding
  flutter_scale_theme_kit, MaterialApp theme, context.st, extras, generate, light/dark
  switch, or when the user says init theme kit / design tokens / look companion.
license: MIT
metadata:
  author: fodilfliti
  version: "1.0.1"
  homepage: https://pub.dev/packages/flutter_scale_theme_kit
  repo: https://github.com/fodilfliti/flutter_scale_theme_kit
---

# Flutter Scale Theme Kit (consumer)

You are implementing **usage** of the pub package `flutter_scale_theme_kit`, not package internals.

Read extra files only when needed:

- Init / `MaterialApp` wiring → [init.md](init.md)
- API cheat sheet → [api.md](api.md)

## Split (never mix)

| Package | Job |
| --- | --- |
| `flutter_scale_kit` | **Size** — `ScaleKitBuilder`, `.w` / `.sp`, `SK*`, `SKit`, `FontConfig` |
| `flutter_scale_theme_kit` | **Look** — `STTheme`, `context.st`, Material `ThemeData`, `STThemeModeScope` |

Do **not** add `.w` / `.sp` / `SK*` in theme-kit token files. Do **not** put colors on every SK widget when `ThemeData` already has look.

Repos sit at the **same folder level** (`flutter_scale_kit` + `flutter_scale_theme_kit`). They do **not** depend on each other. The **app** may depend on one or both.

## Detect

1. Read app `pubspec.yaml`.
2. If `flutter_scale_theme_kit` is listed → **use it** for look (`STTheme`, `context.st`). Do not invent a parallel color system.
3. If `flutter_scale_kit` is also listed → **merge size + look** (see [init.md](init.md)). Do **not** call `ResponsiveThemeData.create` as the whole `theme:` — it drops card/button/input themes.
4. If only theme-kit → `MaterialApp(theme: appST.light, darkTheme: appST.dark)` (optional `STThemeModeScope`).

**Init immediately** when: user says init/setup theme kit, no `STTheme(`, or first `context.st`.

## Always

1. `flutter pub add flutter_scale_theme_kit` if missing
2. One `STTheme` in `lib/core/design.dart` (or `lib/design.dart`)
3. `MaterialApp(theme: appST.light, darkTheme: appST.dark)`
4. Prefer `STThemeModeScope` so `context.stMode` / `STThemeModeSwitch` can switch the app
5. Stock Flutter widgets (and SK widgets) — **no** `STButton` / `STCard`
6. Dark colors are authored (`STColor(light:, dark:)`). Never `ColorScheme.fromSeed` as the default

## With Scale Kit (both packages)

`ScaleKitBuilder` **above** `MaterialApp`. Inside a `Builder` (context must see Scale Kit):

```dart
theme: appST.light.copyWith(
  textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme),
),
darkTheme: appST.dark.copyWith(
  textTheme: appST.dark.createResponsiveTextTheme(appST.dark.textTheme),
),
```

Align radius in the **app**: `setRadiusSizes(md: 12)` and `STRadius(md: 12)`.

Containers that are not Material: `color: context.st.surface`.

## Screens

```dart
ElevatedButton(onPressed: save, child: const Text('Save')); // look from ThemeData
Text('Title', style: context.st.label);
color: context.st.surface
```

Extras: `context.st.extraButton('ghost').toButtonStyle()` or generated `context.st.ghostButtonStyle`.

Generate: `dart run flutter_scale_theme_kit:generate` after `part 'design.g.dart';`.

## Do / don't

- Do use `context.st.*` instead of hardcoded colors in screens
- Do keep `STTheme` as the single look source
- Don't wrap SK widgets with extra `color:` when Card/Button already inherit `ThemeData`
- Don't load JSON at runtime; generate Dart
- Don't invent APIs — read [api.md](api.md)
