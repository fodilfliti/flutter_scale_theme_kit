# T21 — Extra kinds + optional adapters

Blocked until [T15](T15-pick.md) names this task.

## Goal

Generate more Flutter constructor types from extras: **icon** → `IconThemeData`, **input** → `InputDecoration` (focused/error). Optional: high-contrast authored theme; dynamic-color **adapter** with brand fallback (never default `fromSeed`).

## Read first

- [../future.md](../future.md)
- [../generate.md](../generate.md)
- [../invariants.md](../invariants.md)

## Files

- `STKind` / generate scan+emit, `STResolved` helpers, tests, generate.md

## Steps

1. Additive kinds; existing button/card/container/text keep working.
2. CLI stays `generate [watch] [file]`. No `build_runner`.
3. Dynamic color only as explicit opt-in helper, not `STTheme` default.

## Do not

Figma. Runtime JSON loader. `STCard`/`STButton`. `ColorScheme.fromSeed` as the primary path.
