import 'package:flutter/material.dart';

import '../color/st_color.dart';

/// Optional look for Flutter [WidgetState]s (hover, press, focus, disabled, selected).
///
/// Null fields mean “use the component’s rest style”. Do not invent new hues;
/// omit a state to keep rest colors (disabled then uses 38% alpha on the
/// already-resolved rest color).
class STComponentStates {
  final STComponent? hovered;
  final STComponent? pressed;
  final STComponent? focused;
  final STComponent? disabled;
  final STComponent? selected;

  const STComponentStates({
    this.hovered,
    this.pressed,
    this.focused,
    this.disabled,
    this.selected,
  });

  static STComponentStates? merge(
    STComponentStates? override,
    STComponentStates? base,
  ) {
    if (override == null) return base;
    if (base == null) return override;
    return STComponentStates(
      hovered: STComponent.merge(override.hovered, base.hovered),
      pressed: STComponent.merge(override.pressed, base.pressed),
      focused: STComponent.merge(override.focused, base.focused),
      disabled: STComponent.merge(override.disabled, base.disabled),
      selected: STComponent.merge(override.selected, base.selected),
    );
  }

  STComponentStates copyWith({
    STComponent? hovered,
    STComponent? pressed,
    STComponent? focused,
    STComponent? disabled,
    STComponent? selected,
  }) {
    return STComponentStates(
      hovered: hovered ?? this.hovered,
      pressed: pressed ?? this.pressed,
      focused: focused ?? this.focused,
      disabled: disabled ?? this.disabled,
      selected: selected ?? this.selected,
    );
  }
}

/// Visual style for one component (fill, ink, outline, elevation, radius).
class STComponent {
  final STColor? fill;
  final STColor? foreground;
  final STColor? border;
  final double? elevation;
  final double? radius;
  final bool? filled;

  /// Optional per-[WidgetState] overlays. Null = rest style only.
  final STComponentStates? states;

  const STComponent({
    this.fill,
    this.foreground,
    this.border,
    this.elevation,
    this.radius,
    this.filled,
    this.states,
  });

  /// [override] wins per-field over [base].
  static STComponent? merge(STComponent? override, STComponent? base) {
    if (override == null) return base;
    if (base == null) return override;
    return STComponent(
      fill: override.fill ?? base.fill,
      foreground: override.foreground ?? base.foreground,
      border: override.border ?? base.border,
      elevation: override.elevation ?? base.elevation,
      radius: override.radius ?? base.radius,
      filled: override.filled ?? base.filled,
      states: STComponentStates.merge(override.states, base.states),
    );
  }

  STComponent copyWith({
    STColor? fill,
    STColor? foreground,
    STColor? border,
    double? elevation,
    double? radius,
    bool? filled,
    STComponentStates? states,
  }) {
    return STComponent(
      fill: fill ?? this.fill,
      foreground: foreground ?? this.foreground,
      border: border ?? this.border,
      elevation: elevation ?? this.elevation,
      radius: radius ?? this.radius,
      filled: filled ?? this.filled,
      states: states ?? this.states,
    );
  }
}

/// Optional per-widget look. Null fields use [STColors] / [STRadius] defaults.
///
/// Shared [button] applies to every button type unless a specific slot is set
/// (`elevatedButton`, `outlinedButton`, …).
class STComponents {
  final STComponent? card;
  final STComponent? panel;
  final STComponent? section;
  final STComponent? dialog;
  final STComponent? bottomSheet;
  final STComponent? snackBar;

  final STComponent? appBar;
  final STComponent? navBar;
  final STComponent? navigationRail;
  final STComponent? drawer;
  final STComponent? bottomAppBar;
  final STComponent? tabBar;

  final STComponent? button;
  final STComponent? elevatedButton;
  final STComponent? filledButton;
  final STComponent? outlinedButton;
  final STComponent? textButton;
  final STComponent? iconButton;
  final STComponent? fab;

  final STComponent? input;
  final STComponent? searchBar;
  final STComponent? dropdownMenu;

  final STComponent? chip;
  final STComponent? switchControl;
  final STComponent? checkbox;
  final STComponent? radio;
  final STComponent? slider;
  final STComponent? segmentedButton;

  final STComponent? listTile;
  final STComponent? expansionTile;

  final STComponent? tooltip;
  final STComponent? progress;
  final STComponent? popupMenu;
  final STComponent? badge;
  final STComponent? divider;
  final STComponent? datePicker;
  final STComponent? timePicker;

  final Map<String, STComponent> extra;

