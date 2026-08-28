# T09 — Independence

## Goal

Prove this package does not pull scale_kit.

## Read first

- [../invariants.md](../invariants.md)

## Files

- `test/independence_test.dart`
- optionally a small script comment in the test

## Steps

1. Assert `pubspec.yaml` dependencies do not contain `flutter_scale_kit`, `provider`, `material_color_utilities` (read the file in a test, or document that CI grep is enough — prefer a test that reads `pubspec.yaml` from the package root via `File` relative to the test).
2. Grep: no `package:flutter_scale_kit` in `lib/`.
3. A widget test that **only** imports `flutter` + `flutter_scale_theme_kit` and builds `MaterialApp(theme: st.light)`.

## Tests

As above.

## Done when

Independence test passes.

## Do not

Add scale_kit to package pubspec “for convenience”.
