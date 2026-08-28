import 'package:flutter/material.dart';

import 'st_resolved.dart';
import 'st_scope.dart';
import 'st_theme_extension.dart';
import 'st_theme_mode.dart';

/// Short token access: `context.st.surface`. Theme mode: `context.stMode`.
extension STBuildContext on BuildContext {
  /// Resolved design tokens. Prefers [STScope], then [ThemeData] extension.
  STResolved get st {
    final scoped = STScope.maybeOf(this);
    if (scoped != null) {
      return scoped.resolved;
    }
    final ext = Theme.of(this).extension<STThemeExtension>();
    if (ext != null) {
      return STResolved(ext);
    }
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('No STTheme in context.'),
      ErrorDescription(
        'Wrap the app with MaterialApp(theme: stTheme.light, darkTheme: stTheme.dark) '
        'or an STScope.',
      ),
    ]);
  }

  /// App light/dark/system switcher. Requires [STThemeModeScope] above [MaterialApp].
  STThemeModeController get stMode => STThemeModeScope.of(this);
}
