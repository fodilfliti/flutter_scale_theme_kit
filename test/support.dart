import 'package:flutter/material.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

STTheme sampleTheme({
  Map<String, STColor>? extraColors,
  Map<String, STComponent>? extraComponents,
  List<STExtra>? extras,
  STTypography? typography,
}) {
  return STTheme(
    colors: STColors(
      primary: const STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
      surface: const STColor(light: Color(0xFFFFFFFF), dark: Color(0xFF1E1E1E)),
      background: const STColor(
        light: Color(0xFFF7F7F7),
        dark: Color(0xFF121212),
      ),
      text: const STColor(light: Color(0xFF1C1B1F), dark: Color(0xFFE6E1E5)),
      extra: extraColors ?? const {},
    ),
    typography: typography ?? const STTypography(),
    components: STComponents(extra: extraComponents ?? const {}),
    extras: extras ?? const [],
  );
}
