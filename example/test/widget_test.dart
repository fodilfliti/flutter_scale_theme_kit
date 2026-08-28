import 'package:flutter/material.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('theme kit MaterialApp smoke', (tester) async {
    final st = STTheme(
      colors: STColors(
        primary: const STColor(light: Color(0xFF6750A4)),
        surface: const STColor(light: Color(0xFFFFFFFF)),
        background: const STColor(light: Color(0xFFF7F7F7)),
        text: const STColor(light: Color(0xFF1C1B1F)),
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        home: const Scaffold(body: Text('Hello Scale Theme')),
      ),
    );
    expect(find.text('Hello Scale Theme'), findsOneWidget);
  });
}
