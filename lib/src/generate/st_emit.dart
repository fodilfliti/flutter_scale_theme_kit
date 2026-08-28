import 'st_dart_scan.dart';
import 'st_ir.dart';
import 'st_json.dart';
import 'st_names.dart';

const _slotOrder = [
  'card',
  'panel',
  'section',
  'dialog',
  'bottomSheet',
  'snackBar',
  'appBar',
  'navBar',
  'navigationRail',
  'drawer',
  'bottomAppBar',
  'tabBar',
  'button',
  'elevatedButton',
  'filledButton',
  'outlinedButton',
  'textButton',
  'iconButton',
  'fab',
  'input',
  'searchBar',
  'dropdownMenu',
  'chip',
  'switchControl',
  'checkbox',
  'radio',
  'slider',
  'segmentedButton',
  'listTile',
  'expansionTile',
  'tooltip',
  'progress',
  'popupMenu',
  'badge',
  'divider',
  'datePicker',
  'timePicker',
];

/// Turns JSON into a Dart library (or `part of`) that looks hand-written.
String generateDartFromJson(
  Map<String, dynamic> json, {
  String? variableName,
  String? extensionName,
  String? partOf,
}) {
  final ir = parseStDesignJson(json);
  return emitStThemeDart(
    ir,
    variableName: variableName,
    extensionName: extensionName,
    partOf: partOf,
  );
}

String emitStThemeDart(
  STDesignIr ir, {
  String? variableName,
  String? extensionName,
  String? partOf,
}) {
  final name = variableName ?? ir.variableName;
  final extName = extensionName ?? ir.extensionName;
  final part = partOf ?? ir.partOf;
  final buf = StringBuffer();
  buf.writeln('// GENERATED CODE - do not modify by hand.');
  buf.writeln('// dart run flutter_scale_theme_kit:generate');
  buf.writeln();
  if (part != null) {
    buf.writeln("part of '$part';");
    buf.writeln();
  } else {
    buf.writeln("import 'package:flutter/material.dart';");
    buf.writeln(
      "import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';",
    );
    buf.writeln();
  }

  buf.writeln('final $name = STTheme(');
  _emitColors(buf, ir.colors);
  _emitRadius(buf, ir.radius);
  _emitTypography(buf, ir.typography);
  _emitComponents(buf, ir.components);
  _emitExtras(buf, ir.extras);
  buf.writeln(');');
  buf.writeln();
  emitStResolvedExtension(
    buf,
    extras: ir.extras,
    extraColors: ir.colors.extra.keys.toList(),
    extraComponents: ir.components?.extra.keys.toList() ?? const [],
    extensionName: extName,
  );
  return buf.toString();
}

void _emitColors(StringBuffer buf, STColorsIr colors) {
  buf.writeln('  colors: STColors(');
  buf.writeln('    primary: ${_stColor(colors.primary, asConst: true)},');
  if (colors.secondary != null) {
    buf.writeln(
      '    secondary: ${_stColor(colors.secondary!, asConst: true)},',
    );
  }
  buf.writeln('    surface: ${_stColor(colors.surface, asConst: true)},');
  buf.writeln('    background: ${_stColor(colors.background, asConst: true)},');
  if (colors.border != null) {
    buf.writeln('    border: ${_stColor(colors.border!, asConst: true)},');
  }
  if (colors.divider != null) {
    buf.writeln('    divider: ${_stColor(colors.divider!, asConst: true)},');
  }
  buf.writeln('    text: ${_stColor(colors.text, asConst: true)},');
  if (colors.textSecondary != null) {
    buf.writeln(
      '    textSecondary: ${_stColor(colors.textSecondary!, asConst: true)},',
    );
  }
  if (colors.error != null) {
    buf.writeln('    error: ${_stColor(colors.error!, asConst: true)},');
  }
  if (colors.success != null) {
    buf.writeln('    success: ${_stColor(colors.success!, asConst: true)},');
  }
  if (colors.warning != null) {
    buf.writeln('    warning: ${_stColor(colors.warning!, asConst: true)},');
  }
  if (colors.info != null) {
    buf.writeln('    info: ${_stColor(colors.info!, asConst: true)},');
  }
  if (colors.extra.isNotEmpty) {
    buf.writeln('    extra: {');
    for (final e in colors.extra.entries) {
      buf.writeln(
        "      '${_escape(e.key)}': ${_stColor(e.value, asConst: true)},",
      );
    }
    buf.writeln('    },');
  }
  buf.writeln('  ),');
}

void _emitRadius(StringBuffer buf, STRadiusIr? radius) {
  if (radius == null || !radius.isSet) return;
  final parts = <String>[];
  void add(String name, double? value) {
    if (value != null) parts.add('$name: ${_num(value)}');
  }

  add('xs', radius.xs);
  add('sm', radius.sm);
  add('md', radius.md);
  add('lg', radius.lg);
  add('xl', radius.xl);
  if (parts.isEmpty) return;
  buf.writeln('  radius: const STRadius(${parts.join(', ')}),');
}

