# T08 — Custom extras end-to-end

## Goal

`highlighted` (or any extra component) reachable from `context.st.container`.

## Read first

- [../tokens.md](../tokens.md)

## Files

- tests only if implementation already in T03/T06/T07; otherwise wire extra components into the extension
- `test/st_extras_test.dart`

## Steps

1. Ensure `STComponents.extra['highlighted']` is copied onto `STThemeExtension`.
2. `context.st.container('highlighted').fill` is the resolved fill.
3. Unknown name: debug assert, fallback to `card` or `surface`.

## Tests

Build STTheme with extra highlighted fill; pump app; expect `context.st.container('highlighted').fill` equals resolved light color.

## Done when

Test passes.

## Do not

Codegen / `STContainer.highlighted`.
