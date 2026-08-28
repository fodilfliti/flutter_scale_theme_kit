import 'package:flutter/material.dart';

import '../tokens/st_component.dart';
import '../tokens/st_extra.dart';
import '../tokens/st_radius.dart';
import '../tokens/st_shadows.dart';

/// Resolved look attached to [ThemeData.extensions].
class STThemeExtension extends ThemeExtension<STThemeExtension> {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color border;
  final Color divider;
  final Color text;
  final Color textSecondary;
  final Color error;
  final Color success;
  final Color warning;
  final Color info;
  final STRadius radius;
  final STShadows shadows;

  /// Named slots (`card`, `fab`, …), [STComponents.extra], and visual extras.
  final Map<String, STResolvedComponent> components;

  /// [STColors.extra] resolved for this brightness.
  final Map<String, Color> extraColors;

  /// Typed extras keyed by the authored name (`ghost`, `price`, …).
  final Map<String, STResolvedExtra> extras;

  final TextStyle label;
  final TextStyle sublabel;
  final TextStyle description;

  const STThemeExtension({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.border,
    required this.divider,
    required this.text,
    required this.textSecondary,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
    required this.radius,
    required this.shadows,
    required this.components,
    required this.label,
    required this.sublabel,
    required this.description,
    this.extraColors = const {},
    this.extras = const {},
  });

  STResolvedComponent comp(String name) {
    return components[name] ?? components['card']!;
  }

  Color? extraColor(String name) => extraColors[name];

  @override
  STThemeExtension copyWith({
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? background,
    Color? border,
    Color? divider,
    Color? text,
    Color? textSecondary,
    Color? error,
    Color? success,
    Color? warning,
    Color? info,
    STRadius? radius,
    STShadows? shadows,
    Map<String, STResolvedComponent>? components,
    Map<String, Color>? extraColors,
    Map<String, STResolvedExtra>? extras,
    TextStyle? label,
    TextStyle? sublabel,
    TextStyle? description,
  }) {
    return STThemeExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      text: text ?? this.text,
      textSecondary: textSecondary ?? this.textSecondary,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      radius: radius ?? this.radius,
      shadows: shadows ?? this.shadows,
      components: components ?? this.components,
      extraColors: extraColors ?? this.extraColors,
      extras: extras ?? this.extras,
      label: label ?? this.label,
      sublabel: sublabel ?? this.sublabel,
      description: description ?? this.description,
    );
  }

  @override
  STThemeExtension lerp(ThemeExtension<STThemeExtension>? other, double t) {
    if (other is! STThemeExtension) return this;
    return STThemeExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      background: Color.lerp(background, other.background, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      radius: t < 0.5 ? radius : other.radius,
      shadows: t < 0.5 ? shadows : other.shadows,
      components: t < 0.5 ? components : other.components,
      extraColors: t < 0.5 ? extraColors : other.extraColors,
      extras: t < 0.5 ? extras : other.extras,
      label: TextStyle.lerp(label, other.label, t)!,
      sublabel: TextStyle.lerp(sublabel, other.sublabel, t)!,
      description: TextStyle.lerp(description, other.description, t)!,
    );
  }
}
