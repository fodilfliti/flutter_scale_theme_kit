import 'package:flutter/material.dart';

/// Holds [ThemeMode] for [MaterialApp.themeMode]. Optional — look tokens stay
/// on [ThemeExtension]; this is only app light/dark/system switching.
class STThemeModeController extends ChangeNotifier {
  ThemeMode _mode;

  STThemeModeController({ThemeMode mode = ThemeMode.system}) : _mode = mode;

  ThemeMode get mode => _mode;

  void setMode(ThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
  }

  /// Force light or dark (leaves [ThemeMode.system]).
  void setDark(bool dark) {
    setMode(dark ? ThemeMode.dark : ThemeMode.light);
  }

  /// Light ↔ dark. If [mode] is [ThemeMode.system], uses [platformBrightness]
  /// (or light if omitted).
  void toggle({Brightness? platformBrightness}) {
    final currentlyDark = switch (_mode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system => platformBrightness == Brightness.dark,
    };
    setDark(!currentlyDark);
  }

  /// [ThemeMode.system] → light → dark → system.
  void cycle() {
    setMode(switch (_mode) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    });
  }

  /// Effective dark look: forced dark, or system + device dark.
  bool isDark(BuildContext context) {
    return switch (_mode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.dark,
    };
  }
}

/// Places [STThemeModeController] above [MaterialApp] so [themeMode] rebuilds
/// and descendants can call [context.stMode] / [STThemeModeSwitch].
class STThemeModeScope extends StatefulWidget {
  const STThemeModeScope({
    super.key,
    this.initialMode = ThemeMode.system,
    this.controller,
    required this.builder,
  });

  final ThemeMode initialMode;

  /// If null, the scope creates and disposes a controller.
  final STThemeModeController? controller;

  /// Build [MaterialApp] (or equivalent) with [STThemeModeController.mode].
  final Widget Function(BuildContext context, STThemeModeController mode)
  builder;

  static STThemeModeController of(BuildContext context) {
    final found = maybeOf(context);
    if (found == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No STThemeModeScope in context.'),
        ErrorDescription(
          'Wrap MaterialApp with STThemeModeScope(builder: (context, mode) => '
          'MaterialApp(theme: st.light, darkTheme: st.dark, themeMode: mode.mode, …)).',
        ),
      ]);
    }
    return found;
  }

  static STThemeModeController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_STThemeModeInherited>()
        ?.notifier;
  }

  @override
  State<STThemeModeScope> createState() => _STThemeModeScopeState();
}

class _STThemeModeScopeState extends State<STThemeModeScope> {
  late STThemeModeController _controller;
  var _ownsController = false;

  @override
  void initState() {
    super.initState();
    _attach(
      widget.controller ?? STThemeModeController(mode: widget.initialMode),
      owns: widget.controller == null,
    );
  }

  @override
  void didUpdateWidget(STThemeModeScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == oldWidget.controller) return;
    _detach();
    _attach(
      widget.controller ?? STThemeModeController(mode: widget.initialMode),
      owns: widget.controller == null,
    );
  }

  void _attach(STThemeModeController controller, {required bool owns}) {
    _controller = controller;
    _ownsController = owns;
    _controller.addListener(_rebuild);
  }

  void _detach() {
    _controller.removeListener(_rebuild);
    if (_ownsController) {
      _controller.dispose();
    }
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    _detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _STThemeModeInherited(
      controller: _controller,
      child: widget.builder(context, _controller),
    );
  }
}

class _STThemeModeInherited extends InheritedNotifier<STThemeModeController> {
  const _STThemeModeInherited({
    required STThemeModeController controller,
    required super.child,
  }) : super(notifier: controller);
}

/// Stock [Switch] that forces the app light/dark via [STThemeModeScope].
class STThemeModeSwitch extends StatelessWidget {
  const STThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = STThemeModeScope.of(context);
    return Switch.adaptive(
      value: mode.isDark(context),
      onChanged: mode.setDark,
    );
  }
}
