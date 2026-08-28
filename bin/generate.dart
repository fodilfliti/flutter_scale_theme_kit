import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_scale_theme_kit/generate_core.dart';

Future<void> main(List<String> args) async {
  try {
    await _run(args);
  } on FormatException catch (e) {
    stderr.writeln(e.message);
    exitCode = 65;
  }
}

Future<void> _run(List<String> args) async {
  if (args.contains('-h') ||
      args.contains('--help') ||
      (args.isNotEmpty && args.first == 'help')) {
    stdout.writeln(_usage);
    return;
  }

  var watch = false;
  String? input;
  String? output;
  String? variableName;
  String? extensionName;
  String? partOf;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    switch (arg) {
      case 'watch':
      case '--watch':
      case '-w':
        watch = true;
      case '-i':
      case '--in':
      case '--from-dart':
        input = _next(args, ++i, arg);
      case '-o':
      case '--out':
        output = _next(args, ++i, arg);
      case '-n':
      case '--name':
        variableName = _next(args, ++i, arg);
      case '-e':
      case '--extension':
        extensionName = _next(args, ++i, arg);
      case '-p':
      case '--part-of':
        partOf = _next(args, ++i, arg);
      default:
        if (arg.startsWith('-')) {
          stderr.writeln('Unknown argument: $arg');
          stderr.writeln(_usage);
          exitCode = 64;
          return;
        }
        if (input != null) {
          stderr.writeln('Unexpected extra path: $arg');
          stderr.writeln(_usage);
          exitCode = 64;
          return;
        }
        input = arg;
    }
  }

  input ??= _findInput();
  if (input == null) {
    stderr.writeln(
      'No design file found. Pass a path or add lib/design.dart / st_theme.json.',
    );
    stderr.writeln(_usage);
    exitCode = 64;
    return;
  }

  final inFile = File(input);
  if (!inFile.existsSync()) {
    stderr.writeln('Input not found: $input');
    exitCode = 66;
    return;
  }

  output ??= _sidecar(input);
  final outFile = File(output);
  final dartMode = input.toLowerCase().endsWith('.dart');
  if (dartMode) {
    partOf ??= _basename(input);
  }

  void generate() {
    final dart =
        dartMode
            ? generateExtensionFromDart(
              inFile.readAsStringSync(),
              extensionName: extensionName,
              partOf: partOf,
            )
            : generateDartFromJson(
              _readJson(inFile),
              variableName: variableName,
              extensionName: extensionName,
              partOf: partOf,
            );
    outFile.parent.createSync(recursive: true);
    outFile.writeAsStringSync(dart);
    stdout.writeln('Wrote $output');
  }

  if (!watch) {
    generate();
    return;
  }

  generate();
  stdout.writeln('Watching $input — Ctrl+C to stop');
  final outName = _basename(output).toLowerCase();
  final inName = _basename(input).toLowerCase();
  Timer? debounce;
  await for (final event in inFile.parent.watch()) {
    final name = _basename(event.path).toLowerCase();
    if (name == outName) continue;
    if (name != inName) continue;
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () {
      try {
        generate();
      } on FormatException catch (e) {
        stderr.writeln(e.message);
      }
    });
  }
}

Map<String, dynamic> _readJson(File file) {
  final decoded = jsonDecode(file.readAsStringSync());
  if (decoded is! Map) {
    throw const FormatException('JSON root must be an object');
  }
  return Map<String, dynamic>.from(decoded);
}

String? _findInput() {
  const candidates = [
    'lib/design.dart',
    'design.dart',
    'lib/st_theme.json',
    'st_theme.json',
    'design.json',
  ];
  for (final path in candidates) {
    if (File(path).existsSync()) return path;
  }
  return null;
}

String _sidecar(String path) {
  final lower = path.toLowerCase();
  if (lower.endsWith('.dart') || lower.endsWith('.json')) {
    return '${path.substring(0, path.length - 5)}.g.dart';
  }
  return '$path.g.dart';
}

String _basename(String path) {
  return path.replaceAll('\\', '/').split('/').last;
}

String _next(List<String> args, int i, String flag) {
  if (i >= args.length) {
    throw FormatException('$flag needs a value');
  }
  return args[i];
}

const _usage = '''
Generate typed context.st getters (and optional JSON → STTheme).

Usage:
  dart run flutter_scale_theme_kit:generate [watch] [file]

  file    .dart  → getters only (ghostButton, brand, …) next to the file
          .json  → full STTheme + getters
          omit   → lib/design.dart, design.dart, or st_theme.json

  watch   regenerate when [file] changes

Options:
  -o, --out          Output path (default: <file>.g.dart)
  -e, --extension    Extension name (default: STAppExtras)
  -p, --part-of      Emit part of 'file.dart' (.dart default: the input name)
  -n, --name         STTheme variable (JSON only)
  -h, --help
''';
