import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

void main() {
  const light = Color(0xFF6750A4);
  const dark = Color(0xFFD0BCFF);

  test('resolves light', () {
    const c = STColor(light: light, dark: dark);
    expect(c.resolve(Brightness.light), light);
  });

  test('resolves dark when set', () {
    const c = STColor(light: light, dark: dark);
    expect(c.resolve(Brightness.dark), dark);
  });

  test('dark falls back to light', () {
    const c = STColor(light: light);
    expect(c.resolve(Brightness.dark), light);
  });

  test('equality', () {
    const a = STColor(light: light, dark: dark);
    const b = STColor(light: light, dark: dark);
    const c = STColor(light: light);
    expect(a, b);
    expect(a == c, isFalse);
  });
}
