import 'package:flutter/material.dart';

/// Box shadows used as-is in light and dark (not auto-flipped).
class STShadows {
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;

  const STShadows({
    this.sm = const [
      BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 1)),
    ],
    this.md = const [
      BoxShadow(color: Color(0x3D000000), blurRadius: 8, offset: Offset(0, 2)),
    ],
    this.lg = const [
      BoxShadow(color: Color(0x4D000000), blurRadius: 16, offset: Offset(0, 4)),
    ],
  });

  STShadows copyWith({
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
  }) {
    return STShadows(sm: sm ?? this.sm, md: md ?? this.md, lg: lg ?? this.lg);
  }
}
