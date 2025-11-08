import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';

/// A reusable dropdown widget used throughout the application.
///
/// This component wraps Flutter's built-in [DropdownButton] and applies
/// the project's custom styling, including colors, typography, and rounding.
/// It is generic and can be used with any type [T].
///
/// Features:
/// - Clean UI with rounded container and custom background.
/// - Optional hint text for empty state.
/// - Hidden underline for a modern appearance.
/// - Ensures that `onChanged` is only triggered when value is non-null.
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({required this.value, required this.items, required this.onChanged, super.key, this.hint});

  /// Currently selected value in the dropdown.
  final T? value;

  /// List of menu items shown in the dropdown.
  final List<DropdownMenuItem<T>> items;

  /// Callback fired when the user selects a new value.
  final ValueChanged<T> onChanged;

  /// Optional placeholder text shown when no item is selected.
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.colorGraphiteLine,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.colorGraphiteLine),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          /// Current selected value.
          value: value,

          /// Arrow icon.
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.colorPureWhite),

          /// Background color of the dropdown menu.
          dropdownColor: AppColors.colorGraphite,

          /// Text style for dropdown items.
          style: AppTextStyle.regular16.copyWith(color: AppColors.colorPureWhite),

          /// Optional hint displayed when no value is selected.
          hint: hint != null
              ? Text(hint!, style: AppTextStyle.regular16.copyWith(color: AppColors.colorSteelGray))
              : null,

          /// Provided dropdown items.
          items: items,

          /// Wraps callback to ensure only valid values are passed.
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}
