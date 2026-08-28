import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

import 'support.dart';

void main() {
  testWidgets('extra button ButtonStyle uses authored disabled / pressed', (
    tester,
  ) async {
    const restFg = Color(0xFF6750A4);
    const disabledFg = Color(0xFF9E9E9E);
    const pressedFill = Color(0x1A6750A4);
    final st = sampleTheme(
      extras: [
        STExtra.button(
          'ghost',
          style: const STComponent(
            foreground: STColor(light: restFg),
            elevation: 0,
            states: STComponentStates(
              disabled: STComponent(foreground: STColor(light: disabledFg)),
              pressed: STComponent(fill: STColor(light: pressedFill)),
            ),
          ),
        ),
      ],
    );

    late ButtonStyle style;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: Builder(
          builder: (context) {
            style = context.st.extraButton('ghost').toButtonStyle();
            return const SizedBox();
          },
        ),
      ),
    );

    expect(style.foregroundColor!.resolve({}), restFg);
    expect(
      style.foregroundColor!.resolve(const {WidgetState.disabled}),
      disabledFg,
    );
    expect(
      style.backgroundColor!.resolve(const {WidgetState.pressed}),
      pressedFill,
    );
  });

  testWidgets('unauthored disabled fades rest fill (no new hue)', (
    tester,
  ) async {
    const fill = Color(0xFFB3261E);
    final st = sampleTheme(
      extras: [
        STExtra.button(
          'go',
          style: const STComponent(fill: STColor(light: fill), elevation: 0),
        ),
      ],
    );

    late ButtonStyle style;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: Builder(
          builder: (context) {
            style = context.st.extraButton('go').toButtonStyle();
            return const SizedBox();
          },
        ),
      ),
    );

    final rest = style.backgroundColor!.resolve({})!;
    final disabled =
        style.backgroundColor!.resolve(const {WidgetState.disabled})!;
    expect(rest, fill);
    expect(disabled, fill.withValues(alpha: fill.a * 0.38));
  });

  testWidgets('ThemeData elevated button respects disabled state', (
    tester,
  ) async {
    final st = sampleTheme();
    late ButtonStyle style;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: Builder(
          builder: (context) {
            style = Theme.of(context).elevatedButtonTheme.style!;
            return const SizedBox();
          },
        ),
      ),
    );

    final rest = style.backgroundColor!.resolve({})!;
    final disabled =
        style.backgroundColor!.resolve(const {WidgetState.disabled})!;
    expect(rest, st.colors.primary.resolve(Brightness.light));
    expect(disabled.a, lessThan(rest.a));
  });
}
