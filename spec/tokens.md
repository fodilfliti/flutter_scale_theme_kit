# Token model

All numbers are **design-px** (unscaled). All colors are `STColor` (light required, dark optional).

## STColor

```dart
STColor({required Color light, Color? dark})
Color resolve(Brightness brightness)
```

If `dark` is null, `resolve(Brightness.dark)` returns `light`.

## STColors

Semantic fields (all `STColor`):

| Field | Role |
| --- | --- |
| `primary` | Brand / primary actions |
| `secondary` | Secondary brand |
| `surface` | Cards, sheets, fields |
| `background` | Scaffold page |
| `border` | Outlines, input border |
| `divider` | Dividers, list separators |
| `text` | Primary copy |
| `textSecondary` | Muted copy |
| `error` | Errors |
| `success` | Success (extra; not a ColorScheme core slot) |
| `warning` | Warning (extra) |
| `info` | Info (extra) |

`Map<String, STColor> extra` — app-specific (`brand`, `gold`, …).

`STColor? extraColor(String name)` — extra map first, then named semantic fields (so `extraColor('primary')` works).

`STColor? colorOrNull(String name)` / resolve via `STResolved.color(name)`.

Unknown extra name: `assert` in debug with the name; in release return `primary` (must not crash production).

Required in constructor: `primary`, `surface`, `background`, `text`. Others default:

- `secondary` → `primary`
- `border` → `text` at 24% opacity (explicit default token, documented — not a dark-mode invention)
- `divider` → `border`
- `textSecondary` → `text` at 70% opacity
- `error` → `Color(0xFFB3261E)` light / `Color(0xFFF2B8B5)` dark if the user passed a dark on `text`? **No.** Error default is a const pair: light `0xFFB3261E`, dark `0xFFF2B8B5` only when the user omitted `error` entirely (package defaults, not derived from primary).
- `success` → light `0xFF2E7D32`, dark `0xFF81C784`
- `warning` → light `0xFFED6C02`, dark `0xFFFFB74D`
- `info` → light `0xFF0277BD`, dark `0xFF4FC3F7`

Prefer users set them. Defaults exist so a three-color theme still builds.

## STRadius

Store doubles: `xs`, `sm`, `md`, `lg`, `xl` (defaults 4, 8, 12, 16, 24).

Resolved:

- `mdValue` → `double`
- `md` → `BorderRadius.circular(mdValue)`

Same for xs/sm/lg/xl.

## STShadows

`sm`, `md`, `lg` as `List<BoxShadow>` (already colors; resolve shadow color from tokens if using a shared color, otherwise keep as authored). Default: three Material-like elevations with a dark alpha black. Shadow color does not flip unless the user passes different lists (keep simple: same shadows both modes unless `STShadowSet` later).

v1: `STShadows` holds `List<BoxShadow> sm/md/lg` used as-is in both brightnesses.

## STTypography

Optional `fontFamily`. Design-system text roles as unscaled [STTextToken] (size, weight, height, letterSpacing, optional `color` or `colorName`):

- `label` — default 14 / w600 / `text`
- `sublabel` — default 12 / w400 / `textSecondary`
- `description` — default 14 / w400 / height 1.4 / `textSecondary`

Also apply `fontFamily` to Material `textTheme`; set `bodyMedium`/`titleLarge`/etc. **colors** from `text` / `textSecondary`. Do not scale `fontSize`.

## STComponent

Optional: `fill`, `foreground`, `border` (`STColor?`), `elevation` (`double?`), `radius` (`double?`), `filled` (`bool?`), `states` (`STComponentStates?`).

`STComponentStates` overlays: `hovered`, `pressed`, `focused`, `disabled`, `selected` (each an `STComponent` with only the fields that change). Null overlay = rest style. Unauthored **disabled** fades the already-resolved rest fill/foreground/border to 38% alpha (not a new hue).

`toButtonStyle()` maps those onto `WidgetStateProperty` (enabled vs disabled vs pressed). ThemeData elevated/filled/outlined/text buttons use the same helper. Input `focusedBorder` / `disabledBorder` read `input.states.focused` / `.disabled` when set.

Missing fields fall back to semantic colors / `STRadius.md` when building ThemeData.

## STComponents

All slots are optional. Null means “use [STColors] / [STRadius] defaults” in the ThemeData factory.

Shared [button] merges into every button type unless a more specific slot is set.

Named slots:

- Surfaces: `card`, `panel`, `section`, `dialog`, `bottomSheet`, `snackBar`
- Chrome: `appBar`, `navBar`, `navigationRail`, `drawer`, `bottomAppBar`, `tabBar`
- Actions: `button`, `elevatedButton`, `filledButton`, `outlinedButton`, `textButton`, `iconButton`, `fab`
- Inputs: `input`, `searchBar`, `dropdownMenu`
- Selection: `chip`, `switchControl` (lookup also `'switch'`), `checkbox`, `radio`, `slider`, `segmentedButton`
- Lists: `listTile`, `expansionTile`
- Other: `tooltip`, `progress`, `popupMenu`, `badge`, `divider`, `datePicker`, `timePicker`

`Map<String, STComponent> extra` — untyped containers (`highlighted`, etc.). Extra keys must not collide with named slots if you need both; extras are merged into the resolved map after named slots (can override a name). Prefer [STTheme.extras] with a `kind` for new app-specific styles.

`lookup` aliases: `navigationBar` → `navBar`, `floatingActionButton` → `fab`, `switch` → `switchControl`.

## STExtra / STKind

`STKind`: `button`, `card`, `container`, `text`.

```dart
STExtra.button('ghost', style: STComponent(...))
STExtra.card('product', style: STComponent(...))
STExtra.container('highlight', style: STComponent(...))
STExtra.text('price', token: STTextToken(fontSize: 18, fontWeight: FontWeight.w600))
```

## STTheme

```dart
STTheme({
  required STColors colors,
  STRadius radius = const STRadius(),
  STShadows shadows = const STShadows(),
  STTypography typography = const STTypography(),
  STComponents components = const STComponents(),
  List<STExtra> extras = const [],
})
ThemeData get light;
ThemeData get dark;
```

## STResolved (what `context.st` is)

Resolved `Color` getters for every `STColors` field, plus `radius`, `shadow`, typed `STResolvedComponent` getters for every named slot (`card`, `fab`, `chip`, …), plus `color(String)` and `container(String)`.

Text roles: `label`, `sublabel`, `description`.

Typed extras: `extraButton` / `extraCard` / `extraContainer` / `extraText`. Visual extras are also reachable via `container(name)`.

`STResolvedComponent.toButtonStyle()` / `toBoxDecoration()`. `toButtonStyle()` honors [STComponent.states] (`WidgetStateProperty`).
