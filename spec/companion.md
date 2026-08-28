# Companion: flutter_scale_kit + flutter_scale_theme_kit

Do not import scale_kit from this package’s `lib/`. This file is the **app** recipe. Repos are siblings (`../flutter_scale_kit` **2.0.0**, this package **1.0.1**).

## Ownership

| Concern | Package |
| --- | --- |
| `.w` `.sp` `.rSafe`, `SKSize`, `SK*`, `SKit`, `ScaleKitBuilder`, `FontConfig` | flutter_scale_kit |
| Semantic colors, light/dark, `ThemeData` look, `context.st` | flutter_scale_theme_kit |

## Bootstrap (both installed)

```dart
void main() {
  initScaleKit(); // app-owned; setPaddingSizes / setRadiusSizes
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleKitBuilder(
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
  }
}
```

**Do not** replace `st.light` with `ResponsiveThemeData.create(colorScheme: st.light.colorScheme)` alone — that **drops** card/button/input themes.

`createResponsiveTextTheme` is a scale_kit extension on `ThemeData`. It needs a `BuildContext` under `ScaleKitBuilder` (hence `Builder`).

## Align radius numbers in the app

If `setRadiusSizes(..., md: 12)`, use `STRadius(md: 12)` so raw `Card` and `SKCard` match.

## Screens (scale_kit design_system style)

```dart
SKit.paddingSize(
  all: SKSize.md,
  child: SKCard(
    child: Column(
      children: [
        SKText('Title', fontSize: 20),
        SKit.vSpaceSize(SKSize.sm),
        SKElevatedButton(
          onPressed: save,
          child: SKText('Save', fontSize: 16),
        ),
      ],
    ),
  ),
)
```

No colors on Card/Button — `ThemeData` supplies them.

Non-Material helper:

```dart
SKit.roundedContainerSize(
  all: SKSize.md,
  color: context.st.surface,
  borderColor: context.st.border,
)
```

Never `SKContainer(width: 120.w)` (double-scale). Never put scaling APIs in theme_kit `lib/`.

## Theme-kit only

```dart
MaterialApp(theme: appST.light, darkTheme: appST.dark);
```

No `ScaleKitBuilder`. Widgets use raw px.
