# T06 — STTheme ThemeData factory + ThemeExtension

## Goal

`STTheme.light` / `.dark` produce complete v1 `ThemeData` plus `STThemeExtension`.

## Read first

- [../material-map.md](../material-map.md)
- [../package.md](../package.md)
- [../invariants.md](../invariants.md)

## Files

- `lib/src/theme/st_theme.dart`
- `lib/src/theme/st_theme_data_factory.dart`
- `lib/src/theme/st_theme_extension.dart`
- barrel
- `test/st_theme_data_test.dart`

## Steps

1. `STThemeExtension extends ThemeExtension<STThemeExtension>` holding resolved colors, radius, shadows, components, extra maps. Implement `copyWith` and `lerp` (lerp colors; snap radius).
2. Factory sets every v1 slot in material-map.md (`useMaterial3: true`).
3. Button themes use `*Button.styleFrom` with fill/foreground/shape.
4. Input: `OutlineInputBorder` with border color and radius.
5. Card shape: `RoundedRectangleBorder` with component/radius.md.

## Tests

Pump `MaterialApp(theme: st.light)`:

- `theme.scaffoldBackgroundColor` == background light
- `theme.colorScheme.primary` == primary light
- `theme.cardTheme.color` or cardTheme follows surface/card.fill
- `theme.extensions` contains `STThemeExtension`
- dark theme uses dark STColor values
- still no `fromSeed` in lib

## Done when

`STTheme` exported with `.light` and `.dark`.

## Do not

`context.st` (T07). Do not add STCard.
