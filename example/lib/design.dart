import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

part 'design.g.dart';

/// Call from [main] before [runApp].
void initExampleScaleKit() {
  setPaddingSizes(
    SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48),
  );
  setMarginSizes(
    SizeValues.custom(xs: 4, sm: 8, md: 12, lg: 16, xl: 24, xxl: 32),
  );
  setRadiusSizes(
    SizeValues.custom(xs: 4, sm: 8, md: 12, lg: 16, xl: 20, xxl: 28),
  );
  setSpacingSizes(
    SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48),
  );
  setDefaultPadding(16);
  setDefaultMargin(8);
  setDefaultRadius(12);
  setDefaultSpacing(8);
}

/// Shared look tokens. Radius md matches [setRadiusSizes] above.
final appST = STTheme(
  colors: STColors(
    primary: const STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
    surface: const STColor(light: Color(0xFFFFFFFF), dark: Color(0xFF1E1E1E)),
    background: const STColor(
      light: Color(0xFFF7F7F7),
      dark: Color(0xFF121212),
    ),
    text: const STColor(light: Color(0xFF1C1B1F), dark: Color(0xFFE6E1E5)),
    extra: const {'brand': STColor(light: Color(0xFFFFB800))},
  ),
  radius: const STRadius(sm: 8, md: 12, lg: 16),
  typography: const STTypography(
    label: STTextToken(fontSize: 14, fontWeight: FontWeight.w600),
    sublabel: STTextToken(fontSize: 12, colorName: 'textSecondary'),
    description: STTextToken(
      fontSize: 14,
      height: 1.4,
      colorName: 'textSecondary',
    ),
  ),
  components: const STComponents(
    card: STComponent(elevation: 0),
    button: STComponent(elevation: 0),
  ),
  extras: [
    STExtra.button(
      'ghost',
      style: const STComponent(
        foreground: STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
        elevation: 0,
        states: STComponentStates(
          disabled: STComponent(
            foreground: STColor(
              light: Color(0xFF9E9E9E),
              dark: Color(0xFF6D6D6D),
            ),
          ),
          pressed: STComponent(
            fill: STColor(light: Color(0x1A6750A4), dark: Color(0x1AD0BCFF)),
          ),
        ),
      ),
    ),
    STExtra.button(
      'destructive',
      style: const STComponent(
        fill: STColor(light: Color(0xFFB3261E), dark: Color(0xFFF2B8B5)),
        elevation: 0,
        states: STComponentStates(
          disabled: STComponent(
            fill: STColor(light: Color(0x61B3261E), dark: Color(0x61F2B8B5)),
          ),
        ),
      ),
    ),
    STExtra.card('product', style: const STComponent(elevation: 0, radius: 20)),
    STExtra.container(
      'highlighted',
      style: const STComponent(
        fill: STColor(light: Color(0xFFFFF8E1), dark: Color(0xFF3E2723)),
      ),
    ),
    STExtra.text(
      'price',
      token: const STTextToken(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        colorName: 'primary',
      ),
    ),
  ],
);
