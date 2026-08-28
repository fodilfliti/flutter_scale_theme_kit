# API map (usage)

Import: `package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart`

## Tokens

`STTheme(colors:, radius:, shadows:, typography:, components:, extras:)`  
`STColor(light:, dark:)` — omit `dark` → reuse light  
`STColors` — required `primary`, `surface`, `background`, `text`  
`STRadius` `STShadows` `STTypography` / `STTextToken`  
`STComponent` / `STComponentStates` / `STComponents`  
`STExtra.button/card/container/text`

`appST.light` / `appST.dark` → `ThemeData` (includes `ThemeExtension`)

## Access

`context.st` — `STResolved`  
Colors: `primary` `secondary` `surface` `background` `border` `divider` `text` `textSecondary` `error` `success` `warning` `info`  
`context.st.color('brand')`  
`context.st.radius.md` (`BorderRadius`) / `mdValue` (`double`)  
`context.st.shadow.sm`  
`context.st.label` `sublabel` `description`  
`context.st.card` `fab` `chip` … `container('dialog')`  
`extraButton` / `extraCard` / `extraContainer` / `extraText`  
`toButtonStyle()` / `toBoxDecoration()`

## Theme mode (optional)

`STThemeModeScope(builder: (context, mode) => MaterialApp(themeMode: mode.mode, …))`  
`context.stMode.setMode` `setDark` `toggle` `cycle` `isDark`  
`STThemeModeSwitch`

## Generate

```bash
dart run flutter_scale_theme_kit:generate [watch] [file]
```

`.dart` → getters only (`ghostButtonStyle`, `brand`, …). `.json` → full `STTheme` + getters. Runtime does not load JSON.

## Merge with Scale Kit

```dart
appST.light.copyWith(
  textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme),
)
```

Same for `appST.dark`. Never `ResponsiveThemeData.create` as the full theme.

## Do not

`STButton` `STCard` `ColorScheme.fromSeed` as default  `.w` / `.sp` in this package  `provider`
