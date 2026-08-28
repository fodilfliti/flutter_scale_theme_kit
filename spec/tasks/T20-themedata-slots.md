# T20 — Remaining ThemeData look slots

Blocked until [T15](T15-pick.md) names this task.

## Goal

Map tokens into Flutter 3.29+ slots apps actually use: `carouselViewTheme`, `menuTheme` / `menuBarTheme` / `menuButtonTheme`, `bannerTheme`, `dataTableTheme`, and/or `actionIconTheme`. Add a slot only with a test.

`pageTransitionsTheme`, `splashFactory`, `visualDensity` — only if the pick names them; they are look-adjacent, not size.

## Read first

- [../future.md](../future.md)
- [../material-map.md](../material-map.md)
- [../invariants.md](../invariants.md)

## Files

- `st_theme_data_factory.dart`, `STComponents` if a new named slot is needed, `material-map.md`, tests

## Steps

1. Prefer existing semantic colors / existing component slots over new required constructor fields.
2. One test per new `ThemeData` field.
3. Update material-map.md.

## Do not

Fill every Flutter slot “for completeness.” Cupertino. Scale APIs.
