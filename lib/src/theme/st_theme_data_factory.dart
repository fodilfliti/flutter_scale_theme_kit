import 'package:flutter/material.dart';

import '../color/st_color.dart';
import '../tokens/st_colors.dart';
import '../tokens/st_component.dart';
import '../tokens/st_extra.dart';
import '../tokens/st_radius.dart';
import '../tokens/st_shadows.dart';
import '../tokens/st_typography.dart';
import 'st_color_scheme.dart';
import 'st_theme_extension.dart';

/// Maps tokens to [ThemeData] for one [Brightness].
class STThemeDataFactory {
  STThemeDataFactory._();

  static const _buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );

  static ThemeData create({
    required STColors colors,
    required STRadius radius,
    required STShadows shadows,
    required STTypography typography,
    required STComponents components,
    required Brightness brightness,
    List<STExtra> extras = const [],
  }) {
    final scheme = stColorScheme(colors, brightness);
    final ext = extensionFor(
      colors: colors,
      radius: radius,
      shadows: shadows,
      typography: typography,
      components: components,
      extras: extras,
      brightness: brightness,
    );

    final family = typography.fontFamily;
    STResolvedComponent c(String name) => ext.comp(name);

    final card = c('card');
    final elevated = c('elevatedButton');
    final filled = c('filledButton');
    final outlined = c('outlinedButton');
    final textBtn = c('textButton');
    final iconBtn = c('iconButton');
    final fab = c('fab');
    final input = c('input');
    final appBar = c('appBar');
    final navBar = c('navBar');
    final rail = c('navigationRail');
    final drawer = c('drawer');
    final bottomAppBar = c('bottomAppBar');
    final tabBar = c('tabBar');
    final dialog = c('dialog');
    final sheet = c('bottomSheet');
    final snack = c('snackBar');
    final chip = c('chip');
    final listTile = c('listTile');
    final expansion = c('expansionTile');
    final tooltip = c('tooltip');
    final progress = c('progress');
    final popup = c('popupMenu');
    final badge = c('badge');
    final divider = c('divider');
    final slider = c('slider');
    final segmented = c('segmentedButton');
    final search = c('searchBar');
    final dropdown = c('dropdownMenu');
    final datePicker = c('datePicker');
    final timePicker = c('timePicker');
    final toggle = c('switchControl');
    final checkbox = c('checkbox');
    final radio = c('radio');

    final materialTypography = Typography.material2021();
    final baseText =
        brightness == Brightness.dark
            ? materialTypography.white
            : materialTypography.black;
    final textTheme = _coloredTextTheme(
      baseText,
      ext.text,
      ext.textSecondary,
      family,
    );

    WidgetStateProperty<T> selected<T>(T on, T off) {
      return WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? on : off;
      });
    }

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: ext.background,
      canvasColor: ext.surface,
      cardColor: card.fill,
      dividerColor: divider.fill ?? ext.divider,
      hintColor: ext.textSecondary,
      disabledColor: ext.textSecondary.withValues(alpha: 0.38),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: IconThemeData(color: ext.text),
      primaryIconTheme: IconThemeData(color: appBar.foreground),
      extensions: <ThemeExtension<dynamic>>[ext],
      cardTheme: CardThemeData(
        color: card.fill,
        elevation: card.elevation,
        shape: card.shape,
        margin: const EdgeInsets.all(4),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: elevated.toButtonStyle(padding: _buttonPadding),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: filled.toButtonStyle(padding: _buttonPadding),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlined.toButtonStyle(
          padding: _buttonPadding,
          includeBackground: outlined.filled == true,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: textBtn.toButtonStyle(
          padding: _buttonPadding,
          includeBackground: false,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: iconBtn.foreground),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: fab.fill,
        foregroundColor: fab.foreground,
        elevation: fab.elevation,
        shape: fab.shape,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: input.filled ?? true,
        fillColor: input.fill,
        hintStyle: TextStyle(color: ext.textSecondary),
        labelStyle: TextStyle(color: ext.textSecondary),
        border: OutlineInputBorder(
          borderRadius: input.borderRadius,
          borderSide: BorderSide(color: input.border ?? ext.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: input.borderRadius,
          borderSide: BorderSide(color: input.border ?? ext.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: input.borderRadius,
          borderSide: BorderSide(
            color: input.focused?.border ?? ext.primary,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: input.borderRadius,
          borderSide: BorderSide(
            color:
                input.disabled?.border ??
                (input.border ?? ext.border).withValues(alpha: 0.38),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: input.borderRadius,
          borderSide: BorderSide(color: ext.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ext.primary,
        selectionColor: ext.primary.withValues(alpha: 0.32),
        selectionHandleColor: ext.primary,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: listTile.foreground ?? ext.text,
        textColor: listTile.foreground ?? ext.text,
        tileColor: listTile.fill,
        subtitleTextStyle: TextStyle(color: ext.textSecondary),
        shape: listTile.shape,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: expansion.fill,
        iconColor: expansion.foreground,
        textColor: expansion.foreground,
        collapsedIconColor: ext.textSecondary,
        collapsedTextColor: ext.text,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appBar.fill,
        foregroundColor: appBar.foreground,
        elevation: appBar.elevation,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: appBar.foreground),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: appBar.foreground,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: navBar.fill,
        indicatorColor: ext.primary.withValues(alpha: 0.24),
        elevation: navBar.elevation,
        iconTheme: selected(
          IconThemeData(color: ext.primary),
          IconThemeData(color: ext.textSecondary),
        ),
        labelTextStyle: selected(
          TextStyle(color: ext.primary),
          TextStyle(color: ext.textSecondary),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: rail.fill,
        indicatorColor: ext.primary.withValues(alpha: 0.24),
        selectedIconTheme: IconThemeData(color: ext.primary),
        unselectedIconTheme: IconThemeData(color: ext.textSecondary),
        selectedLabelTextStyle: TextStyle(color: ext.primary),
        unselectedLabelTextStyle: TextStyle(color: ext.textSecondary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: navBar.fill,
        selectedItemColor: ext.primary,
        unselectedItemColor: ext.textSecondary,
        elevation: navBar.elevation,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: drawer.fill,
        elevation: drawer.elevation,
        shape: drawer.shape,
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: drawer.fill,
        indicatorColor: ext.primary.withValues(alpha: 0.24),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: bottomAppBar.fill,
        elevation: bottomAppBar.elevation,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: tabBar.foreground ?? ext.primary,
        unselectedLabelColor: ext.textSecondary,
        indicatorColor: ext.primary,
        dividerColor: ext.divider,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: snack.fill,
        contentTextStyle: TextStyle(color: snack.foreground),
        behavior: SnackBarBehavior.floating,
        elevation: snack.elevation,
        shape: snack.shape,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: dialog.fill,
        elevation: dialog.elevation,
        shape: dialog.shape,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: sheet.fill,
        elevation: sheet.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(sheet.radius ?? radius.lgValue),
          ),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: tooltip.fill,
          borderRadius: tooltip.borderRadius,
        ),
        textStyle: TextStyle(color: tooltip.foreground),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: progress.fill ?? ext.primary,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: popup.fill,
        elevation: popup.elevation,
        shape: popup.shape,
        textStyle: TextStyle(color: popup.foreground),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: badge.fill,
        textColor: badge.foreground,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: selected(
          toggle.foreground ?? stInkForFill(toggle.fill ?? ext.primary),
          ext.surface,
        ),
        trackColor: selected(toggle.fill ?? ext.primary, ext.border),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: selected(checkbox.fill ?? ext.primary, Colors.transparent),
        checkColor: WidgetStateProperty.all(
          checkbox.foreground ?? stInkForFill(checkbox.fill ?? ext.primary),
        ),
        side: BorderSide(color: checkbox.border ?? ext.border, width: 2),
      ),
      radioTheme: RadioThemeData(
        fillColor: selected(
          radio.fill ?? ext.primary,
          radio.border ?? ext.border,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: chip.fill,
        selectedColor: ext.primary.withValues(alpha: 0.24),
        disabledColor: ext.textSecondary.withValues(alpha: 0.12),
        labelStyle: TextStyle(color: chip.foreground ?? ext.text),
        secondaryLabelStyle: TextStyle(color: chip.foreground ?? ext.text),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        elevation: chip.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: chip.borderRadius,
          side: BorderSide(color: chip.border ?? ext.border),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: divider.fill ?? ext.divider,
        thickness: 1,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: slider.fill ?? ext.primary,
        thumbColor: slider.fill ?? ext.primary,
        inactiveTrackColor: slider.border ?? ext.border,
        overlayColor: (slider.fill ?? ext.primary).withValues(alpha: 0.12),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: selected(
            segmented.fill ?? ext.primary.withValues(alpha: 0.24),
            ext.surface,
          ),
          foregroundColor: selected(
            segmented.foreground ?? ext.primary,
            ext.text,
          ),
          side: WidgetStateProperty.all(
            BorderSide(color: segmented.border ?? ext.border),
          ),
          shape: WidgetStateProperty.all(segmented.shape),
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(search.fill),
        elevation: WidgetStateProperty.all(search.elevation ?? 0),
        shape: WidgetStateProperty.all(search.shape),
        hintStyle: WidgetStateProperty.all(TextStyle(color: ext.textSecondary)),
        textStyle: WidgetStateProperty.all(TextStyle(color: search.foreground)),
      ),
      searchViewTheme: SearchViewThemeData(
        backgroundColor: search.fill,
        elevation: search.elevation,
        shape: search.shape,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: dropdown.fill,
          border: OutlineInputBorder(
            borderRadius: dropdown.borderRadius,
            borderSide: BorderSide(color: dropdown.border ?? ext.border),
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(dropdown.fill),
          elevation: WidgetStateProperty.all(dropdown.elevation ?? 4),
          shape: WidgetStateProperty.all(dropdown.shape),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: datePicker.fill,
        headerBackgroundColor: ext.primary,
        headerForegroundColor: stInkForFill(ext.primary),
        shape: datePicker.shape,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: timePicker.fill,
        hourMinuteColor: ext.surface,
        dialHandColor: ext.primary,
        shape: timePicker.shape,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
          ext.textSecondary.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  static STThemeExtension extensionFor({
    required STColors colors,
    required STRadius radius,
    required STShadows shadows,
    required STTypography typography,
    required STComponents components,
    required Brightness brightness,
    List<STExtra> extras = const [],
  }) {
    Color resolve(STColor token) => token.resolve(brightness);
    final primary = resolve(colors.primary);
    final surface = resolve(colors.surface);
    final background = resolve(colors.background);
    final border = resolve(colors.border);
    final text = resolve(colors.text);
    final inkPrimary = stInkForFill(primary);
    final inverse = text;
    final onInverse = surface;

    STResolvedComponent slot(
      STComponent? specific, {
      STComponent? fallback,
      required Color fill,
      required Color fg,
      Color? borderColor,
      required double radiusValue,
      double elevation = 0,
      bool filled = false,
    }) {
      return _resolveComponent(
        STComponent.merge(specific, fallback),
        brightness,
        defaultFill: fill,
        defaultFg: fg,
        defaultBorder: borderColor ?? border,
        defaultRadius: radiusValue,
        defaultElevation: elevation,
        defaultFilled: filled,
      );
    }

    final button = slot(
      components.button,
      fill: primary,
      fg: inkPrimary,
      radiusValue: radius.mdValue,
    );

    final named = <String, STResolvedComponent>{
      'card': slot(
        components.card,
        fill: surface,
        fg: text,
        radiusValue: radius.mdValue,
      ),
      'panel': slot(
        components.panel,
        fallback: components.card,
        fill: surface,
        fg: text,
        radiusValue: radius.mdValue,
      ),
      'section': slot(
        components.section,
        fallback: components.card,
        fill: surface,
        fg: text,
        radiusValue: radius.mdValue,
      ),
      'dialog': slot(
        components.dialog,
        fill: surface,
        fg: text,
        radiusValue: radius.lgValue,
        elevation: 6,
      ),
      'bottomSheet': slot(
        components.bottomSheet,
        fill: surface,
        fg: text,
        radiusValue: radius.lgValue,
      ),
      'snackBar': slot(
        components.snackBar,
        fill: inverse,
        fg: onInverse,
        radiusValue: radius.mdValue,
      ),
      'appBar': slot(
        components.appBar,
        fill: surface,
        fg: text,
        radiusValue: 0,
      ),
      'navBar': slot(
        components.navBar,
        fill: surface,
        fg: text,
        radiusValue: 0,
      ),
      'navigationRail': slot(
        components.navigationRail,
        fallback: components.navBar,
        fill: surface,
        fg: text,
        radiusValue: 0,
      ),
      'drawer': slot(
        components.drawer,
        fill: surface,
        fg: text,
        radiusValue: radius.lgValue,
      ),
      'bottomAppBar': slot(
        components.bottomAppBar,
        fallback: components.navBar,
        fill: surface,
        fg: text,
        radiusValue: 0,
      ),
      'tabBar': slot(
        components.tabBar,
        fill: surface,
        fg: primary,
        radiusValue: 0,
      ),
      'button': button,
      'elevatedButton': slot(
        components.elevatedButton,
        fallback: components.button,
        fill: primary,
        fg: inkPrimary,
        radiusValue: radius.mdValue,
      ),
      'filledButton': slot(
        components.filledButton,
        fallback: components.button,
        fill: primary,
        fg: inkPrimary,
        radiusValue: radius.mdValue,
      ),
      'outlinedButton': slot(
        components.outlinedButton,
        fallback: components.button,
        fill: surface,
        fg: primary,
        radiusValue: radius.mdValue,
      ),
      'textButton': slot(
        components.textButton,
        fallback: components.button,
        fill: surface,
        fg: primary,
        radiusValue: radius.mdValue,
      ),
      'iconButton': slot(
        components.iconButton,
        fallback: components.button,
        fill: surface,
        fg: text,
        radiusValue: radius.mdValue,
      ),
      'fab': slot(
        components.fab,
        fallback: components.button,
        fill: primary,
        fg: inkPrimary,
        radiusValue: radius.mdValue,
      ),
      'input': slot(
        components.input,
        fill: surface,
        fg: text,
        radiusValue: radius.smValue,
        filled: true,
      ),
      'searchBar': slot(
        components.searchBar,
        fallback: components.input,
        fill: surface,
        fg: text,
        radiusValue: radius.mdValue,
      ),
      'dropdownMenu': slot(
        components.dropdownMenu,
        fallback: components.input,
        fill: surface,
        fg: text,
        radiusValue: radius.smValue,
      ),
      'chip': slot(
        components.chip,
        fill: surface,
        fg: text,
        radiusValue: radius.smValue,
      ),
      'switchControl': slot(
        components.switchControl,
        fill: primary,
        fg: inkPrimary,
        radiusValue: radius.xlValue,
      ),
      'checkbox': slot(
        components.checkbox,
        fill: primary,
        fg: inkPrimary,
        radiusValue: radius.xsValue,
      ),
      'radio': slot(
        components.radio,
        fill: primary,
        fg: inkPrimary,
        radiusValue: radius.xlValue,
      ),
      'slider': slot(
        components.slider,
        fill: primary,
        fg: inkPrimary,
        radiusValue: radius.xlValue,
      ),
      'segmentedButton': slot(
        components.segmentedButton,
        fallback: components.button,
        fill: surface,
        fg: text,
        radiusValue: radius.mdValue,
      ),
      'listTile': slot(
        components.listTile,
        fill: surface,
        fg: text,
        radiusValue: radius.smValue,
      ),
      'expansionTile': slot(
        components.expansionTile,
        fallback: components.listTile,
        fill: surface,
        fg: text,
        radiusValue: radius.smValue,
      ),
      'tooltip': slot(
        components.tooltip,
        fill: inverse,
        fg: onInverse,
        radiusValue: radius.smValue,
      ),
      'progress': slot(
        components.progress,
        fill: primary,
        fg: inkPrimary,
        radiusValue: 0,
      ),
      'popupMenu': slot(
        components.popupMenu,
        fill: surface,
        fg: text,
        radiusValue: radius.mdValue,
        elevation: 4,
      ),
      'badge': slot(
        components.badge,
        fill: resolve(colors.error),
        fg: stInkForFill(resolve(colors.error)),
        radiusValue: radius.xlValue,
      ),
      'divider': slot(
        components.divider,
        fill: resolve(colors.divider),
        fg: text,
        radiusValue: 0,
      ),
      'datePicker': slot(
        components.datePicker,
        fallback: components.dialog,
        fill: surface,
        fg: text,
        radiusValue: radius.lgValue,
      ),
      'timePicker': slot(
        components.timePicker,
        fallback: components.dialog,
        fill: surface,
        fg: text,
        radiusValue: radius.lgValue,
      ),
    };

    for (final e in components.extra.entries) {
      named[e.key] = slot(
        e.value,
        fill: surface,
        fg: text,
        radiusValue: radius.mdValue,
      );
    }

    final resolvedExtras = <String, STResolvedExtra>{};
    var labelStyle = _textRole(
      typography.label,
      fontFamily: typography.fontFamily,
      color: _tokenColor(typography.label, brightness, colors, text),
      defaultSize: 14,
      defaultWeight: FontWeight.w600,
    );
    var sublabelStyle = _textRole(
      typography.sublabel,
      fontFamily: typography.fontFamily,
      color: _tokenColor(
        typography.sublabel,
        brightness,
        colors,
        resolve(colors.textSecondary),
      ),
      defaultSize: 12,
    );
    var descriptionStyle = _textRole(
      typography.description,
      fontFamily: typography.fontFamily,
      color: _tokenColor(
        typography.description,
        brightness,
        colors,
        resolve(colors.textSecondary),
      ),
      defaultSize: 14,
      defaultHeight: 1.4,
    );

    const transparent = Color(0x00000000);
    for (final extra in extras) {
      switch (extra.kind) {
        case STKind.text:
          final token = extra.text ?? const STTextToken();
          final style = _textRole(
            token,
            fontFamily: typography.fontFamily,
            color: _tokenColor(token, brightness, colors, text),
          );
          resolvedExtras[extra.name] = STResolvedExtra(
            kind: STKind.text,
            textStyle: style,
          );
          switch (extra.name) {
            case 'label':
              labelStyle = style;
            case 'sublabel':
              sublabelStyle = style;
            case 'description':
              descriptionStyle = style;
          }
        case STKind.button:
        case STKind.card:
        case STKind.container:
          var resolved =
              extra.kind == STKind.button
                  ? slot(
                    extra.style,
                    fill: transparent,
                    fg: primary,
                    borderColor: transparent,
                    radiusValue: radius.mdValue,
                    filled: extra.style.filled ?? false,
                  )
                  : slot(
                    extra.style,
                    fill: surface,
                    fg: text,
                    radiusValue: radius.mdValue,
                  );
          final fill = resolved.fill;
          if (extra.kind == STKind.button &&
              extra.style.foreground == null &&
              fill != null &&
              fill.a > 0.01) {
            resolved = resolved.copyWith(foreground: stInkForFill(fill));
          }
          resolvedExtras[extra.name] = STResolvedExtra(
            kind: extra.kind,
            component: resolved,
          );
          named[extra.name] = resolved;
      }
    }

    return STThemeExtension(
      primary: primary,
      secondary: resolve(colors.secondary),
      surface: surface,
      background: background,
      border: border,
      divider: resolve(colors.divider),
      text: text,
      textSecondary: resolve(colors.textSecondary),
      error: resolve(colors.error),
      success: resolve(colors.success),
      warning: resolve(colors.warning),
      info: resolve(colors.info),
      radius: radius,
      shadows: shadows,
      components: named,
      extraColors: {
        for (final e in colors.extra.entries)
          e.key: e.value.resolve(brightness),
      },
      extras: resolvedExtras,
      label: labelStyle,
      sublabel: sublabelStyle,
      description: descriptionStyle,
    );
  }

  static Color _tokenColor(
    STTextToken? token,
    Brightness brightness,
    STColors colors,
    Color fallback,
  ) {
    if (token?.color != null) {
      return token!.color!.resolve(brightness);
    }
    if (token?.colorName != null) {
      return colors.resolveNamed(token!.colorName!, brightness);
    }
    return fallback;
  }

  static TextStyle _textRole(
    STTextToken? token, {
    required String? fontFamily,
    required Color color,
    double defaultSize = 14,
    FontWeight defaultWeight = FontWeight.w400,
    double? defaultHeight,
  }) {
    return stResolveTextStyle(
      token: token,
      fontFamily: fontFamily,
      color: color,
      defaultSize: defaultSize,
      defaultWeight: defaultWeight,
      defaultHeight: defaultHeight,
    );
  }

  static STResolvedComponent _resolveComponent(
    STComponent? component,
    Brightness brightness, {
    required Color defaultFill,
    required Color defaultFg,
    required Color defaultBorder,
    required double defaultRadius,
    required double defaultElevation,
    bool defaultFilled = false,
  }) {
    final base = STResolvedComponent(
      fill: component?.fill?.resolve(brightness) ?? defaultFill,
      foreground: component?.foreground?.resolve(brightness) ?? defaultFg,
      border: component?.border?.resolve(brightness) ?? defaultBorder,
      elevation: component?.elevation ?? defaultElevation,
      radius: component?.radius ?? defaultRadius,
      filled: component?.filled ?? defaultFilled,
    );
    final states = component?.states;
    if (states == null) return base;

    STResolvedComponent? overlay(STComponent? token) {
      if (token == null) return null;
      return STResolvedComponent(
        fill: token.fill?.resolve(brightness) ?? base.fill,
        foreground: token.foreground?.resolve(brightness) ?? base.foreground,
        border: token.border?.resolve(brightness) ?? base.border,
        elevation: token.elevation ?? base.elevation,
        radius: token.radius ?? base.radius,
        filled: token.filled ?? base.filled,
      );
    }

    return base.copyWith(
      hovered: overlay(states.hovered),
      pressed: overlay(states.pressed),
      focused: overlay(states.focused),
      disabled: overlay(states.disabled),
      selected: overlay(states.selected),
    );
  }

  static TextTheme _coloredTextTheme(
    TextTheme base,
    Color text,
    Color secondary,
    String? fontFamily,
  ) {
    TextStyle? apply(TextStyle? style, Color color) {
      if (style == null) return null;
      return style.copyWith(color: color, fontFamily: fontFamily);
    }

    return base.copyWith(
      displayLarge: apply(base.displayLarge, text),
      displayMedium: apply(base.displayMedium, text),
      displaySmall: apply(base.displaySmall, text),
      headlineLarge: apply(base.headlineLarge, text),
      headlineMedium: apply(base.headlineMedium, text),
      headlineSmall: apply(base.headlineSmall, text),
      titleLarge: apply(base.titleLarge, text),
      titleMedium: apply(base.titleMedium, text),
      titleSmall: apply(base.titleSmall, text),
      bodyLarge: apply(base.bodyLarge, text),
      bodyMedium: apply(base.bodyMedium, text),
      bodySmall: apply(base.bodySmall, secondary),
      labelLarge: apply(base.labelLarge, text),
      labelMedium: apply(base.labelMedium, secondary),
      labelSmall: apply(base.labelSmall, secondary),
    );
  }
}
