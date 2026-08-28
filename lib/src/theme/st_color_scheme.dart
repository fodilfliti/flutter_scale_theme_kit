import 'package:flutter/material.dart';

import '../color/st_color.dart';
import '../tokens/st_colors.dart';

/// Builds a Material 3 [ColorScheme] from semantic tokens (no seed palettes).
ColorScheme stColorScheme(STColors colors, Brightness brightness) {
  final p = colors.primary.resolve(brightness);
  final s = colors.secondary.resolve(brightness);
  final surf = colors.surface.resolve(brightness);
  final bg = colors.background.resolve(brightness);
  final br = colors.border.resolve(brightness);
  final div = colors.divider.resolve(brightness);
  final tx = colors.text.resolve(brightness);
  final tx2 = colors.textSecondary.resolve(brightness);
  final err = colors.error.resolve(brightness);
  final tertiary = colors.info.resolve(brightness);

  return ColorScheme(
    brightness: brightness,
    primary: p,
    onPrimary: stInkForFill(p),
    primaryContainer: p,
    onPrimaryContainer: stInkForFill(p),
    secondary: s,
    onSecondary: stInkForFill(s),
    secondaryContainer: s,
    onSecondaryContainer: stInkForFill(s),
    tertiary: tertiary,
    onTertiary: stInkForFill(tertiary),
    tertiaryContainer: tertiary,
    onTertiaryContainer: stInkForFill(tertiary),
    error: err,
    onError: stInkForFill(err),
    errorContainer: err,
    onErrorContainer: stInkForFill(err),
    surface: surf,
    onSurface: tx,
    surfaceDim: surf,
    surfaceBright: surf,
    surfaceContainerLowest: bg,
    surfaceContainerLow: surf,
    surfaceContainer: surf,
    surfaceContainerHigh: surf,
    surfaceContainerHighest: surf,
    onSurfaceVariant: tx2,
    outline: br,
    outlineVariant: div,
    shadow: const Color(0xFF000000),
    scrim: const Color(0xFF000000),
    inverseSurface: tx,
    onInverseSurface: surf,
    inversePrimary: p,
    surfaceTint: p,
    primaryFixed: p,
    primaryFixedDim: p,
    onPrimaryFixed: stInkForFill(p),
    onPrimaryFixedVariant: stInkForFill(p),
    secondaryFixed: s,
    secondaryFixedDim: s,
    onSecondaryFixed: stInkForFill(s),
    onSecondaryFixedVariant: stInkForFill(s),
    tertiaryFixed: tertiary,
    tertiaryFixedDim: tertiary,
    onTertiaryFixed: stInkForFill(tertiary),
    onTertiaryFixedVariant: stInkForFill(tertiary),
  );
}
