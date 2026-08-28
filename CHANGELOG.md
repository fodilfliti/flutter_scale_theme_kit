# Changelog

All notable changes to this project will be documented in this file.

## [1.0.1] - 2026-08-28

First publishable look companion to [`flutter_scale_kit`](https://pub.dev/packages/flutter_scale_kit) **2.0.0**. Independent — no runtime dependency on Scale Kit.

### Added

- `STTheme` / `STColor` / `STColors` with authored light/dark (no `ColorScheme.fromSeed` default).
- Material `ThemeData` projection + `ThemeExtension` so `context.st` works from `MaterialApp(theme: st.light, darkTheme: st.dark)`.
- `STComponents` for production Material widgets (buttons, FAB, chip, nav, dialog, search, slider, pickers, …).
- Typed extras: `STExtra` (`button` / `card` / `container` / `text`), `context.st.label` / `sublabel` / `description`.
- `STComponent.states` (hover / press / focus / disabled / selected) → `WidgetStateProperty` on `toButtonStyle()`. Unauthored disabled uses 38% alpha on the rest color.
- `STThemeModeScope` / `context.stMode` / `STThemeModeSwitch` to switch the **app** light/dark/system mode.
- Generator: `dart run flutter_scale_theme_kit:generate` (Dart extras → getters, or JSON → `STTheme`). `watch` supported.
- Consumer Agent Skill: `skills/flutter-scale-theme-kit/` (`npx skills add fodilfliti/flutter_scale_theme_kit`).
- Merge recipe with Scale Kit: `appST.light.copyWith(textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme))` (same for dark).

### Notes

- No `STCard` / `STButton`. Stock Flutter and SK widgets inherit look from `ThemeData`.
- `example/` may path-depend on sibling `flutter_scale_kit`; `lib/` must not.
