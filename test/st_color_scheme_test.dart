import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

import 'support.dart';

void main() {
  test('ColorScheme follows fill table', () {
    final theme = sampleTheme();
    final scheme = stColorScheme(theme.colors, Brightness.light);
    expect(scheme.brightness, Brightness.light);
    expect(scheme.primary, theme.colors.primary.resolve(Brightness.light));
    expect(scheme.outline, theme.colors.border.resolve(Brightness.light));
    expect(scheme.onSurface, theme.colors.text.resolve(Brightness.light));
    expect(
      scheme.surfaceContainerLowest,
      theme.colors.background.resolve(Brightness.light),
    );
    expect(scheme.primaryFixed, scheme.primary);
  });

  test('dark ColorScheme uses dark tokens', () {
    final theme = sampleTheme();
    final scheme = stColorScheme(theme.colors, Brightness.dark);
    expect(scheme.brightness, Brightness.dark);
    expect(scheme.primary, theme.colors.primary.resolve(Brightness.dark));
  });

  test('lib does not call ColorScheme.fromSeed', () {
    final dartFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    for (final file in dartFiles) {
      expect(
        file.readAsStringSync().contains('ColorScheme.fromSeed'),
        isFalse,
        reason: file.path,
      );
    }
  });
}
