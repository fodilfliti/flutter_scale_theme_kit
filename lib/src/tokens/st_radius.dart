import 'package:flutter/material.dart';

/// Unscaled corner radii in design-px.
///
/// Constructor uses short names (`md: 12`). Getters: [md] is [BorderRadius],
/// [mdValue] is the double.
class STRadius {
  final double xsValue;
  final double smValue;
  final double mdValue;
  final double lgValue;
  final double xlValue;

  const STRadius({
    double xs = 4,
    double sm = 8,
    double md = 12,
    double lg = 16,
    double xl = 24,
  }) : xsValue = xs,
       smValue = sm,
       mdValue = md,
       lgValue = lg,
       xlValue = xl;

  BorderRadius get xs => BorderRadius.circular(xsValue);
  BorderRadius get sm => BorderRadius.circular(smValue);
  BorderRadius get md => BorderRadius.circular(mdValue);
  BorderRadius get lg => BorderRadius.circular(lgValue);
  BorderRadius get xl => BorderRadius.circular(xlValue);

  STRadius copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return STRadius(
      xs: xs ?? xsValue,
      sm: sm ?? smValue,
      md: md ?? mdValue,
      lg: lg ?? lgValue,
      xl: xl ?? xlValue,
    );
  }
}
