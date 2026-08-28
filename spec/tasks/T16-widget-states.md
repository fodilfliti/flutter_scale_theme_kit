# T16 — Widget states on extras / buttons

Named by [T15](T15-pick.md). Implemented in `lib/` (states on `STComponent` → `toButtonStyle()`).

## Goal

Optional hover / press / focus / disabled / selected on `STComponent` or `STExtra.button`, mapped into `ButtonStyle` / `InputDecorationTheme` via `WidgetStateProperty`. No `STButton` widgets.

## Read first

- [../future.md](../future.md)
- [../tokens.md](../tokens.md)
- [../generate.md](../generate.md)
- [../invariants.md](../invariants.md)

## Files

- `lib/src/tokens/st_component.dart`, extras, theme factory, generate emit
- tests + example gallery disabled/pressed if useful

## Steps

1. Additive fields only (null = today’s single fill/foreground).
2. `toButtonStyle()` (and generated `*Style`) honor disabled/pressed at minimum.
3. Update spec/tokens + generate.md.

## Tests

Enabled vs disabled `ButtonStyle` colors from tokens. Analyze clean.

## Do not

Invent dark colors. Scale APIs. `STButton`. `build_runner`.

## Done when

Authored disabled/pressed colors appear on `toButtonStyle()`. Unauthored disabled fades rest alpha. `dart analyze` clean. Example gallery can switch System / Light / Dark.
