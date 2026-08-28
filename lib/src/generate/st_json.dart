import 'st_ir.dart';
import 'st_names.dart';

const _componentSlots = <String>{
  'card',
  'panel',
  'section',
  'dialog',
  'bottomSheet',
  'snackBar',
  'appBar',
  'navBar',
  'navigationBar',
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
  'floatingActionButton',
  'input',
  'searchBar',
  'dropdownMenu',
  'chip',
  'switch',
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
};

/// Reads a JSON object (from `jsonDecode`) into a Dart-only design IR.
STDesignIr parseStDesignJson(Map<String, dynamic> json) {
  final rawName =
      json['variable'] as String? ?? json['name'] as String? ?? 'appST';
  final variableName =
      stDartIdentifier(rawName) == rawName
          ? rawName
          : stDartIdentifier(rawName);
  final extensionName =
      json['extension'] as String? ?? stDefaultExtensionName(variableName);
  final partOf = json['partOf'] as String?;

  final colorsRaw = json['colors'];
  if (colorsRaw == null) {
    throw const FormatException('JSON needs a "colors" object');
  }
  final colors = _colors(_map(colorsRaw, 'colors'));

  STRadiusIr? radius;
  if (json['radius'] != null) {
    final radiusMap = _map(json['radius'], 'radius');
    radius = STRadiusIr(
      xs: _double(radiusMap['xs'], 'radius.xs'),
      sm: _double(radiusMap['sm'], 'radius.sm'),
      md: _double(radiusMap['md'], 'radius.md'),
      lg: _double(radiusMap['lg'], 'radius.lg'),
      xl: _double(radiusMap['xl'], 'radius.xl'),
    );
  }

  STTypographyIr? typography;
  if (json['typography'] != null) {
    typography = _typography(_map(json['typography'], 'typography'));
  }

  STComponentsIr? components;
  if (json['components'] != null) {
    components = _components(_map(json['components'], 'components'));
  }

  return STDesignIr(
    variableName: variableName,
    extensionName: extensionName,
    partOf: partOf,
    colors: colors,
    radius: radius,
    typography: typography,
    components: components,
    extras: _extras(json['extras']),
  );
}

STColorsIr _colors(Map<String, dynamic> map) {
  STColorIr req(String key) {
    final v = map[key];
    if (v == null) {
      throw FormatException('colors.$key is required');
    }
    return parseStColorIr(v, 'colors.$key');
  }

  STColorIr? opt(String key) {
    final v = map[key];
    if (v == null) return null;
    return parseStColorIr(v, 'colors.$key');
  }

  Map<String, STColorIr> extra = const {};
  if (map['extra'] != null) {
    extra = {
      for (final e in _map(map['extra'], 'colors.extra').entries)
        e.key: parseStColorIr(e.value, 'colors.extra.${e.key}'),
    };
  }

  return STColorsIr(
    primary: req('primary'),
    surface: req('surface'),
    background: req('background'),
    text: req('text'),
    secondary: opt('secondary'),
    border: opt('border'),
    divider: opt('divider'),
    textSecondary: opt('textSecondary'),
    error: opt('error'),
    success: opt('success'),
    warning: opt('warning'),
    info: opt('info'),
    extra: extra,
    fields: map.keys.toSet(),
  );
}

STTypographyIr _typography(Map<String, dynamic> map) {
  return STTypographyIr(
    fontFamily: map['fontFamily'] as String?,
    label: _textTokenOpt(map['label'], 'typography.label'),
    sublabel: _textTokenOpt(map['sublabel'], 'typography.sublabel'),
    description: _textTokenOpt(map['description'], 'typography.description'),
  );
}

STComponentsIr _components(Map<String, dynamic> map) {
  final slots = <String, STComponentIr>{};
  for (final key in map.keys) {
    if (key == 'extra') continue;
    if (!_componentSlots.contains(key)) {
      throw FormatException(
        'Unknown components.$key. Use extras with a kind, or a known slot name.',
      );
    }
    final slot = switch (key) {
      'navigationBar' => 'navBar',
      'floatingActionButton' => 'fab',
      'switch' => 'switchControl',
      _ => key,
    };
    slots[slot] = parseStComponentIr(map[key], 'components.$key');
  }

  Map<String, STComponentIr> extra = const {};
  if (map['extra'] != null) {
    extra = {
      for (final e in _map(map['extra'], 'components.extra').entries)
        e.key: parseStComponentIr(e.value, 'components.extra.${e.key}'),
    };
  }

  return STComponentsIr(slots: slots, extra: extra);
}

List<STExtraIr> _extras(Object? raw) {
  if (raw == null) return const [];
  if (raw is Map) {
    return _extrasFromMap(_map(raw, 'extras'), 'extras');
  }
  if (raw is List) {
    final seen = <String>{};
    final list = <STExtraIr>[];
    for (var i = 0; i < raw.length; i++) {
      final item = _map(raw[i], 'extras[$i]');
      final name = item['name'] as String?;
      if (name == null || name.isEmpty) {
        throw FormatException('extras[$i] needs "name"');
      }
      if (!seen.add(name)) {
        throw FormatException('Duplicate extra "$name"');
      }
      list.add(parseStExtraIr(name, item, 'extras[$i]'));
    }
    return list;
  }
  throw const FormatException('extras must be an object or a list');
}

