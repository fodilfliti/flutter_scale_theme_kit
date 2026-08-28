# Material map (v1)

Tokens → Flutter `ThemeData`. Do **not** use `ColorScheme.fromSeed`.

Ink on fills (`onPrimary`, `onError`, `onSecondary`, `onTertiary`, `onInverseSurface`): if the fill’s `computeLuminance() > 0.5` use `Color(0xFF1C1B1F)`, else `Color(0xFFFFFFFF)`.

## ColorScheme fill

Resolved colors at the target `Brightness`: `p` primary, `s` secondary, `surf` surface, `bg` background, `br` border, `div` divider, `tx` text, `tx2` textSecondary, `err` error.

| ColorScheme slot | Token / rule |
| --- | --- |
| brightness | argument |
| primary | p |
| onPrimary | ink(p) |
| primaryContainer | p |
| onPrimaryContainer | ink(p) |
| secondary | s |
| onSecondary | ink(s) |
| secondaryContainer | s |
| onSecondaryContainer | ink(s) |
| tertiary | info resolved (or s if you must share) |
| onTertiary | ink(tertiary) |
| tertiaryContainer | tertiary |
| onTertiaryContainer | ink(tertiary) |
| error | err |
| onError | ink(err) |
| errorContainer | err |
| onErrorContainer | ink(err) |
| surface | surf |
| onSurface | tx |
| surfaceDim | surf |
| surfaceBright | surf |
| surfaceContainerLowest | bg |
| surfaceContainerLow | surf |
| surfaceContainer | surf |
| surfaceContainerHigh | surf |
| surfaceContainerHighest | surf |
| onSurfaceVariant | tx2 |
| outline | br |
| outlineVariant | div |
| shadow | Color(0xFF000000) |
| scrim | Color(0xFF000000) |
| inverseSurface | tx |
| onInverseSurface | surf |
| inversePrimary | p |
| surfaceTint | p |

Newer optional ColorScheme fields (fixed/dim): if the constructor requires them, set equal to primary/secondary as above. Do not call `fromSeed`.

Also set:

- `scaffoldBackgroundColor` = bg
- `canvasColor` = surf
- `cardColor` = card.fill ?? surf
- `dividerColor` = div
- `hintColor` = tx2
- `disabledColor` = tx2 with alpha 38%
- `useMaterial3` = true

## Widget → ThemeData (v1)

| Widget | ThemeData slot | Token |
| --- | --- | --- |
| Scaffold | scaffoldBackgroundColor | background |
| Text | textTheme * colors | text / textSecondary (bodySmall, label) |
| Icon | iconTheme | text |
| Card, SKCard | cardTheme | card.fill ?? surface; elevation; shape from card.radius ?? radius.md |
| ElevatedButton, SKElevatedButton | elevatedButtonTheme | button.fill ?? primary; `toButtonStyle()` (disabled fade or `states.disabled`) |
| FilledButton | filledButtonTheme | same as elevated (M3 primary) |
| OutlinedButton, SKOutlinedButton | outlinedButtonTheme | foreground primary; side border |
| TextButton, SKTextButton | textButtonTheme | foreground primary |
| IconButton, SKIconButton | iconButtonTheme | foreground text / primary |
| FAB | floatingActionButtonTheme | `fab` ?? `button` ?? primary |
| TextField, TextFormField, SK* | inputDecorationTheme | `input` |
| SearchBar / SearchAnchor | searchBarTheme / searchViewTheme | `searchBar` ?? `input` |
| DropdownMenu | dropdownMenuTheme | `dropdownMenu` ?? `input` |
| ListTile, SKListTile | listTileTheme | `listTile` |
| ExpansionTile | expansionTileTheme | `expansionTile` ?? `listTile` |
| AppBar, SKAppBar | appBarTheme | `appBar` |
| NavigationBar | navigationBarTheme | `navBar` |
| BottomNavigationBar | bottomNavigationBarTheme | `navBar` |
| NavigationRail | navigationRailTheme | `navigationRail` ?? `navBar` |
| Drawer, NavigationDrawer | drawerTheme / navigationDrawerTheme | `drawer` |
| BottomAppBar | bottomAppBarTheme | `bottomAppBar` ?? `navBar` |
| TabBar | tabBarTheme | `tabBar` |
| SnackBar | snackBarTheme | `snackBar` (default inverseSurface) |
| Dialog | dialogTheme | `dialog` |
| BottomSheet | bottomSheetTheme | `bottomSheet` |
| Tooltip | tooltipTheme | `tooltip` |
| ProgressIndicator | progressIndicatorTheme | `progress` |
| PopupMenu | popupMenuTheme | `popupMenu` |
| Badge | badgeTheme | `badge` (default error) |
| Switch, SKSwitch | switchTheme | `switchControl` |
| Checkbox | checkboxTheme | `checkbox` |
| Radio | radioTheme | `radio` |
| Slider | sliderTheme | `slider` |
| SegmentedButton | segmentedButtonTheme | `segmentedButton` |
| Chip, SK chips | chipTheme | `chip` |
| Divider, SKDivider | dividerTheme | `divider` |
| DatePicker | datePickerTheme | `datePicker` ?? `dialog` |
| TimePicker | timePickerTheme | `timePicker` ?? `dialog` |

## Not themed (pass color)

`Container`, `DecoratedBox`, `SKit.roundedContainerSize` — `color: context.st.surface` or `context.st.card.fill`.
