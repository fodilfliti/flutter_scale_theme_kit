import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';
import 'package:flutter_scale_theme_kit/generate.dart';

void main() {
  test('getter names suffix by kind', () {
    expect(stExtraGetterName('ghost', STIrKind.button), 'ghostButton');
    expect(stExtraGetterName('ghostButton', STIrKind.button), 'ghostButton');
    expect(stExtraGetterName('product', STIrKind.card), 'productCard');
    expect(
      stExtraGetterName('highlight', STIrKind.container),
      'highlightContainer',
    );
    expect(stExtraGetterName('price', STIrKind.text), 'price');
    expect(stExtraGetterName('product-card', STIrKind.card), 'productCard');
    expect(stExtraGetterName('label', STIrKind.text), 'labelExtra');
  });

  test('JSON extras become a typed Dart API', () {
    final json =
        jsonDecode(File('test/fixtures/st_theme.json').readAsStringSync())
            as Map<String, dynamic>;
    final dart = generateDartFromJson(json);

    expect(dart, contains('final appST = STTheme('));
    expect(dart, contains("STExtra.button(\n      'ghost'"));
    expect(dart, contains("STExtra.card(\n      'product'"));
    expect(dart, contains("STExtra.container(\n      'highlight'"));
    expect(dart, contains("STExtra.text(\n      'price'"));
    expect(dart, contains('extension STAppExtras on STResolved'));
    expect(
      dart,
      contains("STResolvedComponent get ghostButton => extraButton('ghost');"),
    );
    expect(
      dart,
      contains(
        'ButtonStyle get ghostButtonStyle => ghostButton.toButtonStyle();',
      ),
    );
    expect(
      dart,
      contains("STResolvedComponent get productCard => extraCard('product');"),
    );
    expect(
      dart,
      contains(
        "STResolvedComponent get highlightContainer => extraContainer('highlight');",
      ),
    );
    expect(dart, contains("TextStyle get price => extraText('price');"));
    expect(dart, contains("Color get brand => color('brand');"));
    expect(dart.contains('part of'), isFalse);
  });

  test('Dart extras emit getters only, including extra colors', () {
    final source = File('example/lib/design.dart').readAsStringSync();
    final dart = generateExtensionFromDart(source, partOf: 'design.dart');

    expect(dart.contains('final appST'), isFalse);
    expect(dart, contains("part of 'design.dart';"));
    expect(dart.contains('import '), isFalse);
    expect(dart, contains("Color get brand => color('brand');"));
    expect(
      dart,
      contains("STResolvedComponent get ghostButton => extraButton('ghost');"),
    );
    expect(
      dart,
      contains(
        'ButtonStyle get ghostButtonStyle => ghostButton.toButtonStyle();',
      ),
    );
    expect(
      dart,
      contains("STResolvedComponent get productCard => extraCard('product');"),
    );
    expect(dart, contains('Color? get productCardColor => productCard.fill;'));
    expect(dart, contains("TextStyle get price => extraText('price');"));
    expect(
      dart,
      contains(
        "STResolvedComponent get highlightedContainer => extraContainer('highlighted');",
      ),
    );
  });

  test('Dart scan ignores comments', () {
    const source = '''
final appST = STTheme(
  extras: [
    // STExtra.button('nope', style: STComponent()),
    STExtra.button('ghost'),
  ],
);
''';
    final tokens = parseStDartSource(source);
    expect(tokens.extras.map((e) => e.name).toList(), ['ghost']);
  });

  test('empty Dart extras throws', () {
    expect(
      () => generateExtensionFromDart('class Foo {}'),
      throwsFormatException,
    );
  });

  test('part-of omits imports', () {
    final dart = generateDartFromJson({
      'colors': {
        'primary': '#6750A4',
        'surface': '#FFFFFF',
        'background': '#F7F7F7',
        'text': '#1C1B1F',
      },
      'extras': {
        'ghost': {'kind': 'button'},
      },
    }, partOf: 'design.dart');
    expect(dart, contains("part of 'design.dart';"));
    expect(dart.contains('import '), isFalse);
  });

  test('missing kind throws', () {
    expect(
      () => parseStThemeJson({
        'colors': {
          'primary': '#6750A4',
          'surface': '#FFFFFF',
          'background': '#F7F7F7',
          'text': '#1C1B1F',
        },
        'extras': {
          'ghost': {'elevation': 0},
        },
      }),
      throwsFormatException,
    );
  });

  testWidgets('parsed extras resolve on context.st', (tester) async {
    final json =
        jsonDecode(File('test/fixtures/st_theme.json').readAsStringSync())
            as Map<String, dynamic>;
    final st = parseStThemeJson(json).theme;

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

    expect(resolved.extraButton('ghost').foreground, const Color(0xFF6750A4));
    expect(resolved.extraButton('ghost').toButtonStyle(), isA<ButtonStyle>());
    expect(resolved.extraButton('destructive').fill, const Color(0xFFB3261E));
    expect(resolved.extraCard('product').radius, 20);
    expect(resolved.extraContainer('highlight').fill, const Color(0xFFFFF8E1));
    expect(resolved.container('highlight').fill, const Color(0xFFFFF8E1));
    expect(resolved.extraText('price').fontSize, 18);
    expect(resolved.extraText('price').fontWeight, FontWeight.w600);
    expect(resolved.extraText('price').color, const Color(0xFF6750A4));
    expect(resolved.label.fontWeight, FontWeight.w600);
    expect(resolved.sublabel.fontSize, 12);
    expect(resolved.description.height, 1.4);
  });
}
