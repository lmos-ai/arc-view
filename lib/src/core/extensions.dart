import 'package:arc_view/src/core/text.dart';
import 'package:flutter/material.dart';

///
/// Widget Extensions
///
extension ContextExtensions on BuildContext {
  bool isMobile() {
    final platform = Theme.of(this).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.android;
  }

  Screen get screen {
    final size = MediaQuery.of(this).size;

    if (size.width < 400) {
      return Screen.small;
    }
    if (size.width < 800) {
      return Screen.medium;
    }
    return Screen.large;
  }

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  T themeExtension<T>() => Theme.of(this).extension<T>()!;
}

enum Screen { small, medium, large }

///
/// String Extensions
///
extension StringExtensions on String {
  Text get txt => Text(this);

  Text style({double? size, Color? color}) =>
      Text(this, style: TextStyle(color: color, fontSize: size));

  SubTitle get h2 => SubTitle(this);

  LargeTitle get h1 => LargeTitle(this);

  Widget onPressed(VoidCallback? onPressed) => TextButton(
        onPressed: onPressed,
        child: Text(this),
      );

  Widget onButtonPressed(VoidCallback? onPressed) => ElevatedButton(
        onPressed: onPressed,
        child: Text(this),
      );
}

///
/// Widget Extensions
///
extension WidgetExtensions on Widget {
  Widget padding([double padding = 8.0]) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingLeft([double padding = 8.0]) => Padding(
        padding: EdgeInsets.only(left: padding),
        child: this,
      );

  Widget paddingBottom([double padding = 8.0]) => Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: this,
      );

  Widget paddingRight([double padding = 8.0]) => Padding(
        padding: EdgeInsets.only(right: padding),
        child: this,
      );

  Widget toRight() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: this,
      );

  Widget toLeft() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: this,
      );

  Widget max({double? maxWidth, double? maxHeight}) => ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: this,
      );

  Widget expand({double? maxWidth, double? maxHeight}) => Expanded(child: this);
}
