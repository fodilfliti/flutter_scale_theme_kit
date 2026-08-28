# T19 — Debug contrast + gallery states

Blocked until [T15](T15-pick.md) names this task.

## Goal

Debug-only WCAG-style checks (`text` vs `surface`, ink vs fill). Do not auto-invent dark colors. Optional gallery coverage: disabled, dark, text scale. High-contrast `MediaQuery` variant is optional and must stay authored.

## Read first

- [../future.md](../future.md)
- [../invariants.md](../invariants.md)
- [../tokens.md](../tokens.md)

## Files

- small contrast helper in `lib/` (no new deps), tests, example gallery states

## Steps

1. `assert` in debug when contrast is poor; never crash release.
2. Document that ink-from-luminance is readability, not a palette.
3. Gallery: at least disabled control + dark mode already exists; add textScale if cheap.

## Tests

Helper returns a ratio; known-good pair passes; known-bad can assert in debug test.

## Do not

Change authored `STColor.dark`. Add `fromSeed`. Require a high-contrast theme in v1 of this task unless the user asked in the pick.
