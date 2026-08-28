/// JSON → Dart generator. Not part of the runtime barrel.
///
/// For Flutter tests/apps (includes `STTheme` conversion):
/// ```dart
/// import 'package:flutter_scale_theme_kit/generate.dart';
/// ```
///
/// The CLI uses [generate_core.dart] so `dart run` does not need `dart:ui`.
library;

export 'generate_core.dart';
export 'src/generate/st_ir_theme.dart';