void _emitTypography(StringBuffer buf, STTypographyIr? typography) {
  if (typography == null) return;
  buf.writeln('  typography: STTypography(');
  if (typography.fontFamily != null) {
    buf.writeln("    fontFamily: '${_escape(typography.fontFamily!)}',");
  }
  if (typography.label != null) {
    buf.writeln('    label: ${_textToken(typography.label!)},');
  }
  if (typography.sublabel != null) {
    buf.writeln('    sublabel: ${_textToken(typography.sublabel!)},');
  }
  if (typography.description != null) {
    buf.writeln('    description: ${_textToken(typography.description!)},');
  }
  buf.writeln('  ),');
}

void _emitComponents(StringBuffer buf, STComponentsIr? components) {
  if (components == null || !components.isSet) return;
  buf.writeln('  components: STComponents(');
  for (final name in _slotOrder) {
    final c = components.slots[name];
    if (c == null || !c.isSet) continue;
    buf.writeln('    $name: ${_component(c)},');
  }
  if (components.extra.isNotEmpty) {
    buf.writeln('    extra: {');
    for (final e in components.extra.entries) {
      buf.writeln("      '${_escape(e.key)}': ${_component(e.value)},");
    }
    buf.writeln('    },');
  }
  buf.writeln('  ),');
}

void _emitExtras(StringBuffer buf, List<STExtraIr> extras) {
  if (extras.isEmpty) return;
  buf.writeln('  extras: [');
  for (final extra in extras) {
    switch (extra.kind) {
      case STIrKind.button:
        buf.write("    STExtra.button(\n      '${_escape(extra.name)}'");
        if (extra.style.isSet) {
          buf.write(',\n      style: ${_component(extra.style)}');
        }
        buf.writeln(',');
        buf.writeln('    ),');
      case STIrKind.card:
        buf.write("    STExtra.card(\n      '${_escape(extra.name)}'");
        if (extra.style.isSet) {
          buf.write(',\n      style: ${_component(extra.style)}');
        }
        buf.writeln(',');
        buf.writeln('    ),');
      case STIrKind.container:
        buf.write("    STExtra.container(\n      '${_escape(extra.name)}'");
        if (extra.style.isSet) {
          buf.write(',\n      style: ${_component(extra.style)}');
        }
        buf.writeln(',');
        buf.writeln('    ),');
      case STIrKind.text:
        buf.writeln('    STExtra.text(');
        buf.writeln("      '${_escape(extra.name)}',");
        buf.writeln(
          '      token: ${_textToken(extra.text ?? const STTextTokenIr())},',
        );
        buf.writeln('    ),');
    }
  }
  buf.writeln('  ],');
}

void emitStResolvedExtension(
  StringBuffer buf, {
  required String extensionName,
  List<STExtraIr> extras = const [],
  List<String> extraColors = const [],
  List<String> extraComponents = const [],
}) {
  final extraNames = extras.map((e) => e.name).toSet();
  final containers = [
    for (final name in extraComponents)
      if (!extraNames.contains(name))
        STExtraIr(name: name, kind: STIrKind.container),
  ];
  if (extras.isEmpty && extraColors.isEmpty && containers.isEmpty) return;

  final used = <String>{};
  buf.writeln('extension $extensionName on STResolved {');

  if (extraColors.isNotEmpty) {
    buf.writeln('  // Extra colors — Color (Container, Text, …)');
    for (final name in extraColors) {
      final getter = _claim(used, stColorGetterName(name), name);
      buf.writeln("  Color get $getter => color('${_escape(name)}');");
    }
  }

  void claimStyle(String getter, String suffix) {
    final styled = '$getter$suffix';
    if (!used.add(styled)) {
      throw FormatException('Generated getter "$styled" is used twice.');
    }
  }

  var section = '';
  void kindComment(String label) {
    if (section == label) return;
    section = label;
    buf.writeln('  // $label');
  }

  for (final extra in extras) {
    final getter = _claim(
      used,
      stExtraGetterName(extra.name, extra.kind),
      extra.name,
    );
    final escaped = _escape(extra.name);
    switch (extra.kind) {
      case STIrKind.button:
        kindComment('Buttons — ButtonStyle (ElevatedButton, FilledButton, …)');
        claimStyle(getter, 'Style');
        buf.writeln(
          "  STResolvedComponent get $getter => extraButton('$escaped');",
        );
        buf.writeln(
          '  ButtonStyle get ${getter}Style => $getter.toButtonStyle();',
        );
      case STIrKind.card:
        kindComment('Cards — BoxDecoration / fill Color');
        claimStyle(getter, 'Decoration');
        claimStyle(getter, 'Color');
        buf.writeln(
          "  STResolvedComponent get $getter => extraCard('$escaped');",
        );
        buf.writeln(
          '  BoxDecoration get ${getter}Decoration => $getter.toBoxDecoration();',
        );
        buf.writeln('  Color? get ${getter}Color => $getter.fill;');
      case STIrKind.container:
        kindComment('Containers — BoxDecoration / fill Color');
        claimStyle(getter, 'Decoration');
        claimStyle(getter, 'Color');
        buf.writeln(
          "  STResolvedComponent get $getter => extraContainer('$escaped');",
        );
        buf.writeln(
          '  BoxDecoration get ${getter}Decoration => $getter.toBoxDecoration();',
        );
        buf.writeln('  Color? get ${getter}Color => $getter.fill;');
      case STIrKind.text:
        kindComment('Text — TextStyle');
        buf.writeln("  TextStyle get $getter => extraText('$escaped');");
    }
  }

  if (containers.isNotEmpty) {
    kindComment('Containers — BoxDecoration / fill Color');
  }

  for (final extra in containers) {
    final getter = _claim(
      used,
      stExtraGetterName(extra.name, STIrKind.container),
      extra.name,
    );
    claimStyle(getter, 'Decoration');
    claimStyle(getter, 'Color');
    final escaped = _escape(extra.name);
    buf.writeln("  STResolvedComponent get $getter => container('$escaped');");
    buf.writeln(
      '  BoxDecoration get ${getter}Decoration => $getter.toBoxDecoration();',
    );
    buf.writeln('  Color? get ${getter}Color => $getter.fill;');
  }

  buf.writeln('}');
}