List<STExtraIr> _extrasFromMap(Map<String, dynamic> map, String path) {
  final seen = <String>{};
  final list = <STExtraIr>[];
  for (final e in map.entries) {
    if (!seen.add(e.key)) {
      throw FormatException('Duplicate extra "${e.key}"');
    }
    list.add(parseStExtraIr(e.key, e.value, '$path.${e.key}'));
  }
  return list;
}

STExtraIr parseStExtraIr(String name, Object? raw, String path) {
  if (name.isEmpty) {
    throw FormatException('$path has an empty name');
  }
  final map = _map(raw, path);
  final kind = parseStIrKind(map['kind'], path);
  if (kind == STIrKind.text) {
    final tokenRaw = map['token'] ?? map;
    return STExtraIr(
      name: name,
      kind: kind,
      text: parseStTextTokenIr(tokenRaw, path),
    );
  }
  return STExtraIr(
    name: name,
    kind: kind,
    style: parseStComponentIr(map, path),
  );
}

STIrKind parseStIrKind(Object? raw, String path) {
  if (raw is! String) {
    throw FormatException('$path needs kind: button | card | container | text');
  }
  switch (raw.toLowerCase()) {
    case 'button':
      return STIrKind.button;
    case 'card':
      return STIrKind.card;
    case 'container':
      return STIrKind.container;
    case 'text':
      return STIrKind.text;
    default:
      throw FormatException(
        '$path kind must be button | card | container | text (got "$raw")',
      );
  }
}

STComponentIr parseStComponentIr(Object? raw, String path) {
  final map = _map(raw, path);
  return STComponentIr(
    fill:
        map['fill'] == null ? null : parseStColorIr(map['fill'], '$path.fill'),
    foreground:
        map['foreground'] == null
            ? null
            : parseStColorIr(map['foreground'], '$path.foreground'),
    border:
        map['border'] == null
            ? null
            : parseStColorIr(map['border'], '$path.border'),
    elevation: _double(map['elevation'], '$path.elevation'),
    radius: _double(map['radius'], '$path.radius'),
    filled: map['filled'] as bool?,
  );
}

STTextTokenIr? _textTokenOpt(Object? raw, String path) {
  if (raw == null) return null;
  return parseStTextTokenIr(raw, path);
}

STTextTokenIr parseStTextTokenIr(Object? raw, String path) {
  final map = _map(raw, path);
  return STTextTokenIr(
    fontSize: _double(map['fontSize'], '$path.fontSize'),
    fontWeight: parseStFontWeightValue(map['fontWeight'], '$path.fontWeight'),
    fontStyle: parseStFontStyleName(map['fontStyle'], '$path.fontStyle'),
    height: _double(map['height'], '$path.height'),
    letterSpacing: _double(map['letterSpacing'], '$path.letterSpacing'),
    color:
        map['color'] == null
            ? null
            : parseStColorIr(map['color'], '$path.color'),
    colorName: map['colorName'] as String?,
  );
}

int? parseStFontWeightValue(Object? raw, String path) {
  if (raw == null) return null;
  if (raw is num) {
    final n = raw.round();
    if (n < 100 || n > 900 || n % 100 != 0) {
      throw FormatException('$path unknown fontWeight $raw');
    }
    return n;
  }
  if (raw is String) {
    final s = raw.toLowerCase().replaceAll('-', '').replaceAll('_', '');
    switch (s) {
      case 'thin':
        return 100;
      case 'extralight':
        return 200;
      case 'light':
        return 300;
      case 'regular':
      case 'normal':
        return 400;
      case 'medium':
        return 500;
      case 'semibold':
        return 600;
      case 'bold':
        return 700;
      case 'extrabold':
        return 800;
      case 'black':
        return 900;
      default:
        if (s.startsWith('w') && s.length > 1) {
          return parseStFontWeightValue(int.parse(s.substring(1)), path);
        }
        throw FormatException('$path unknown fontWeight "$raw"');
    }
  }
  throw FormatException('$path unknown fontWeight $raw');
}

String? parseStFontStyleName(Object? raw, String path) {
  if (raw == null) return null;
  if (raw is String) {
    switch (raw.toLowerCase()) {
      case 'italic':
        return 'italic';
      case 'normal':
        return 'normal';
    }
  }
  throw FormatException('$path unknown fontStyle $raw');
}

STColorIr parseStColorIr(Object? raw, String path) {
  if (raw is String) {
    return STColorIr(light: parseCssColorInt(raw, path));
  }
  if (raw is Map) {
    final map = _map(raw, path);
    final light = map['light'] ?? map['value'];
    if (light is! String) {
      throw FormatException('$path needs "light" (hex string)');
    }
    final dark = map['dark'];
    return STColorIr(
      light: parseCssColorInt(light, '$path.light'),
      dark:
          dark == null ? null : parseCssColorInt(dark as String, '$path.dark'),
    );
  }
  throw FormatException('$path expected a hex string or {light, dark}');
}

int parseCssColorInt(String raw, String path) {
  var s = raw.trim();
  if (s.startsWith('#')) {
    s = s.substring(1);
    if (s.length == 6) s = 'FF$s';
    if (s.length == 8) {
      return int.parse(s, radix: 16);
    }
    throw FormatException('$path invalid hex "$raw"');
  }
  if (s.startsWith('0x') || s.startsWith('0X')) {
    return int.parse(s);
  }
  throw FormatException('$path invalid color "$raw"');
}

Map<String, dynamic> _map(Object? value, String path) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((key, v) => MapEntry(key.toString(), v));
  }
  throw FormatException('Expected object at $path');
}

double? _double(Object? value, String path) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  throw FormatException('$path expected a number');
}
