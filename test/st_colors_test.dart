import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

void main() {
  final colors = STColors(
    primary: const STColor(light: Color(0xFF6750A4)),
    surface: const STColor(light: Color(0xFFFFFFFF)),
    background: const STColor(light: Color(0xFFF7F7F7)),
    text: const STColor(light: Color(0xFF1C1B1F)),
    extra: const {'brand': STColor(light: Color(0xFFFFB800))},
  );

  test('secondary defaults to primary', () {
    expect(colors.secondary, colors.primary);
  });

  test('error uses package default when omitted', () {
    expect(colors.error, STColors.defaultError);
  });

  test('extra brand lookup', () {
    expect(colors.extraColor('brand')!.light, const Color(0xFFFFB800));
    expect(colors.lookup('brand')!.light, const Color(0xFFFFB800));
    expect(colors.colorOrNull('brand')!.light, const Color(0xFFFFB800));
    expect(
      colors.resolveNamed('brand', Brightness.light),
      const Color(0xFFFFB800),
    );
  });

  test('named primary lookup', () {
    expect(colors.extraColor('primary'), colors.primary);
    expect(colors.lookup('primary'), colors.primary);
  });
}
