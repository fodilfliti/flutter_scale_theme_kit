# T04 — Radius, shadows, typography, components

## Goal

Remaining token types. Raw doubles only.

## Read first

- [../tokens.md](../tokens.md)

## Files

- `lib/src/tokens/st_radius.dart`
- `lib/src/tokens/st_shadows.dart`
- `lib/src/tokens/st_typography.dart`
- `lib/src/tokens/st_component.dart`
- barrel exports
- `test/st_tokens_test.dart`

## Steps

1. `STRadius` — doubles xs–xl; getters `md` = `BorderRadius.circular(mdValue)`, `mdValue` = double. Implement for xs/sm/md/lg/xl.
2. `STShadows` — default sm/md/lg BoxShadow lists.
3. `STTypography` — optional `fontFamily`.
4. `STComponent` + `STComponents` (card, button, input, appBar + extra map).
5. `STResolvedComponent` can live here or in theme (T06/T07) — if here, keep it a simple resolved-color struct.

## Tests

- `STRadius().md` is `BorderRadius.circular(12)` with default md=12
- `mdValue == 12`
- extra component map stores `highlighted`

## Done when

Types exported; no Flutter scaling APIs.

## Do not

ThemeData factory.
