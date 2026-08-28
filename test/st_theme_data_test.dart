import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

import 'support.dart';

void main() {
  testWidgets('light ThemeData follows tokens', (tester) async {
    final st = sampleTheme();
    late ThemeData captured;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: Builder(
          builder: (context) {
            captured = Theme.of(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(
      captured.scaffoldBackgroundColor,
      st.colors.background.resolve(Brightness.light),
    );
    expect(
      captured.colorScheme.primary,
      st.colors.primary.resolve(Brightness.light),
    );
    expect(
      captured.cardTheme.color,
      st.colors.surface.resolve(Brightness.light),
    );
    expect(captured.extension<STThemeExtension>(), isNotNull);
    expect(captured.useMaterial3, isTrue);
    expect(captured.searchBarTheme.backgroundColor, isNotNull);
    expect(captured.sliderTheme.thumbColor, isNotNull);
    expect(captured.badgeTheme.backgroundColor, isNotNull);
    expect(captured.navigationRailTheme.backgroundColor, isNotNull);
  });

  testWidgets('component override maps to ThemeData', (tester) async {
    const fabFill = Color(0xFFFF5722);
    final st = sampleTheme().copyWith(
      components: const STComponents(
        fab: STComponent(fill: STColor(light: fabFill)),
        chip: STComponent(radius: 20),
      ),
    );
    late ThemeData captured;
    late STResolved resolved;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: Builder(
          builder: (context) {
            captured = Theme.of(context);
            resolved = context.st;
            return const SizedBox();
          },
        ),
      ),
    );

    expect(captured.floatingActionButtonTheme.backgroundColor, fabFill);
    expect(resolved.fab.fill, fabFill);
    expect(resolved.chip.radius, 20);
    expect(resolved.container('fab').fill, fabFill);
  });

  testWidgets('dark ThemeData uses dark colors', (tester) async {
    final st = sampleTheme();
    late ThemeData captured;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        darkTheme: st.dark,
        themeMode: ThemeMode.dark,
        home: Builder(
          builder: (context) {
            captured = Theme.of(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(
      captured.scaffoldBackgroundColor,
      st.colors.background.resolve(Brightness.dark),
    );
    expect(
      captured.colorScheme.primary,
      st.colors.primary.resolve(Brightness.dark),
    );
  });
}
