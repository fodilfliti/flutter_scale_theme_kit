import 'package:flutter/material.dart';

/// A light color plus an optional dark color.
///
/// If [dark] is omitted, [light] is used in dark mode. Dark is never invented.
class STColor {
  /// Color used when brightness is light.
  final Color light;

  /// Color used when brightness is dark. Falls back to [light] if null.
  final Color? dark;

  /// Creates an authored color pair.
  const STColor({required this.light, this.dark});

  /// Picks [light] or [dark] (or [light] if [dark] is null).
  Color resolve(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return dark ?? light;
    }
    return light;
  }

  /// Copies this pair replacing the given fields.
  STColor copyWith({Color? light, Color? dark}) {
    return STColor(light: light ?? this.light, dark: dark ?? this.dark);
  }

  @override
  bool operator ==(Object other) {
    return other is STColor && other.light == light && other.dark == dark;
  }

  @override
  int get hashCode => Object.hash(light, dark);

  @override
  String toString() => 'STColor(light: $light, dark: $dark)';
}

/// Readable ink for a fill: dark on light fills, light on dark fills.
Color stInkForFill(Color fill) {
  return fill.computeLuminance() > 0.5
      ? const Color(0xFF1C1B1F)
      : const Color(0xFFFFFFFF);
}