String _claim(Set<String> used, String getter, String sourceName) {
  if (!used.add(getter)) {
    throw FormatException(
      'Generated getter "$getter" is used twice. Rename extra "$sourceName".',
    );
  }
  return getter;
}

/// Extension-only Dart from a hand-written `STTheme` file. Does not emit `appST`.
String generateExtensionFromDart(
  String source, {
  String? extensionName,
  String? partOf,
}) {
  final tokens = parseStDartSource(source);
  if (tokens.isEmpty) {
    throw const FormatException(
      'No STExtra, extra colors (\'name\': STColor), or extra components found.',
    );
  }
  final name =
      extensionName ??
      (tokens.variableName == null
          ? 'STAppExtras'
          : stDefaultExtensionName(tokens.variableName!));
  final buf = StringBuffer();
  buf.writeln('// GENERATED CODE - do not modify by hand.');
  buf.writeln('// dart run flutter_scale_theme_kit:generate');
  buf.writeln();
  if (partOf != null) {
    buf.writeln("part of '$partOf';");
    buf.writeln();
  } else {
    buf.writeln("import 'package:flutter/material.dart';");
    buf.writeln(
      "import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';",
    );
    buf.writeln();
  }
  emitStResolvedExtension(
    buf,
    extras: tokens.extras,
    extraColors: tokens.extraColors,
    extraComponents: tokens.extraComponents,
    extensionName: name,
  );
  return buf.toString();
}

String _component(STComponentIr c) {
  final fields = <String>[];
  if (c.fill != null) fields.add('fill: ${_stColor(c.fill!)}');
  if (c.foreground != null) {
    fields.add('foreground: ${_stColor(c.foreground!)}');
  }
  if (c.border != null) fields.add('border: ${_stColor(c.border!)}');
  if (c.elevation != null) fields.add('elevation: ${_num(c.elevation!)}');
  if (c.radius != null) fields.add('radius: ${_num(c.radius!)}');
  if (c.filled != null) fields.add('filled: ${c.filled}');
  if (fields.isEmpty) return 'const STComponent()';
  return 'const STComponent(${fields.join(', ')})';
}

String _textToken(STTextTokenIr t) {
  final fields = <String>[];
  if (t.fontSize != null) fields.add('fontSize: ${_num(t.fontSize!)}');
  if (t.fontWeight != null) {
    fields.add('fontWeight: FontWeight.w${t.fontWeight}');
  }
  if (t.fontStyle != null) {
    fields.add('fontStyle: FontStyle.${t.fontStyle}');
  }
  if (t.height != null) fields.add('height: ${_num(t.height!)}');
  if (t.letterSpacing != null) {
    fields.add('letterSpacing: ${_num(t.letterSpacing!)}');
  }
  if (t.color != null) fields.add('color: ${_stColor(t.color!)}');
  if (t.colorName != null) {
    fields.add("colorName: '${_escape(t.colorName!)}'");
  }
  if (fields.isEmpty) return 'const STTextToken()';
  return 'const STTextToken(${fields.join(', ')})';
}

String _stColor(STColorIr c, {bool asConst = false}) {
  final prefix = asConst ? 'const ' : '';
  if (c.dark == null) {
    return '${prefix}STColor(light: ${_color(c.light)})';
  }
  return '${prefix}STColor(light: ${_color(c.light)}, dark: ${_color(c.dark!)})';
}

String _color(int argb) {
  final hex = argb.toRadixString(16).toUpperCase().padLeft(8, '0');
  return 'Color(0x$hex)';
}

String _num(double v) {
  if (v == v.roundToDouble()) return v.toInt().toString();
  return v.toString();
}

String _escape(String s) => s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
