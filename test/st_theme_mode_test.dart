import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

import 'support.dart';

void main() {
  testWidgets('STThemeModeSwitch changes MaterialApp themeMode', (
    tester,
  ) async {
    final st = sampleTheme();
    await tester.pumpWidget(
      STThemeModeScope(
        initialMode: ThemeMode.light,
        builder: (context, mode) {
          return MaterialApp(
            theme: st.light,
            darkTheme: st.dark,
            themeMode: mode.mode,
            home: const Scaffold(body: STThemeModeSwitch()),
          );
        },
      ),
    );

    expect(
      Theme.of(tester.element(find.byType(Switch))).brightness,
      Brightness.light,
    );

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.byType(Switch))).brightness,
      Brightness.dark,
    );
  });

  testWidgets('context.stMode.setMode rebuilds the app', (tester) async {
    final st = sampleTheme();
    await tester.pumpWidget(
      STThemeModeScope(
        initialMode: ThemeMode.light,
        builder: (context, mode) {
          return MaterialApp(
            theme: st.light,
            darkTheme: st.dark,
            themeMode: mode.mode,
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () => context.stMode.setMode(ThemeMode.dark),
                    child: const Text('dark'),
                  );
                },
              ),
            ),
          );
        },
      ),
    );

    await tester.tap(find.text('dark'));
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.text('dark'))).brightness,
      Brightness.dark,
    );
  });

  testWidgets('context.stMode throws without STThemeModeScope', (tester) async {
    final st = sampleTheme();
    FlutterError? caught;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: Builder(
          builder: (context) {
            try {
              context.stMode;
            } on FlutterError catch (e) {
              caught = e;
            }
            return const SizedBox();
          },
        ),
      ),
    );
    expect(caught, isNotNull);
    expect('$caught', contains('STThemeModeScope'));
  });
}
