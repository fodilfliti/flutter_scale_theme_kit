# T17 — Unscaled TextTheme type scale

Blocked until [T15](T15-pick.md) names this task.

## Goal

Designer-owned **display / title / body** (and caption if needed) as unscaled `fontSize` tokens mapped onto Material `TextTheme` roles. Keep `label` / `sublabel` / `description`. Do **not** call `.sp` in `lib/`.

## Read first

- [../future.md](../future.md)
- [../tokens.md](../tokens.md)
- [../companion.md](../companion.md)
- [../invariants.md](../invariants.md)

## Files

- `STTypography`, theme factory `_coloredTextTheme`, tests, spec/tokens.md

## Steps

1. Optional size/weight tokens per Material-ish role; omit = current color-only textTheme.
2. Dual-package apps still use `createResponsiveTextTheme` in the **app**.
3. Document: numbers are design-px.

## Tests

Custom `title` size appears on `ThemeData.textTheme.titleLarge` (or the role you map). No scale_kit import in lib.

## Do not

Implement FontConfig. Scale font sizes here. Replace extra text roles.
