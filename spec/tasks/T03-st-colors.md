# T03 — STColors + extras

## Goal

Semantic color set + extra map.

## Read first

- [../tokens.md](../tokens.md)

## Files

- `lib/src/tokens/st_colors.dart`
- barrel export
- `test/st_colors_test.dart`

## Steps

1. Fields per tokens.md. Required: `primary`, `surface`, `background`, `text`. Defaults for the rest as specified.
2. `STColor? extraColor(String name)` from `extra` map then named fields (so `color('primary')` works).
3. Unknown name: `assert` in debug; return `primary` in release.

## Tests

- defaults: secondary == primary when omitted
- extra `'brand'` resolves
- `error` default const pair used when omitted

## Done when

Barrel exports `STColors`.

## Do not

ColorScheme mapping (T05).
