# T02 — STColor

## Goal

`STColor` with explicit light/dark and fallback.

## Read first

- [../tokens.md](../tokens.md)
- [../invariants.md](../invariants.md)

## Files

- `lib/src/color/st_color.dart`
- export from barrel
- `test/st_color_test.dart`

## Steps

1. `const STColor({required Color light, Color? dark})`.
2. `Color resolve(Brightness brightness)` — dark mode uses `dark ?? light`.
3. `copyWith`. Equality (`==` / `hashCode`) on light+dark.

## Tests

- light brightness → light
- dark with dark set → dark
- dark with dark null → light
- never equals a different color pair

## Done when

Tests pass; barrel exports `STColor`.

## Do not

ThemeData, seed generation, opacity helpers that invent palettes.
