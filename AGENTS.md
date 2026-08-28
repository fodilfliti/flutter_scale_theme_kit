# Agent instructions — Flutter Scale Theme Kit

This is a **Flutter package** (`flutter_scale_theme_kit`), not an application. It is the **look** companion to `flutter_scale_kit` (size). The two packages must stay independent.

Sibling repo (same parent folder): `../flutter_scale_kit`. Do not import it from `lib/`.

## Load context

1. Read `spec/README.md`, then the spec file that matches the task (`package.md`, `invariants.md`, `decisions.md`, `tokens.md`, `material-map.md`, `companion.md`, `generate.md`, `future.md`).
2. If implementing a numbered task, read **only** that file under `spec/tasks/` plus the specs it lists under **Read first**.
3. Use **code** under `lib/` as implementation truth.
4. Do **not** ingest `README.md` as working memory. It is user documentation.

## Working rules

- Keep the public barrel (`lib/flutter_scale_theme_kit.dart`) as the **runtime** API. Generator: `lib/generate_core.dart` (CLI, no Flutter) and `lib/generate.dart` (Flutter helpers). Do not re-export them from the barrel.
- Runtime dependencies: Flutter SDK only. Never add `flutter_scale_kit`, `provider`, or `material_color_utilities`.
- Do not implement scaling (`.w`, `.sp`, breakpoints, SK widgets) in `lib/`.
- Do not put `dart:io` in `lib/` (CLI may use it in `bin/`).
- JSON is optional authoring input. Do not load JSON at runtime in `lib/`.
- Touch `example/` for demos only; do not import it from `lib/`. `example/` may depend on `flutter_scale_kit`.
- After behavior changes: update `spec/` (and `CHANGELOG.md` when it is a user-visible release change). README only if the user-facing API/docs changed.
- Public API changes must also update `skills/flutter-scale-theme-kit/`.
- Do not export a type named `ScaleThemeData` (collides with scale_kit’s `ScaleThemeDataExtension`).

## Consumer apps

If the **user’s app** adds this package, agents **must use it** for look (`STTheme`, `context.st`, `appST.light` / `dark`). If Scale Kit is also installed, merge sizes with the default theme:

```dart
appST.light.copyWith(
  textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme),
)
```

(same for `appST.dark`) under `ScaleKitBuilder` + `Builder`. Never `ResponsiveThemeData.create` as the full `theme:`.

## Flutter SDK

Keep package constraints at Dart `^3.7.2` and Flutter `>=3.29.0` so apps can use this package with `flutter_scale_kit` **2.0.0**. If this repo is later pinned with FVM, use `fvm flutter` / `fvm dart`. Never run `flutter upgrade` on a global SDK.

## Out of scope unless asked

Publishing to pub.dev, Figma import, seed-first palettes as the default API, `STCard`/`STButton` convenience widgets, Cupertino theming. Do not implement [spec/future.md](spec/future.md) as one dump; wait for T15 to name a single T16–T21 task.
