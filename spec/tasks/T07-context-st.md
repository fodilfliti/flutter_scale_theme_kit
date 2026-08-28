# T07 — context.st

## Goal

Short access API.

## Read first

- [../tokens.md](../tokens.md)
- [../invariants.md](../invariants.md)

## Files

- `lib/src/theme/st_resolved.dart` (if not already)
- `lib/src/theme/st_scope.dart`
- `lib/src/theme/st_context.dart`
- barrel
- `test/st_context_test.dart`

## Steps

1. `STResolved` with getters: `primary`, `secondary`, `surface`, `background`, `border`, `divider`, `text`, `textSecondary`, `error`, `success`, `warning`, `info`.
2. `radius` (`STRadius` or resolved wrapper with `md` / `mdValue`), `shadow.sm` etc.
3. `color(String name)`, `container(String name)` → `STResolvedComponent`.
4. `STScope` InheritedWidget wrapping `STTheme` or `STResolved`.
5. `extension STBuildContext on BuildContext { STResolved get st; }` — Scope first, else `Theme.extension<STThemeExtension>()`. Missing: `FlutterError`.

## Tests

Widget test: `MaterialApp(theme: st.light, home: Builder(builder: (c) { expect(c.st.surface, ...); return const SizedBox(); }))`.

- shortcuts match tokens
- `radius.md` is BorderRadius
- STScope override changes `context.st.primary` in subtree

## Done when

`context.st.surface` works without STScope when theme is set.

## Do not

Deep nested APIs.
