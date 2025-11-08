import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';

/// Centralized text style definitions used throughout the application.
///
/// These styles act as typography design tokens, ensuring consistency
/// in font sizes, weights, and colors across all UI components.
///
/// Each text style is immutable (`const`) to maximize performance
/// and allow safe reuse inside Flutter widgets.
class AppTextStyle {
  static const medium18 = TextStyle(color: AppColors.colorPureWhite, fontSize: 18, fontWeight: FontWeight.w500);

  static const semibold16 = TextStyle(color: AppColors.colorPureWhite, fontSize: 16, fontWeight: FontWeight.w600);

  static const regular16 = TextStyle(color: AppColors.colorSteelGray, fontSize: 16, fontWeight: FontWeight.w400);

  static const medium14 = TextStyle(color: AppColors.colorAzureBlue, fontSize: 14, fontWeight: FontWeight.w500);

  static const light14 = TextStyle(color: AppColors.colorMutedGray, fontSize: 14, fontWeight: FontWeight.w300);
}
