import 'st_ir.dart';

/// Names + kinds scanned from hand-written Dart (`STTheme` / `STExtra`).
class STDartTokens {
  final String? variableName;
  final List<STExtraIr> extras;
  final List<String> extraColors;
  final List<String> extraComponents;

  const STDartTokens({
    this.variableName,
    this.extras = const [],
    this.extraColors = const [],
    this.extraComponents = const [],
  });

  bool get isEmpty =>
      extras.isEmpty && extraColors.isEmpty && extraComponents.isEmpty;
}

/// Reads extras, extra colors, and untyped extra components from Dart source.
/// Does not parse the full `STTheme` constructor.
STDartTokens parseStDartSource(String source) {
  final code = stStripDartComments(source);
  final variableName = _variableName(code);
  final extras = _extras(code);
  final extraNames = extras.map((e) => e.name).toSet();
  final extraColors = _mapKeys(code, 'STColor');
  final extraComponents =
      _mapKeys(
        code,
        'STComponent',
      ).where((name) => !extraNames.contains(name)).toList();

  return STDartTokens(
    variableName: variableName,
    extras: extras,
    extraColors: extraColors,
    extraComponents: extraComponents,
  );
}

String stStripDartComments(String source) {
  final out = StringBuffer();
  var i = 0;
  var lineComment = false;
  var blockComment = false;
  var quote = 0; // 0 none, 1 ', 2 "

  while (i < source.length) {
    final c = source[i];
    final next = i + 1 < source.length ? source[i + 1] : '';

    if (lineComment) {
      if (c == '\n') {
        lineComment = false;
        out.write(c);
      }
      i++;
      continue;
    }
    if (blockComment) {
      if (c == '*' && next == '/') {
        blockComment = false;
        i += 2;
        continue;
      }
      i++;
      continue;
    }
    if (quote != 0) {
      out.write(c);
      if (c == r'\' && next.isNotEmpty) {
        out.write(next);
        i += 2;
        continue;
      }
      if ((quote == 1 && c == "'") || (quote == 2 && c == '"')) {
        quote = 0;
      }
      i++;
      continue;
    }
    if (c == '/' && next == '/') {
      lineComment = true;
      i += 2;
      continue;
    }
    if (c == '/' && next == '*') {
      blockComment = true;
      i += 2;
      continue;
    }
    if (c == "'") {
      quote = 1;
      out.write(c);
      i++;
      continue;
    }
    if (c == '"') {
      quote = 2;
      out.write(c);
      i++;
      continue;
    }
    out.write(c);
    i++;
  }
  return out.toString();
}

String? _variableName(String code) {
  final match = RegExp(
    r'(?:final|const|var|late\s+final)\s+(\w+)\s*=\s*STTheme\s*\(',
  ).firstMatch(code);
  return match?.group(1);
}

List<STExtraIr> _extras(String code) {
  final seen = <String>{};
  final list = <STExtraIr>[];

  void add(String name, STIrKind kind) {
    if (name.isEmpty) return;
    if (!seen.add(name)) {
      throw FormatException('Duplicate extra "$name"');
    }
    list.add(STExtraIr(name: name, kind: kind));
  }

  final factory = RegExp(
    r'''STExtra\.(button|card|container|text)\s*\(\s*['"]([^'"]+)['"]''',
  );
  for (final match in factory.allMatches(code)) {
    add(match.group(2)!, _kind(match.group(1)!));
  }

  final named = RegExp(
    r'''STExtra\s*\(\s*name:\s*['"]([^'"]+)['"][\s\S]*?kind:\s*STKind\.(button|card|container|text)''',
  );
  for (final match in named.allMatches(code)) {
    add(match.group(1)!, _kind(match.group(2)!));
  }

  return list;
}

List<String> _mapKeys(String code, String typeName) {
  final seen = <String>[];
  final re = RegExp("['\"]([^'\"]+)['\"]\\s*:\\s*(?:const\\s+)?$typeName\\b");
  for (final match in re.allMatches(code)) {
    final name = match.group(1)!;
    if (!seen.contains(name)) seen.add(name);
  }
  return seen;
}

STIrKind _kind(String raw) {
  switch (raw) {
    case 'button':
      return STIrKind.button;
    case 'card':
      return STIrKind.card;
    case 'container':
      return STIrKind.container;
    case 'text':
      return STIrKind.text;
    default:
      throw FormatException('Unknown extra kind "$raw"');
  }
}
