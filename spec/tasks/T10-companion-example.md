# T10 — Companion example recipe

## Goal

Example app shows scale_kit **and** theme kit together without using `ResponsiveThemeData.create` as the sole theme.

## Read first

- [../companion.md](../companion.md)

## Files

- `example/pubspec.yaml` — add `flutter_scale_kit` path `../../flutter_scale_kit` or `../flutter_scale_kit` (sibling of this package).
- `example/lib/main.dart` — recipe from companion.md (can share gallery with T11; this task requires SKCard / SKit.roundedContainerSize + stock ElevatedButton + context.st).
- Keep `spec/companion.md` accurate if the snippet drifts.

## Steps

1. `initScaleKit()` in example or inline `setRadiusSizes` / `setPaddingSizes`.
2. `ScaleKitBuilder` → `Builder` → `MaterialApp` with `copyWith(createResponsiveTextTheme)`.
3. One screen: `SKCard`, `SKit.roundedContainerSize(color: context.st.surface)`, `ElevatedButton` with no extra colors.

## Tests

`example` analyzes. Manual: run example (agent: `flutter analyze` in example/).

## Done when

example depends on both packages; package `lib/` still does not.

## Do not

Import scale_kit from `../lib`.
