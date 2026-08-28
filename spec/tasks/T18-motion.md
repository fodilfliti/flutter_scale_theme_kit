# T18 — Motion tokens

Blocked until [T15](T15-pick.md) names this task.

## Goal

Duration + curve on the theme extension: `context.st.motion.fast` (and `md` / `slow` or similar). Used by app animations, not by inventing page-route defaults unless you also map `pageTransitionsTheme` in a later slot task.

## Read first

- [../future.md](../future.md)
- [../tokens.md](../tokens.md)
- [../invariants.md](../invariants.md)

## Files

- new `STMotion` (or fields on typography/theme), `STThemeExtension`, `STResolved`, tests, spec

## Steps

1. Unscaled durations (ms) + `Curve`s; lerp in the extension.
2. Defaults that match Material-ish motion if omitted.
3. Do not depend on scale_kit.

## Tests

`context.st.motion` available from `MaterialApp(theme: st.light)`. copyWith/lerp do not throw.

## Do not

Spacing tokens. Custom Navigator wrappers.