  const STComponents({
    this.card,
    this.panel,
    this.section,
    this.dialog,
    this.bottomSheet,
    this.snackBar,
    this.appBar,
    this.navBar,
    this.navigationRail,
    this.drawer,
    this.bottomAppBar,
    this.tabBar,
    this.button,
    this.elevatedButton,
    this.filledButton,
    this.outlinedButton,
    this.textButton,
    this.iconButton,
    this.fab,
    this.input,
    this.searchBar,
    this.dropdownMenu,
    this.chip,
    this.switchControl,
    this.checkbox,
    this.radio,
    this.slider,
    this.segmentedButton,
    this.listTile,
    this.expansionTile,
    this.tooltip,
    this.progress,
    this.popupMenu,
    this.badge,
    this.divider,
    this.datePicker,
    this.timePicker,
    this.extra = const {},
  });

  STComponent? lookup(String name) {
    switch (name) {
      case 'card':
        return card;
      case 'panel':
        return panel;
      case 'section':
        return section;
      case 'dialog':
        return dialog;
      case 'bottomSheet':
        return bottomSheet;
      case 'snackBar':
        return snackBar;
      case 'appBar':
        return appBar;
      case 'navBar':
      case 'navigationBar':
        return navBar;
      case 'navigationRail':
        return navigationRail;
      case 'drawer':
        return drawer;
      case 'bottomAppBar':
        return bottomAppBar;
      case 'tabBar':
        return tabBar;
      case 'button':
        return button;
      case 'elevatedButton':
        return elevatedButton;
      case 'filledButton':
        return filledButton;
      case 'outlinedButton':
        return outlinedButton;
      case 'textButton':
        return textButton;
      case 'iconButton':
        return iconButton;
      case 'fab':
      case 'floatingActionButton':
        return fab;
      case 'input':
        return input;
      case 'searchBar':
        return searchBar;
      case 'dropdownMenu':
        return dropdownMenu;
      case 'chip':
        return chip;
      case 'switch':
      case 'switchControl':
        return switchControl;
      case 'checkbox':
        return checkbox;
      case 'radio':
        return radio;
      case 'slider':
        return slider;
      case 'segmentedButton':
        return segmentedButton;
      case 'listTile':
        return listTile;
      case 'expansionTile':
        return expansionTile;
      case 'tooltip':
        return tooltip;
      case 'progress':
        return progress;
      case 'popupMenu':
        return popupMenu;
      case 'badge':
        return badge;
      case 'divider':
        return divider;
      case 'datePicker':
        return datePicker;
      case 'timePicker':
        return timePicker;
      default:
        return extra[name];
    }
  }

  STComponents copyWith({
    STComponent? card,
    STComponent? panel,
    STComponent? section,
    STComponent? dialog,
    STComponent? bottomSheet,
    STComponent? snackBar,
    STComponent? appBar,
    STComponent? navBar,
    STComponent? navigationRail,
    STComponent? drawer,
    STComponent? bottomAppBar,
    STComponent? tabBar,
    STComponent? button,
    STComponent? elevatedButton,
    STComponent? filledButton,
    STComponent? outlinedButton,
    STComponent? textButton,
    STComponent? iconButton,
    STComponent? fab,
    STComponent? input,
    STComponent? searchBar,
    STComponent? dropdownMenu,
    STComponent? chip,
    STComponent? switchControl,
    STComponent? checkbox,
    STComponent? radio,
    STComponent? slider,
    STComponent? segmentedButton,
    STComponent? listTile,
    STComponent? expansionTile,
    STComponent? tooltip,
    STComponent? progress,
    STComponent? popupMenu,
    STComponent? badge,
    STComponent? divider,
    STComponent? datePicker,
    STComponent? timePicker,
    Map<String, STComponent>? extra,
  }) {
    return STComponents(
      card: card ?? this.card,
      panel: panel ?? this.panel,
      section: section ?? this.section,
      dialog: dialog ?? this.dialog,
      bottomSheet: bottomSheet ?? this.bottomSheet,
      snackBar: snackBar ?? this.snackBar,
      appBar: appBar ?? this.appBar,
      navBar: navBar ?? this.navBar,
      navigationRail: navigationRail ?? this.navigationRail,
      drawer: drawer ?? this.drawer,
      bottomAppBar: bottomAppBar ?? this.bottomAppBar,
      tabBar: tabBar ?? this.tabBar,
      button: button ?? this.button,
      elevatedButton: elevatedButton ?? this.elevatedButton,
      filledButton: filledButton ?? this.filledButton,
      outlinedButton: outlinedButton ?? this.outlinedButton,
      textButton: textButton ?? this.textButton,
      iconButton: iconButton ?? this.iconButton,
      fab: fab ?? this.fab,
      input: input ?? this.input,
      searchBar: searchBar ?? this.searchBar,
      dropdownMenu: dropdownMenu ?? this.dropdownMenu,
      chip: chip ?? this.chip,
      switchControl: switchControl ?? this.switchControl,
      checkbox: checkbox ?? this.checkbox,
      radio: radio ?? this.radio,
      slider: slider ?? this.slider,
      segmentedButton: segmentedButton ?? this.segmentedButton,
      listTile: listTile ?? this.listTile,
      expansionTile: expansionTile ?? this.expansionTile,
      tooltip: tooltip ?? this.tooltip,
      progress: progress ?? this.progress,
      popupMenu: popupMenu ?? this.popupMenu,
      badge: badge ?? this.badge,
      divider: divider ?? this.divider,
      datePicker: datePicker ?? this.datePicker,
      timePicker: timePicker ?? this.timePicker,
      extra: extra ?? this.extra,
    );
  }
}

