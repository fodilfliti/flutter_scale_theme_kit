// GENERATED CODE - do not modify by hand.
// dart run flutter_scale_theme_kit:generate

part of 'design.dart';

extension STAppExtras on STResolved {
  // Extra colors — Color (Container, Text, …)
  Color get brand => color('brand');
  // Buttons — ButtonStyle (ElevatedButton, FilledButton, …)
  STResolvedComponent get ghostButton => extraButton('ghost');
  ButtonStyle get ghostButtonStyle => ghostButton.toButtonStyle();
  STResolvedComponent get destructiveButton => extraButton('destructive');
  ButtonStyle get destructiveButtonStyle => destructiveButton.toButtonStyle();
  // Cards — BoxDecoration / fill Color
  STResolvedComponent get productCard => extraCard('product');
  BoxDecoration get productCardDecoration => productCard.toBoxDecoration();
  Color? get productCardColor => productCard.fill;
  // Containers — BoxDecoration / fill Color
  STResolvedComponent get highlightedContainer => extraContainer('highlighted');
  BoxDecoration get highlightedContainerDecoration =>
      highlightedContainer.toBoxDecoration();
  Color? get highlightedContainerColor => highlightedContainer.fill;
  // Text — TextStyle
  TextStyle get price => extraText('price');
}
