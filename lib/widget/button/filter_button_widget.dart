import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';
import 'package:flutter_space_scutum_test/widget/ink_well_material_widget.dart';

/// A filter button used for selecting categories or status filters.
///
/// This widget behaves like a toggleable chip/button.
/// It visually highlights itself when selected and uses a custom
/// Material-ink effect via [InkWellMaterialWidget].
///
/// Features:
/// - Customizable selection state.
/// - Smooth rounded shape.
/// - Dynamic background and text color depending on whether the button is selected.
/// - Uses app typography and color tokens for consistency.
class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({required this.text, required this.isSelected, required this.onTap, super.key});

  /// Displayed text inside the filter button.
  final String text;

  /// Whether the button is currently selected.
  final bool isSelected;

  /// Callback invoked when the user taps the button.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(14));

    return InkWellMaterialWidget(
      borderRadius: borderRadius,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          /// Background switches between accent color and neutral graphite.
          color: isSelected ? AppColors.colorAzureBlue : AppColors.colorGraphite,
          borderRadius: borderRadius,

          /// Border is shown only when not selected to visually balance the layout.
          border: Border.all(color: isSelected ? Colors.transparent : AppColors.colorGraphiteLine),
        ),
        child: Text(
          text,
          style: AppTextStyle.medium14.copyWith(
            /// Text becomes white when selected, muted gray otherwise.
            color: isSelected ? AppColors.colorPureWhite : AppColors.colorSteelGray,
          ),
        ),
      ),
    );
  }
}
