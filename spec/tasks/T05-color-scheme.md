# T05 — ColorScheme fill table

## Goal

Map `STColors` + brightness → full `ColorScheme` without `fromSeed`.

## Read first

- [../material-map.md](../material-map.md)

## Files

- `lib/src/theme/st_color_scheme.dart` (or factory helper)
- `test/st_color_scheme_test.dart`

## Steps

1. `ColorScheme stColorScheme(STColors colors, Brightness brightness)` implementing the table in material-map.md.
2. `ink(Color fill)` luminance rule as specified.
3. If `ColorScheme` constructor needs extra M3 fields (fixed/dim), set them equal to the related semantic color.

## Tests

- `outline == border.resolve`
- `onSurface == text.resolve`
- `brightness` matches argument
- `primary` matches token
- `surfaceContainerLowest == background`
- grep `lib/` for `fromSeed` — must not appear

## Done when

Helper is tested; not yet wired to MaterialApp (T06).

## Do not

Call `ColorScheme.fromSeed`.