/// Component tokens after brightness resolve.
class STResolvedComponent {
  final Color? fill;
  final Color? foreground;
  final Color? border;
  final double? elevation;
  final double? radius;
  final bool? filled;

  /// Authored overlays. Null means rest style (disabled then fades alpha).
  final STResolvedComponent? hovered;
  final STResolvedComponent? pressed;
  final STResolvedComponent? focused;
  final STResolvedComponent? disabled;
  final STResolvedComponent? selected;

  const STResolvedComponent({
    this.fill,
    this.foreground,
    this.border,
    this.elevation,
    this.radius,
    this.filled,
    this.hovered,
    this.pressed,
    this.focused,
    this.disabled,
    this.selected,
  });

  BorderRadius get borderRadius => BorderRadius.circular(radius ?? 0);

  RoundedRectangleBorder get shape =>
      RoundedRectangleBorder(borderRadius: borderRadius);

  /// Rest or overlay for [states]. Does not apply the unauthored disabled fade.
  STResolvedComponent forWidgetStates(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled) && disabled != null) {
      return disabled!;
    }
    if (states.contains(WidgetState.pressed) && pressed != null) {
      return pressed!;
    }
    if (states.contains(WidgetState.hovered) && hovered != null) {
      return hovered!;
    }
    if (states.contains(WidgetState.focused) && focused != null) {
      return focused!;
    }
    if (states.contains(WidgetState.selected) && selected != null) {
      return selected!;
    }
    return this;
  }

  STResolvedComponent copyWith({
    Color? fill,
    Color? foreground,
    Color? border,
    double? elevation,
    double? radius,
    bool? filled,
    STResolvedComponent? hovered,
    STResolvedComponent? pressed,
    STResolvedComponent? focused,
    STResolvedComponent? disabled,
    STResolvedComponent? selected,
  }) {
    return STResolvedComponent(
      fill: fill ?? this.fill,
      foreground: foreground ?? this.foreground,
      border: border ?? this.border,
      elevation: elevation ?? this.elevation,
      radius: radius ?? this.radius,
      filled: filled ?? this.filled,
      hovered: hovered ?? this.hovered,
      pressed: pressed ?? this.pressed,
      focused: focused ?? this.focused,
      disabled: disabled ?? this.disabled,
      selected: selected ?? this.selected,
    );
  }

  /// For extra button styles (`ElevatedButton(style: …)`).
  ///
  /// [includeBackground] is false for outlined / text / icon themes so they
  /// stay unfilled unless [filled] was set.
  ButtonStyle toButtonStyle({
    EdgeInsetsGeometry? padding,
    bool includeBackground = true,
  }) {
    Color? resolveColor(
      Color? Function(STResolvedComponent c) pick,
      Set<WidgetState> states,
    ) {
      final overlay = forWidgetStates(states);
      final color = pick(overlay);
      if (color == null) return null;
      if (states.contains(WidgetState.disabled) && disabled == null) {
        return color.withValues(alpha: color.a * 0.38);
      }
      return color;
    }

    BorderSide resolveSide(Set<WidgetState> states) {
      final color = resolveColor((c) => c.border, states);
      return BorderSide(
        color: color ?? const Color(0x00000000),
        width: color == null ? 0 : 1,
      );
    }

    return ButtonStyle(
      backgroundColor:
          includeBackground
              ? WidgetStateProperty.resolveWith(
                (states) => resolveColor((c) => c.fill, states),
              )
              : null,
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => resolveColor((c) => c.foreground, states),
      ),
      elevation: WidgetStateProperty.resolveWith((states) {
        return forWidgetStates(states).elevation ?? 0;
      }),
      padding: WidgetStatePropertyAll(
        padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      shape: WidgetStateProperty.resolveWith((states) {
        return forWidgetStates(states).shape;
      }),
      side: WidgetStateProperty.resolveWith(resolveSide),
    );
  }

  /// For extra cards / containers (`BoxDecoration` / `DecoratedBox`).
  BoxDecoration toBoxDecoration({List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: fill,
      borderRadius: borderRadius,
      border: border == null ? null : Border.all(color: border!),
      boxShadow: boxShadow,
    );
  }
}
