/// Kind of extra token. Dart-only copy of runtime [STKind] so the CLI has no Flutter.
enum STIrKind { button, card, container, text }

class STColorIr {
  final int light;
  final int? dark;

  const STColorIr({required this.light, this.dark});
}

class STComponentIr {
  final STColorIr? fill;
  final STColorIr? foreground;
  final STColorIr? border;
  final double? elevation;
  final double? radius;
  final bool? filled;

  const STComponentIr({
    this.fill,
    this.foreground,
    this.border,
    this.elevation,
    this.radius,
    this.filled,
  });

  bool get isSet =>
      fill != null ||
      foreground != null ||
      border != null ||
      elevation != null ||
      radius != null ||
      filled != null;
}

class STTextTokenIr {
  final double? fontSize;
  final int? fontWeight;
  final String? fontStyle;
  final double? height;
  final double? letterSpacing;
  final STColorIr? color;
  final String? colorName;

  const STTextTokenIr({
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.height,
    this.letterSpacing,
    this.color,
    this.colorName,
  });

  bool get isSet =>
      fontSize != null ||
      fontWeight != null ||
      fontStyle != null ||
      height != null ||
      letterSpacing != null ||
      color != null ||
      colorName != null;
}

class STColorsIr {
  final STColorIr primary;
  final STColorIr surface;
  final STColorIr background;
  final STColorIr text;
  final STColorIr? secondary;
  final STColorIr? border;
  final STColorIr? divider;
  final STColorIr? textSecondary;
  final STColorIr? error;
  final STColorIr? success;
  final STColorIr? warning;
  final STColorIr? info;
  final Map<String, STColorIr> extra;
  final Set<String> fields;

  const STColorsIr({
    required this.primary,
    required this.surface,
    required this.background,
    required this.text,
    this.secondary,
    this.border,
    this.divider,
    this.textSecondary,
    this.error,
    this.success,
    this.warning,
    this.info,
    this.extra = const {},
    this.fields = const {},
  });
}

class STRadiusIr {
  final double? xs;
  final double? sm;
  final double? md;
  final double? lg;
  final double? xl;

  const STRadiusIr({this.xs, this.sm, this.md, this.lg, this.xl});

  bool get isSet =>
      xs != null || sm != null || md != null || lg != null || xl != null;
}

class STTypographyIr {
  final String? fontFamily;
  final STTextTokenIr? label;
  final STTextTokenIr? sublabel;
  final STTextTokenIr? description;

  const STTypographyIr({
    this.fontFamily,
    this.label,
    this.sublabel,
    this.description,
  });
}

class STComponentsIr {
  final Map<String, STComponentIr> slots;
  final Map<String, STComponentIr> extra;

  const STComponentsIr({this.slots = const {}, this.extra = const {}});

  bool get isSet => slots.isNotEmpty || extra.isNotEmpty;
}

class STExtraIr {
  final String name;
  final STIrKind kind;
  final STComponentIr style;
  final STTextTokenIr? text;

  const STExtraIr({
    required this.name,
    required this.kind,
    this.style = const STComponentIr(),
    this.text,
  });
}

/// Parsed JSON design. No Flutter types — safe for `dart run`.
class STDesignIr {
  final String variableName;
  final String extensionName;
  final String? partOf;
  final STColorsIr colors;
  final STRadiusIr? radius;
  final STTypographyIr? typography;
  final STComponentsIr? components;
  final List<STExtraIr> extras;

  const STDesignIr({
    required this.variableName,
    required this.extensionName,
    required this.colors,
    this.partOf,
    this.radius,
    this.typography,
    this.components,
    this.extras = const [],
  });
}
