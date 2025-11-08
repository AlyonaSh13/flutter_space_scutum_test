import 'package:flutter/material.dart';

/// A reusable custom button component that wraps Flutter's [ElevatedButton].
///
/// This widget applies consistent styling across the application and allows
/// configuration of title text, colors, borders, and the onPressed callback.
///
/// Features:
/// - Custom background and foreground colors.
/// - Optional border for outlined button styling.
/// - Rounded corners for modern UI.
/// - Fixed padding for consistent sizing.
/// - Uses external text style for full typography control.
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.title,
    required this.textStyle,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
    this.side,
  });

  /// Text displayed inside the button.
  final String title;

  /// Style applied to the button text.
  final TextStyle textStyle;

  /// Callback triggered when the user presses the button.
  final void Function()? onPressed;

  /// Button background color.
  final Color backgroundColor;

  /// Button foreground color (text + ripple effect).
  final Color foregroundColor;

  /// Optional border used for outlined buttons.
  final BorderSide? side;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: side,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      ),
      child: Text(title, style: textStyle),
    );
  }
}
