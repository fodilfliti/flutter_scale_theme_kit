import 'st_ir.dart';

const Set<String> stDartReserved = {
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'Function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'when',
  'while',
  'with',
  'yield',
};

/// Getters / methods already on [STResolved] — generated extras must not collide.
const Set<String> stResolvedMemberNames = {
  'primary',
  'secondary',
  'surface',
  'background',
  'border',
  'divider',
  'text',
  'textSecondary',
  'error',
  'success',
  'warning',
  'info',
  'radius',
  'shadow',
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
  'dividerStyle',
  'datePicker',
  'timePicker',
  'label',
  'sublabel',
  'description',
  'color',
  'container',
  'extraButton',
  'extraCard',
  'extraContainer',
  'extraText',
};

/// Lower-camel identifier from a token name (`product-card` → `productCard`).
String stDartIdentifier(String name) {
  final parts = name.split(RegExp(r'[^A-Za-z0-9]+'));
  final buf = StringBuffer();
  for (final part in parts) {
    if (part.isEmpty) continue;
    if (buf.isEmpty) {
      buf.write(part[0].toLowerCase());
      if (part.length > 1) buf.write(part.substring(1));
    } else {
      buf.write(part[0].toUpperCase());
      if (part.length > 1) buf.write(part.substring(1));
    }
  }
  var id = buf.toString();
  if (id.isEmpty) id = 'token';
  if (RegExp(r'^[0-9]').hasMatch(id)) id = 'n$id';
  if (stDartReserved.contains(id)) id = '${id}_';
  return id;
}

String stPascal(String identifier) {
  if (identifier.isEmpty) return identifier;
  return identifier[0].toUpperCase() + identifier.substring(1);
}

/// Getter name for an extra: `ghost` + button → `ghostButton`.
String stExtraGetterName(String name, STIrKind kind) {
  var id = stDartIdentifier(name);
  final lower = id.toLowerCase();
  switch (kind) {
    case STIrKind.button:
      if (!lower.endsWith('button')) id = '${id}Button';
    case STIrKind.card:
      if (!lower.endsWith('card')) id = '${id}Card';
    case STIrKind.container:
      if (!lower.endsWith('container')) id = '${id}Container';
    case STIrKind.text:
      break;
  }
  if (stDartReserved.contains(id) || stResolvedMemberNames.contains(id)) {
    id = '${id}Extra';
  }
  if (stDartReserved.contains(id)) id = '${id}_';
  return id;
}

/// Extra color getter: `brand` → `brand`. Collision with `text` → `textColor`.
String stColorGetterName(String name) {
  var id = stDartIdentifier(name);
  if (stDartReserved.contains(id) || stResolvedMemberNames.contains(id)) {
    id = '${id}Color';
  }
  if (stDartReserved.contains(id) || stResolvedMemberNames.contains(id)) {
    id = '${id}Extra';
  }
  return id;
}

/// `appST` → `STAppExtras`.
String stDefaultExtensionName(String variableName) {
  var id = stDartIdentifier(variableName);
  if (id.length > 2 && id.toLowerCase().endsWith('st')) {
    id = id.substring(0, id.length - 2);
  }
  if (id.isEmpty) id = 'app';
  return 'ST${stPascal(id)}Extras';
}
