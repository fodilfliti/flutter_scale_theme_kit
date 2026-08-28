import 'package:flutter/material.dart';

import 'st_resolved.dart';
import 'st_theme.dart';

/// Optional override of [STResolved] for a subtree (tests, local look).
class STScope extends InheritedWidget {
  final STTheme theme;
  final Brightness brightness;

  const STScope({
    super.key,
    required this.theme,
    required this.brightness,
    required super.child,
  });

  STResolved get resolved {
    return theme.resolve(brightness);
  }

  static STScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<STScope>();
  }

  @override
  bool updateShouldNotify(STScope oldWidget) {
    return theme != oldWidget.theme || brightness != oldWidget.brightness;
  }
}
