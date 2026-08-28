# Flutter Scale Theme Kit

[![Pub Version](https://img.shields.io/pub/v/flutter_scale_theme_kit)](https://pub.dev/packages/flutter_scale_theme_kit)

Look companion for Flutter: semantic colors, authored light/dark, and Material `ThemeData`. Stock widgets (and `flutter_scale_kit` `SK*` widgets) pick up fill, text, and borders.

| Package | Job | Version |
| --- | --- | --- |
| [`flutter_scale_kit`](https://pub.dev/packages/flutter_scale_kit) | **Size** — `.w`, `SKSize`, `SKCard`, `ScaleKitBuilder` | **2.0.0** |
| **flutter_scale_theme_kit** | **Look** — `STTheme`, `context.st`, `ThemeData` | **1.0.1** |

The two repos sit at the **same folder level** (`flutter_scale_kit` next to `flutter_scale_theme_kit`). They do **not** depend on each other. An **app** may install one or both.

This package does **not** depend on `flutter_scale_kit`. Install one or both.

- Dart `^3.7.2`, Flutter `>=3.29.0`
- Runtime dependency: Flutter SDK only
- No `STButton` / `STCard` — use Flutter widgets (or SK widgets for size)
- Dark colors are **authored**. Omit `dark:` and light is reused. Nothing invents a palette (`ColorScheme.fromSeed` is not the default)

## Install

```yaml
dependencies:
  flutter_scale_theme_kit: ^1.0.1
```

With size (recommended for production apps):

```yaml
dependencies:
  flutter_scale_kit: ^2.0.0
  flutter_scale_theme_kit: ^1.0.1
```

```dart
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';
```

## 1. Define tokens once

```dart
final appST = STTheme(
  colors: STColors(
    primary: STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
    surface: STColor(light: Color(0xFFFFFFFF), dark: Color(0xFF1E1E1E)),
    background: STColor(light: Color(0xFFF7F7F7), dark: Color(0xFF121212)),
    text: STColor(light: Color(0xFF1C1B1F), dark: Color(0xFFE6E1E5)),
    extra: {'brand': STColor(light: Color(0xFFFFB800))},
  ),
  radius: const STRadius(sm: 8, md: 12, lg: 16),
);
```

Required colors: `primary`, `surface`, `background`, `text`. Optional: `secondary`, `border`, `divider`, `textSecondary`, `error`, `success`, `warning`, `info`.

## 2. Wire MaterialApp (and switch theme)

```dart
STThemeModeScope(
  builder: (context, mode) {
    return MaterialApp(
      theme: appST.light,
      darkTheme: appST.dark,
      themeMode: mode.mode,
      home: const HomePage(),
    );
  },
);
```

Anywhere under that app:

```dart
context.stMode.setMode(ThemeMode.dark);
context.stMode.setDark(true);    // false → light
context.stMode.toggle();
context.stMode.cycle();          // system → light → dark → system
context.stMode.mode;
context.stMode.isDark(context);

const STThemeModeSwitch();       // stock Switch, forces light/dark
```

Without `STThemeModeScope`, pass `themeMode` yourself. Look still comes from `theme` / `darkTheme`.

`Scaffold`, `Card`, `ElevatedButton`, `TextField`, `AppBar`, `NavigationBar`, `SearchBar`, `Slider`, `Chip`, `Dialog`, and the other mapped Material widgets inherit look from `ThemeData`. No per-widget `color:` required.

## 3. Use tokens in widgets — `context.st`

```dart
Text('Hello', style: TextStyle(color: context.st.text));
Container(
  decoration: BoxDecoration(
    color: context.st.surface,
    borderRadius: context.st.radius.md,
    border: Border.all(color: context.st.border),
  ),
);
```

`Container` / `SKit.roundedContainerSize` are **not** Material — pass `color: context.st.surface`.

### Colors

| Call | Meaning |
| --- | --- |
| `context.st.primary` | Brand |
| `context.st.secondary` | Secondary brand |
| `context.st.surface` | Cards, sheets |
| `context.st.background` | Scaffold |
| `context.st.border` | Outlines |
| `context.st.divider` | Dividers |
| `context.st.text` | Primary copy |
| `context.st.textSecondary` | Muted copy |
| `context.st.error` / `.success` / `.warning` / `.info` | Status |
| `context.st.color('brand')` | Extra or semantic name |

### Radius and shadow

| Call | Type |
| --- | --- |
| `context.st.radius.md` | `BorderRadius` |
| `context.st.radius.mdValue` | `double` |
| `context.st.radius.xs` … `.xl` | same pattern |
| `context.st.shadow.sm` / `.md` / `.lg` | `List<BoxShadow>` |

### Typography roles

```dart
Text('Title', style: context.st.label);
Text('Muted', style: context.st.sublabel);
Text('Body', style: context.st.description);
```

Override on `STTheme`:

```dart
typography: STTypography(
  label: STTextToken(fontSize: 14, fontWeight: FontWeight.w600),
  sublabel: STTextToken(fontSize: 12, colorName: 'textSecondary'),
  description: STTextToken(fontSize: 14, height: 1.4, colorName: 'textSecondary'),
),
```

### Named Material slots

```dart
components: STComponents(
  card: STComponent(elevation: 0, radius: 16),
  button: STComponent(elevation: 0), // shared by button types
  fab: STComponent(fill: STColor(light: Color(0xFFFF5722))),
  chip: STComponent(radius: 20),
)
```

```dart
context.st.card.fill
context.st.fab.fill
context.st.chip
context.st.container('dialog')
```

## 4. Extra styles (second button, product card, price)

No extra widgets. Add tokens, then apply Flutter constructors.

```dart
extras: [
  STExtra.button(
    'ghost',
    style: STComponent(
      elevation: 0,
      foreground: STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
      states: STComponentStates(
        disabled: STComponent(
          foreground: STColor(light: Color(0xFF9E9E9E), dark: Color(0xFF6D6D6D)),
        ),
        pressed: STComponent(
          fill: STColor(light: Color(0x1A6750A4), dark: Color(0x1AD0BCFF)),
        ),
      ),
    ),
  ),
  STExtra.button(
    'destructive',
    style: STComponent(
      fill: STColor(light: Color(0xFFB3261E), dark: Color(0xFFF2B8B5)),
      elevation: 0,
    ),
  ),
  STExtra.card('product', style: STComponent(radius: 20)),
  STExtra.container(
    'highlighted',
    style: STComponent(fill: STColor(light: Color(0xFFFFF8E1), dark: Color(0xFF3E2723))),
  ),
  STExtra.text(
    'price',
    token: STTextToken(fontSize: 18, fontWeight: FontWeight.w600, colorName: 'primary'),
  ),
],
```

**Always available** (no generate):

```dart
ElevatedButton(
  style: context.st.extraButton('ghost').toButtonStyle(),
  onPressed: save,
  child: const Text('Ghost'),
);
Text('\$48', style: context.st.extraText('price'));
DecoratedBox(
  decoration: context.st.extraCard('product').toBoxDecoration(),
  child: child,
);
color: context.st.color('brand')
color: context.st.extraContainer('highlighted').fill
```

`STComponent.states`: `hovered`, `pressed`, `focused`, `disabled`, `selected`. Mapped into `ButtonStyle` (`WidgetStateProperty`). If you omit `disabled`, rest fill/ink fades to **38% alpha** (same hue). `onPressed: null` shows disabled.

## 5. Generate short getters

From a Dart file that already has `appST` / `STExtra.*`:

```dart
part 'design.g.dart';
```

```bash
dart run flutter_scale_theme_kit:generate
dart run flutter_scale_theme_kit:generate lib/design.dart
dart run flutter_scale_theme_kit:generate watch
```

Writes `design.g.dart` (**getters only** — does not replace `appST`):

```dart
context.st.brand
context.st.ghostButtonStyle
context.st.destructiveButtonStyle
context.st.productCardDecoration
context.st.highlightedContainerColor
context.st.price
```

JSON is optional **authoring** input (not loaded at runtime):

```bash
dart run flutter_scale_theme_kit:generate st_theme.json
```

```json
{
  "variable": "appST",
  "colors": {
    "primary": { "light": "#6750A4", "dark": "#D0BCFF" },
    "surface": { "light": "#FFFFFF" },
    "background": { "light": "#F7F7F7" },
    "text": { "light": "#1C1B1F" }
  },
  "extras": {
    "ghost": { "kind": "button", "elevation": 0 },
    "product": { "kind": "card", "radius": 20 },
    "highlighted": { "kind": "container", "fill": { "light": "#FFF8E1" } },
    "price": { "kind": "text", "fontSize": 18, "fontWeight": 600 }
  }
}
```

`kind` must be `button` | `card` | `container` | `text`. Omit file to pick `lib/design.dart`, `design.dart`, or `st_theme.json`. No `build_runner`.

## With flutter_scale_kit

Do **not** replace `appST.light` with `ResponsiveThemeData.create` alone (it drops card/button/input themes). Scale **fonts** in the app:

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  child: Builder(
    builder: (context) {
      return STThemeModeScope(
        builder: (context, mode) {
          return MaterialApp(
            theme: appST.light.copyWith(
              textTheme: appST.light.createResponsiveTextTheme(
                appST.light.textTheme,
              ),
            ),
            darkTheme: appST.dark.copyWith(
              textTheme: appST.dark.createResponsiveTextTheme(
                appST.dark.textTheme,
              ),
            ),
            themeMode: mode.mode,
            home: const HomePage(),
          );
        },
      );
    },
  ),
);
```

Align radius numbers in the **app**: `setRadiusSizes(md: 12)` and `STRadius(md: 12)`.

```dart
SKit.paddingSize(
  all: SKSize.md,
  child: SKCard(
    child: SKElevatedButton(
      onPressed: save,
      child: SKText('Save', fontSize: 16),
    ),
  ),
);

SKit.roundedContainerSize(
  all: SKSize.md,
  color: context.st.surface,
  borderColor: context.st.border,
);
```

Never `SKContainer(width: 120.w)` (double-scale).

## AI agent skill

If this package is in the app `pubspec.yaml`, coding agents **must use it** for look (`STTheme`, `context.st`). If Scale Kit is there too, they merge fonts with `createResponsiveTextTheme` (see above) — not `ResponsiveThemeData.create`.

```bash
npx skills add fodilfliti/flutter_scale_theme_kit
npx skills add fodilfliti/flutter_scale_kit
```

Then: `Init Flutter Scale Theme Kit with defaults.`

Skill source: [`skills/flutter-scale-theme-kit/`](https://github.com/fodilfliti/flutter_scale_theme_kit/tree/main/skills/flutter-scale-theme-kit)

## Example

```bash
cd example
flutter run
```

Gallery: light/dark switch (`STThemeModeScope`), Material widgets, extras, disabled button states.

## Not in this package

Figma import, `ColorScheme.fromSeed` as the default API, `STCard` / `STButton`, Cupertino, spacing/`.sp` (that is `flutter_scale_kit`).
