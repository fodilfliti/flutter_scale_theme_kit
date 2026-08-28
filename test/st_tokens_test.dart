import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

void main() {
  test('default md radius is 12 as BorderRadius and double', () {
    const r = STRadius();
    expect(r.mdValue, 12);
    expect(r.md, BorderRadius.circular(12));
  });

  test('custom md constructor', () {
    const r = STRadius(md: 20);
    expect(r.mdValue, 20);
    expect(r.md, BorderRadius.circular(20));
  });

  test('extra component map stores highlighted', () {
    const highlighted = STComponent(fill: STColor(light: Color(0xFFFFF8E1)));
    const components = STComponents(
      extra: {'highlighted': highlighted},
      fab: STComponent(elevation: 8),
    );
    expect(components.lookup('highlighted'), highlighted);
    expect(components.lookup('fab')?.elevation, 8);
    expect(components.lookup('floatingActionButton')?.elevation, 8);
    expect(components.lookup('switch'), isNull);
  });
}
