import 'package:flutter/material.dart';

import '../color/st_color.dart';
import '../theme/st_theme.dart';
import '../tokens/st_colors.dart';
import '../tokens/st_component.dart';
import '../tokens/st_extra.dart';
import '../tokens/st_radius.dart';
import '../tokens/st_typography.dart';
import 'st_ir.dart';
import 'st_json.dart';

/// Parsed design plus a runtime [STTheme]. Flutter-only (not used by the CLI).
class STParsedTheme {
  final STTheme theme;
  final STDesignIr ir;

  const STParsedTheme({required this.theme, required this.ir});

  String get variableName => ir.variableName;
  String get extensionName => ir.extensionName;
  String? get partOf => ir.partOf;
}

STParsedTheme parseStThemeJson(Map<String, dynamic> json) {
  final ir = parseStDesignJson(json);
  return STParsedTheme(theme: stThemeFromIr(ir), ir: ir);
}

STTheme stThemeFromIr(STDesignIr ir) {
  final r = ir.radius;
  return STTheme(
    colors: STColors(
      primary: _color(ir.colors.primary),
      surface: _color(ir.colors.surface),
      background: _color(ir.colors.background),
      text: _color(ir.colors.text),
      secondary:
          ir.colors.secondary == null ? null : _color(ir.colors.secondary!),
      border: ir.colors.border == null ? null : _color(ir.colors.border!),
      divider: ir.colors.divider == null ? null : _color(ir.colors.divider!),
      textSecondary:
          ir.colors.textSecondary == null
              ? null
              : _color(ir.colors.textSecondary!),
      error: ir.colors.error == null ? null : _color(ir.colors.error!),
      success: ir.colors.success == null ? null : _color(ir.colors.success!),
      warning: ir.colors.warning == null ? null : _color(ir.colors.warning!),
      info: ir.colors.info == null ? null : _color(ir.colors.info!),
      extra: {for (final e in ir.colors.extra.entries) e.key: _color(e.value)},
    ),
    radius: STRadius(
      xs: r?.xs ?? 4,
      sm: r?.sm ?? 8,
      md: r?.md ?? 12,
      lg: r?.lg ?? 16,
      xl: r?.xl ?? 24,
    ),
    typography:
        ir.typography == null
            ? const STTypography()
            : STTypography(
              fontFamily: ir.typography!.fontFamily,
              label: _text(ir.typography!.label),
              sublabel: _text(ir.typography!.sublabel),
              description: _text(ir.typography!.description),
            ),
    components: _components(ir.components),
    extras: [for (final extra in ir.extras) _extra(extra)],
  );
}

STComponents _components(STComponentsIr? ir) {
  if (ir == null) return const STComponents();
  STComponent? slot(String name) {
    final c = ir.slots[name];
    return c == null ? null : _component(c);
  }

  return STComponents(
    card: slot('card'),
    panel: slot('panel'),
    section: slot('section'),
    dialog: slot('dialog'),
    bottomSheet: slot('bottomSheet'),
    snackBar: slot('snackBar'),
    appBar: slot('appBar'),
    navBar: slot('navBar'),
    navigationRail: slot('navigationRail'),
    drawer: slot('drawer'),
    bottomAppBar: slot('bottomAppBar'),
    tabBar: slot('tabBar'),
    button: slot('button'),
    elevatedButton: slot('elevatedButton'),
    filledButton: slot('filledButton'),
    outlinedButton: slot('outlinedButton'),
    textButton: slot('textButton'),
    iconButton: slot('iconButton'),
    fab: slot('fab'),
    input: slot('input'),
    searchBar: slot('searchBar'),
    dropdownMenu: slot('dropdownMenu'),
    chip: slot('chip'),
    switchControl: slot('switchControl'),
    checkbox: slot('checkbox'),
    radio: slot('radio'),
    slider: slot('slider'),
    segmentedButton: slot('segmentedButton'),
    listTile: slot('listTile'),
    expansionTile: slot('expansionTile'),
    tooltip: slot('tooltip'),
    progress: slot('progress'),
    popupMenu: slot('popupMenu'),
    badge: slot('badge'),
    divider: slot('divider'),
    datePicker: slot('datePicker'),
    timePicker: slot('timePicker'),
    extra: {for (final e in ir.extra.entries) e.key: _component(e.value)},
  );
}

STExtra _extra(STExtraIr ir) {
  switch (ir.kind) {
    case STIrKind.button:
      return STExtra.button(ir.name, style: _component(ir.style));
    case STIrKind.card:
      return STExtra.card(ir.name, style: _component(ir.style));
    case STIrKind.container:
      return STExtra.container(ir.name, style: _component(ir.style));
    case STIrKind.text:
      return STExtra.text(
        ir.name,
        token: _text(ir.text) ?? const STTextToken(),
      );
  }
}

STComponent _component(STComponentIr ir) {
  return STComponent(
    fill: ir.fill == null ? null : _color(ir.fill!),
    foreground: ir.foreground == null ? null : _color(ir.foreground!),
    border: ir.border == null ? null : _color(ir.border!),
    elevation: ir.elevation,
    radius: ir.radius,
    filled: ir.filled,
  );
}

STTextToken? _text(STTextTokenIr? ir) {
  if (ir == null) return null;
  return STTextToken(
    fontSize: ir.fontSize,
    fontWeight: _weight(ir.fontWeight),
    fontStyle:
        ir.fontStyle == 'italic'
            ? FontStyle.italic
            : ir.fontStyle == 'normal'
            ? FontStyle.normal
            : null,
    height: ir.height,
    letterSpacing: ir.letterSpacing,
    color: ir.color == null ? null : _color(ir.color!),
    colorName: ir.colorName,
  );
}

FontWeight? _weight(int? value) {
  if (value == null) return null;
  for (final weight in FontWeight.values) {
    if (weight.value == value) return weight;
  }
  return FontWeight.w400;
}

STColor _color(STColorIr ir) {
  return STColor(
    light: Color(ir.light),
    dark: ir.dark == null ? null : Color(ir.dark!),
  );
}
