import 'package:flutter/material.dart';

import '../tokens/st_colors.dart';
import '../tokens/st_component.dart';
import '../tokens/st_extra.dart';
import '../tokens/st_radius.dart';
import '../tokens/st_shadows.dart';
import '../tokens/st_typography.dart';
import 'st_resolved.dart';
import 'st_theme_data_factory.dart';
import 'st_theme_extension.dart';

/// Source of truth for look tokens. Project to [ThemeData] via [light] / [dark].
class STTheme {
  final STColors colors;
  final STRadius radius;
  final STShadows shadows;
  final STTypography typography;
  final STComponents components;

  /// App-specific styles: extra buttons, cards, containers, and text roles.
  final List<STExtra> extras;

  const STTheme({
    required this.colors,
    this.radius = const STRadius(),
    this.shadows = const STShadows(),
    this.typography = const STTypography(),
    this.components = const STComponents(),
    this.extras = const [],
  });

  STTheme copyWith({
    STColors? colors,
    STRadius? radius,
    STShadows? shadows,
    STTypography? typography,
    STComponents? components,
    List<STExtra>? extras,
  }) {
    return STTheme(
      colors: colors ?? this.colors,
      radius: radius ?? this.radius,
      shadows: shadows ?? this.shadows,
      typography: typography ?? this.typography,
      components: components ?? this.components,
      extras: extras ?? this.extras,
    );
  }

  /// Light [ThemeData] including [STThemeExtension].
  ThemeData get light => STThemeDataFactory.create(
    colors: colors,
    radius: radius,
    shadows: shadows,
    typography: typography,
    components: components,
    extras: extras,
    brightness: Brightness.light,
  );

  /// Dark [ThemeData] including [STThemeExtension].
  ThemeData get dark => STThemeDataFactory.create(
    colors: colors,
    radius: radius,
    shadows: shadows,
    typography: typography,
    components: components,
    extras: extras,
    brightness: Brightness.dark,
  );

  /// Resolved tokens for a brightness (without building full ThemeData).
  STResolved resolve(Brightness brightness) {
    return STResolved(extensionFor(brightness));
  }

  STThemeExtension extensionFor(Brightness brightness) {
    return STThemeDataFactory.extensionFor(
      colors: colors,
      radius: radius,
      shadows: shadows,
      typography: typography,
      components: components,
      extras: extras,
      brightness: brightness,
    );
  }
}
