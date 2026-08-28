# Example — Flutter Scale Theme Kit

Gallery app: **look** from `flutter_scale_theme_kit` + **size** from `flutter_scale_kit`.

```bash
flutter run
```

- Tokens: `lib/design.dart` (`appST`)
- Generated getters: `lib/design.g.dart` (`part of`)
- Optional JSON authoring: `st_theme.json`
- Theme switch: `STThemeModeScope` + `context.stMode` / `STThemeModeSwitch`

Regenerate getters after editing extras in `design.dart`:

```bash
cd ..
dart run flutter_scale_theme_kit:generate example/lib/design.dart
```
