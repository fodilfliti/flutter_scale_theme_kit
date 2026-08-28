import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

import 'support.dart';

void main() {
  testWidgets('highlighted extra component resolves fill', (tester) async {
    const highlight = Color(0xFFFFF8E1);
    final st = sampleTheme(
      extraComponents: {
        'highlighted': const STComponent(fill: STColor(light: highlight)),
      },
    );

    late Color? fill;
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: Builder(
          builder: (context) {
            fill = context.st.container('highlighted').fill;
            return const SizedBox();
          },
        ),
      ),
    );

    expect(fill, highlight);
  });

  testWidgets('typed extras: buttons, cards, text roles', (tester) async {
    const ghostFg = Color(0xFF6750A4);
    const priceColor = Color(0xFF6750A4);
    final st = sampleTheme(
      extras: [
        STExtra.button(
          'ghost',
          style: const STComponent(
            foreground: STColor(light: ghostFg),
            elevation: 0,
          ),
        ),
        STExtra.card(
          'product',
          style: const STComponent(elevation: 0, radius: 20),
        ),
        STExtra.container(
          'highlight',
          style: const STComponent(fill: STColor(light: Color(0xFFFFF8E1))),
        ),
        STExtra.text(
          'price',
          token: const STTextToken(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            colorName: 'primary',
          ),
        ),
      ],
      typography: const STTypography(
        label: STTextToken(fontSize: 14, fontWeight: FontWeight.w600),
        sublabel: STTextToken(fontSize: 12, colorName: 'textSecondary'),
        description: STTextToken(fontSize: 14, height: 1.4),
      ),
    );

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

    expect(resolved.extraButton('ghost').foreground, ghostFg);
    expect(resolved.extraCard('product').radius, 20);
    expect(resolved.extraContainer('highlight').fill, const Color(0xFFFFF8E1));
    expect(resolved.extraText('price').fontSize, 18);
    expect(resolved.extraText('price').color, priceColor);
    expect(resolved.label.fontWeight, FontWeight.w600);
    expect(resolved.sublabel.fontSize, 12);
    expect(resolved.description.height, 1.4);
  });
}
