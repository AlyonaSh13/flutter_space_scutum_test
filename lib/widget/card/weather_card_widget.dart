import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';

/// A compact information card used to display weather details,
/// such as humidity, feels-like temperature, pressure, or wind speed.
///
/// The card shows:
/// - a title (metric name)
/// - an icon
/// - a main value (highlighted)
///
/// Designed to be used inside a Wrap or Grid-like layout.
class WeatherCardWidget extends StatelessWidget {
  const WeatherCardWidget({required this.title, required this.icon, required this.value, super.key});

  /// Label describing the weather parameter (e.g., "Humidity").
  final String title;

  /// Icon representing the parameter visually.
  final IconData icon;

  /// String value shown as the main metric (e.g., "74%", "5 m/s").
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.colorGraphite,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          border: Border.all(color: AppColors.colorGraphiteLine),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Card title (secondary emphasis)
            Text(title, style: AppTextStyle.regular16.copyWith(color: AppColors.colorMutedGray, fontSize: 14)),
            const SizedBox(height: 10),

            /// Main row: icon + value
            Row(
              children: [
                Icon(icon, color: AppColors.colorAzureBlue),
                const SizedBox(width: 6),

                /// Highlighted metric value
                Text(value, style: AppTextStyle.regular16.copyWith(color: AppColors.colorPureWhite, fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
