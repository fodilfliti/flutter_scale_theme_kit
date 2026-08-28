import 'package:flutter/material.dart';

import '../color/st_color.dart';

/// Semantic color tokens. Extra names live in [extra].
class STColors {
  static const STColor defaultError = STColor(
    light: Color(0xFFB3261E),
    dark: Color(0xFFF2B8B5),
  );

  static const STColor defaultSuccess = STColor(
    light: Color(0xFF2E7D32),
    dark: Color(0xFF81C784),
  );

  static const STColor defaultWarning = STColor(
    light: Color(0xFFED6C02),
    dark: Color(0xFFFFB74D),
  );

  static const STColor defaultInfo = STColor(
    light: Color(0xFF0277BD),
    dark: Color(0xFF4FC3F7),
  );

  final STColor primary;
  final STColor secondary;
  final STColor surface;
  final STColor background;
  final STColor border;
  final STColor divider;
  final STColor text;
  final STColor textSecondary;
  final STColor error;
  final STColor success;
  final STColor warning;
  final STColor info;
  final Map<String, STColor> extra;

  STColors({
    required this.primary,
    required this.surface,
    required this.background,
    required this.text,
    STColor? secondary,
    STColor? border,
    STColor? divider,
    STColor? textSecondary,
    STColor? error,
    STColor? success,
    STColor? warning,
    STColor? info,
    Map<String, STColor>? extra,
  }) : secondary = secondary ?? primary,
       border =
           border ??
           STColor(
             light: text.light.withValues(alpha: 0.24),
             dark: (text.dark ?? text.light).withValues(alpha: 0.24),
           ),
       divider =
           divider ??
           border ??
           STColor(
             light: text.light.withValues(alpha: 0.24),
             dark: (text.dark ?? text.light).withValues(alpha: 0.24),
           ),
       textSecondary =
           textSecondary ??
           STColor(
             light: text.light.withValues(alpha: 0.70),
             dark: (text.dark ?? text.light).withValues(alpha: 0.70),
           ),
       error = error ?? defaultError,
       success = success ?? defaultSuccess,
       warning = warning ?? defaultWarning,
       info = info ?? defaultInfo,
       extra = extra ?? const {};

  STColors copyWith({
    STColor? primary,
    STColor? surface,
    STColor? background,
    STColor? text,
    STColor? secondary,
    STColor? border,
    STColor? divider,
    STColor? textSecondary,
    STColor? error,
    STColor? success,
    STColor? warning,
    STColor? info,
    Map<String, STColor>? extra,
  }) {
    return STColors(
      primary: primary ?? this.primary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      text: text ?? this.text,
      secondary: secondary ?? this.secondary,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      textSecondary: textSecondary ?? this.textSecondary,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      extra: extra ?? this.extra,
    );
  }

  /// Extra map first, then named semantic fields. Unknown names return null.
  STColor? extraColor(String name) {
    final fromExtra = extra[name];
    if (fromExtra != null) return fromExtra;
    return lookup(name);
  }

  /// Named semantic or extra token. Unknown names return null.
  STColor? colorOrNull(String name) => lookup(name);

  /// Named semantic or extra token. Unknown names return null.
  STColor? lookup(String name) {
    switch (name) {
      case 'primary':
        return primary;
      case 'secondary':
        return secondary;
      case 'surface':
        return surface;
      case 'background':
        return background;
      case 'border':
        return border;
      case 'divider':
        return divider;
      case 'text':
        return text;
      case 'textSecondary':
        return textSecondary;
      case 'error':
        return error;
      case 'success':
        return success;
      case 'warning':
        return warning;
      case 'info':
        return info;
      default:
        return extra[name];
    }
  }

  /// Resolves [name]. Unknown: assert in debug, [primary] in release.
  Color resolveNamed(String name, Brightness brightness) {
    final token = lookup(name);
    if (token == null) {
      assert(false, 'Unknown ST color "$name"');
      return primary.resolve(brightness);
    }
    return token.resolve(brightness);
  }
}
