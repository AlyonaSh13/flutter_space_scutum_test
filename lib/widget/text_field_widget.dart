import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';

/// A reusable styled text field used across the application.
///
/// This widget wraps [TextFormField] and provides:
/// - consistent styling (colors, borders, radii)
/// - built-in validation support
/// - automatic focus navigation (Next → Next → Done)
/// - optional scroll controller for long text
///
/// It follows the app’s design system and ensures visual consistency.
class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.hintText,
    required this.controller,
    required this.scrollController,
    super.key,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.next,
    this.maxLine = 1,
  });

  /// Placeholder text displayed inside the input.
  final String hintText;

  /// Controller holding the current input value.
  final TextEditingController controller;

  /// Optional scroll controller (useful for multi-line fields).
  final ScrollController? scrollController;

  /// Callback fired every time text changes.
  final void Function(String)? onChanged;

  /// Optional validation function for form logic.
  final String? Function(String?)? validator;

  /// Current field focus node.
  final FocusNode? focusNode;

  /// Focus node of the next field (for automatic navigation).
  final FocusNode? nextFocusNode;

  /// Defines the keyboard action: Next, Done, etc.
  final TextInputAction textInputAction;

  /// Maximum number of lines allowed in the field.
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      scrollController: scrollController,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      /// Typing style inside the field.
      style: AppTextStyle.medium14.copyWith(color: AppColors.colorPureWhite),

      maxLines: maxLine,
      textInputAction: textInputAction,
      onChanged: onChanged,

      /// Automatically moves focus to next field or dismisses keyboard.
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },

      /// Visual styling of the text field.
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.light14.copyWith(color: AppColors.colorMutedGray),

        filled: true,
        fillColor: AppColors.colorGraphiteLine,

        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

        /// Default border.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.colorGraphiteLine, width: 1.2),
        ),

        /// Blue border when focused.
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.colorAzureBlue, width: 1.2),
        ),

        /// Red border on validation error.
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.colorSoftRed, width: 1.2),
        ),

        /// Red border when focused & invalid.
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.colorSoftRed, width: 1.2),
        ),

        /// Error message style.
        errorStyle: AppTextStyle.regular16.copyWith(fontSize: 14, color: AppColors.colorSoftRed),
      ),
    );
  }
}
