import 'package:flutter/material.dart';

import 'st_component.dart';
import 'st_typography.dart';

/// What an extra token is for. Drives generated getters (`ghostButton`, `label`, …).
enum STKind { button, card, container, text }

/// App-specific design token: another button style, card, container, or text role.
class STExtra {
  final String name;
  final STKind kind;
  final STComponent style;
  final STTextToken? text;

  const STExtra({
    required this.name,
    required this.kind,
    this.style = const STComponent(),
    this.text,
  });

  factory STExtra.button(
    String name, {
    STComponent style = const STComponent(),
  }) {
    return STExtra(name: name, kind: STKind.button, style: style);
  }

  factory STExtra.card(String name, {STComponent style = const STComponent()}) {
    return STExtra(name: name, kind: STKind.card, style: style);
  }

  factory STExtra.container(
    String name, {
    STComponent style = const STComponent(),
  }) {
    return STExtra(name: name, kind: STKind.container, style: style);
  }

  factory STExtra.text(String name, {required STTextToken token}) {
    return STExtra(name: name, kind: STKind.text, text: token);
  }
}

/// Extra after brightness resolve.
class STResolvedExtra {
  final STKind kind;
  final STResolvedComponent? component;
  final TextStyle? textStyle;

  const STResolvedExtra({required this.kind, this.component, this.textStyle});
}
