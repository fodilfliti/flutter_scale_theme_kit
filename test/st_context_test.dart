import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

import 'support.dart';

void main() {
  testWidgets('context.st reads ThemeExtension', (tester) async {
    final st = sampleTheme();
    late STResolved resolved;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: Builder(
          builder: (context) {
            resolved = context.st;
            return const SizedBox();
          },
        ),
      ),
    );

    expect(resolved.surface, st.colors.surface.resolve(Brightness.light));
    expect(resolved.primary, st.colors.primary.resolve(Brightness.light));
    expect(resolved.background, st.colors.background.resolve(Brightness.light));
    expect(resolved.border, st.colors.border.resolve(Brightness.light));
    expect(resolved.text, st.colors.text.resolve(Brightness.light));
    expect(resolved.radius.md, BorderRadius.circular(12));
    expect(resolved.radius.mdValue, 12);
    expect(resolved.shadow.sm, isNotEmpty);
  });

  testWidgets('STScope overrides ThemeExtension', (tester) async {
    final base = sampleTheme();
    final overrideTheme = STTheme(
      colors: STColors(
        primary: const STColor(light: Color(0xFFFF0000)),
        surface: const STColor(light: Color(0xFF00FF00)),
        background: const STColor(light: Color(0xFF0000FF)),
        text: const STColor(light: Color(0xFF000000)),
      ),
    );

    late Color scopedPrimary;
    await tester.pumpWidget(
      MaterialApp(
        theme: base.light,
        home: STScope(
          theme: overrideTheme,
          brightness: Brightness.light,
          child: Builder(
            builder: (context) {
              scopedPrimary = context.st.primary;
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(scopedPrimary, const Color(0xFFFF0000));
  });
}
