import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  test('pubspec has no forbidden dependencies', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final deps = pubspec.split('dev_dependencies:').first;
    expect(deps.contains('flutter_scale_kit:'), isFalse);
    expect(deps.contains('provider:'), isFalse);
    expect(deps.contains('material_color_utilities:'), isFalse);
  });

  test('lib does not import flutter_scale_kit', () {
    final dartFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    for (final file in dartFiles) {
      expect(
        file.readAsStringSync().contains('package:flutter_scale_kit'),
        isFalse,
        reason: file.path,
      );
    }
  });

  test('generate_core does not import Flutter', () {
    const files = [
      'lib/generate_core.dart',
      'lib/src/generate/st_ir.dart',
      'lib/src/generate/st_json.dart',
      'lib/src/generate/st_emit.dart',
      'lib/src/generate/st_names.dart',
      'lib/src/generate/st_dart_scan.dart',
    ];
    for (final path in files) {
      final source = File(path).readAsStringSync();
      expect(
        RegExp(r"^import 'package:flutter", multiLine: true).hasMatch(source),
        isFalse,
        reason: path,
      );
      expect(
        RegExp(r"^import 'dart:ui'", multiLine: true).hasMatch(source),
        isFalse,
        reason: path,
      );
    }
  });

  test('lib does not import dart:io', () {
    final dartFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    for (final file in dartFiles) {
      expect(
        file.readAsStringSync().contains("import 'dart:io'"),
        isFalse,
        reason: file.path,
      );
    }
  });

  testWidgets('MaterialApp works with this package only', (tester) async {
    final st = sampleTheme();
    await tester.pumpWidget(
      MaterialApp(
        theme: st.light,
        darkTheme: st.dark,
        home: const Scaffold(body: Text('ok')),
      ),
    );
    expect(find.text('ok'), findsOneWidget);
  });
}
