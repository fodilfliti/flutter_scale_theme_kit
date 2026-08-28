# T15 — Pick one future look-kit item

## Goal

Choose **one** later item from [../future.md](../future.md). Do not implement T16–T21 until the user names that item in chat (or edits this file’s **Picked** line).

## Read first

- [../future.md](../future.md)
- [../invariants.md](../invariants.md)

## Picked

**T16** (widget states). Theme switcher in `example/` is demo-only (`themeMode` + Switch), not a package widget.

## Files

- this file only until a pick exists

## Steps

1. User names one row from [../future.md](../future.md).
2. Set **Picked** above to that task id.
3. Implement **only** that `T16`–`T21` file. Do not start the others.

## Tests

None (gate).

## Done when

**Picked** is a single T16–T21 id, then that task’s own Done when applies.

## Do not

Implement two or more of T16–T21 in one pass. Spacing/scale APIs, `STCard`/`STButton`, `fromSeed` default, Figma, Cupertino.
