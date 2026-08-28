import 'package:flutter/material.dart';

import '../color/st_color.dart';

/// Unscaled text style token (size, weight, color). Color may be a pair or a semantic name.
class STTextToken {
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? height;
  final double? letterSpacing;
  final STColor? color;

  /// Semantic color: `text`, `textSecondary`, `primary`, …
  final String? colorName;

  const STTextToken({
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.height,
    this.letterSpacing,
    this.color,
    this.colorName,
  });

  STTextToken copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? height,
    double? letterSpacing,
    STColor? color,
    String? colorName,
  }) {
    return STTextToken(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      height: height ?? this.height,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      color: color ?? this.color,
      colorName: colorName ?? this.colorName,
    );
  }
}

/// Optional font family plus design-system text roles.
class STTypography {
  final String? fontFamily;
  final STTextToken? label;
  final STTextToken? sublabel;
  final STTextToken? description;

  const STTypography({
    this.fontFamily,
    this.label,
    this.sublabel,
    this.description,
  });

  STTypography copyWith({
    String? fontFamily,
    STTextToken? label,
    STTextToken? sublabel,
    STTextToken? description,
  }) {
    return STTypography(
      fontFamily: fontFamily ?? this.fontFamily,
      label: label ?? this.label,
      sublabel: sublabel ?? this.sublabel,
      description: description ?? this.description,
    );
  }
}

/// Builds a [TextStyle] from a token. [color] must already be brightness-resolved.
TextStyle stResolveTextStyle({
  required STTextToken? token,
  required String? fontFamily,
  required Color color,
  double defaultSize = 14,
  FontWeight defaultWeight = FontWeight.w400,
  double? defaultHeight,
}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: token?.fontSize ?? defaultSize,
    fontWeight: token?.fontWeight ?? defaultWeight,
    fontStyle: token?.fontStyle,
    height: token?.height ?? defaultHeight,
    letterSpacing: token?.letterSpacing,
    color: color,
  );
}
