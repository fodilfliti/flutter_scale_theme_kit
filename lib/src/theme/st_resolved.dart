import 'package:flutter/material.dart';

import '../tokens/st_component.dart';
import '../tokens/st_extra.dart';
import '../tokens/st_radius.dart';
import '../tokens/st_shadows.dart';
import 'st_theme_extension.dart';

/// Short resolved token view — what [BuildContext.st] returns.
class STResolved {
  final STThemeExtension _ext;

  const STResolved(this._ext);

  Color get primary => _ext.primary;
  Color get secondary => _ext.secondary;
  Color get surface => _ext.surface;
  Color get background => _ext.background;
  Color get border => _ext.border;
  Color get divider => _ext.divider;
  Color get text => _ext.text;
  Color get textSecondary => _ext.textSecondary;
  Color get error => _ext.error;
  Color get success => _ext.success;
  Color get warning => _ext.warning;
  Color get info => _ext.info;

  STRadius get radius => _ext.radius;
  STShadows get shadow => _ext.shadows;

  STResolvedComponent get card => _ext.comp('card');
  STResolvedComponent get panel => _ext.comp('panel');
  STResolvedComponent get section => _ext.comp('section');
  STResolvedComponent get dialog => _ext.comp('dialog');
  STResolvedComponent get bottomSheet => _ext.comp('bottomSheet');
  STResolvedComponent get snackBar => _ext.comp('snackBar');
  STResolvedComponent get appBar => _ext.comp('appBar');
  STResolvedComponent get navBar => _ext.comp('navBar');
  STResolvedComponent get navigationRail => _ext.comp('navigationRail');
  STResolvedComponent get drawer => _ext.comp('drawer');
  STResolvedComponent get bottomAppBar => _ext.comp('bottomAppBar');
  STResolvedComponent get tabBar => _ext.comp('tabBar');
  STResolvedComponent get button => _ext.comp('button');
  STResolvedComponent get elevatedButton => _ext.comp('elevatedButton');
  STResolvedComponent get filledButton => _ext.comp('filledButton');
  STResolvedComponent get outlinedButton => _ext.comp('outlinedButton');
  STResolvedComponent get textButton => _ext.comp('textButton');
  STResolvedComponent get iconButton => _ext.comp('iconButton');
  STResolvedComponent get fab => _ext.comp('fab');
  STResolvedComponent get input => _ext.comp('input');
  STResolvedComponent get searchBar => _ext.comp('searchBar');
  STResolvedComponent get dropdownMenu => _ext.comp('dropdownMenu');
  STResolvedComponent get chip => _ext.comp('chip');
  STResolvedComponent get switchControl => _ext.comp('switchControl');
  STResolvedComponent get checkbox => _ext.comp('checkbox');
  STResolvedComponent get radio => _ext.comp('radio');
  STResolvedComponent get slider => _ext.comp('slider');
  STResolvedComponent get segmentedButton => _ext.comp('segmentedButton');
  STResolvedComponent get listTile => _ext.comp('listTile');
  STResolvedComponent get expansionTile => _ext.comp('expansionTile');
  STResolvedComponent get tooltip => _ext.comp('tooltip');
  STResolvedComponent get progress => _ext.comp('progress');
  STResolvedComponent get popupMenu => _ext.comp('popupMenu');
  STResolvedComponent get badge => _ext.comp('badge');
  STResolvedComponent get dividerStyle => _ext.comp('divider');
  STResolvedComponent get datePicker => _ext.comp('datePicker');
  STResolvedComponent get timePicker => _ext.comp('timePicker');

  TextStyle get label => _ext.label;
  TextStyle get sublabel => _ext.sublabel;
  TextStyle get description => _ext.description;

  /// Semantic or extra color. Unknown: debug assert, [primary] in release.
  Color color(String name) {
    switch (name) {
      case 'primary':
        return primary;
      case 'secondary':
        return secondary;
      case 'surface':
        return surface;
      case 'background':
        return background;
      case 'border':
        return border;
      case 'divider':
        return divider;
      case 'text':
        return text;
      case 'textSecondary':
        return textSecondary;
      case 'error':
        return error;
      case 'success':
        return success;
      case 'warning':
        return warning;
      case 'info':
        return info;
      default:
        final extra = _ext.extraColor(name);
        if (extra == null) {
          assert(false, 'Unknown ST color "$name"');
          return primary;
        }
        return extra;
    }
  }

  /// Named component. Unknown: debug assert, [card].
  STResolvedComponent container(String name) {
    switch (name) {
      case 'switch':
        return switchControl;
      case 'navigationBar':
        return navBar;
      case 'floatingActionButton':
        return fab;
      default:
        break;
    }
    if (_ext.components.containsKey(name)) {
      return _ext.comp(name);
    }
    assert(false, 'Unknown ST component "$name"');
    return card;
  }

  /// Extra of kind [STKind.button]. Unknown: debug assert, [button].
  STResolvedComponent extraButton(String name) {
    return _extraComponent(name, STKind.button, button);
  }

  /// Extra of kind [STKind.card]. Unknown: debug assert, [card].
  STResolvedComponent extraCard(String name) {
    return _extraComponent(name, STKind.card, card);
  }

  /// Extra of kind [STKind.container]. Unknown: debug assert, [card].
  STResolvedComponent extraContainer(String name) {
    return _extraComponent(name, STKind.container, card);
  }

  /// Extra of kind [STKind.text]. Unknown: debug assert, [description].
  TextStyle extraText(String name) {
    final extra = _ext.extras[name];
    if (extra == null || extra.kind != STKind.text || extra.textStyle == null) {
      assert(false, 'Unknown extra text "$name"');
      return description;
    }
    return extra.textStyle!;
  }

  STResolvedComponent _extraComponent(
    String name,
    STKind kind,
    STResolvedComponent fallback,
  ) {
    final extra = _ext.extras[name];
    if (extra == null || extra.kind != kind || extra.component == null) {
      assert(false, 'Unknown extra ${kind.name} "$name"');
      return fallback;
    }
    return extra.component!;
  }
}
