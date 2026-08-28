# Init Theme Kit in the user's app

## Detect

1. App `pubspec.yaml`: `flutter_scale_theme_kit` and/or `flutter_scale_kit`.
2. Already wired if `STTheme(` exists under `lib/`. Then do not rewrite tokens; still wrap `MaterialApp` if `theme:` is not `appST.light`.
3. Scale Kit already wired if `ScaleKitBuilder(` exists.

## Interview (one message, only if no `STTheme`)

Ask only what is missing. Defaults if they say “defaults”:

1. **Colors** — they paste hex / keep example purple Material-like pair
2. **Theme switch** — `STThemeModeScope` (default yes)
3. **Dart path** — `lib/core/design.dart` (default)
4. **Scale Kit** — if pubspec already has `flutter_scale_kit`, merge (do not ask). If neither is installed and they want responsive UI, add Scale Kit too and follow that skill’s init.

## Steps

1. `flutter pub add flutter_scale_theme_kit`
2. Write `lib/core/design.dart` (template below)
3. Wire `MaterialApp` as in the matching template
4. Optional: `part 'design.g.dart';` then `dart run flutter_scale_theme_kit:generate`

If Scale Kit is present, also keep `initScaleKit()` **before** `runApp` and `ScaleKitBuilder` **above** the theme wrap. Radius md must match (`setRadiusSizes` + `STRadius`).

## Template — `lib/core/design.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

final appST = STTheme(
  colors: STColors(
    primary: const STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
    surface: const STColor(light: Color(0xFFFFFFFF), dark: Color(0xFF1E1E1E)),
    background: const STColor(light: Color(0xFFF7F7F7), dark: Color(0xFF121212)),
    text: const STColor(light: Color(0xFF1C1B1F), dark: Color(0xFFE6E1E5)),
  ),
  radius: const STRadius(md: 12),
);
```

## Template — theme kit only

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

```dart
context.stMode.setDark(true);
const STThemeModeSwitch();
```

## Template — **merge with Scale Kit** (both packages)

Do **not** use `ResponsiveThemeData.create(...)` as `theme:`. Keep `appST.light` / `appST.dark` and scale **text** only:

```dart
void main() {
  initScaleKit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      designType: DeviceType.mobile,
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

`createResponsiveTextTheme` is a **Scale Kit** extension on `ThemeData`. The `Builder` is required so `context` is under `ScaleKitBuilder`.

## Checklist

- [ ] `flutter_scale_theme_kit` in pubspec
- [ ] One `STTheme` (`appST`)
- [ ] `theme:` / `darkTheme:` from `appST`, not `fromSeed`, not `ResponsiveThemeData.create` alone
- [ ] If Scale Kit: `initScaleKit` + `ScaleKitBuilder` + `copyWith(textTheme: …createResponsiveTextTheme…)`
- [ ] Radius numbers aligned when both packages are used
- [ ] No `STButton` / `STCard`
