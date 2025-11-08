import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';
import 'package:go_router/go_router.dart';

/// Utility class for displaying application-wide dialogs.
///
/// Purpose:
/// - Centralizes dialog UI styles
/// - Ensures consistent look across the app
/// - Helps maintain cleaner UI code in widgets and blocs
///
/// Currently supports error dialogs, but can be easily
/// extended with info/success/confirmation dialogs.
class DialogHelper {
  /// Shows a generic error dialog.
  ///
  /// Displays:
  /// - red icon
  /// - error message text
  /// - single "OK" button to dismiss
  static Future<void> showErrorDialog(BuildContext context, {required String message}) {
    return _showDialog(context: context, message: message, icon: Icons.close, colorIcon: AppColors.colorSoftRed);
  }

  /// Internal method that builds and displays a styled [AlertDialog].
  ///
  /// Parameters:
  /// - `message` — the dialog message
  /// - `icon` — the icon to show at the top
  /// - `colorIcon` — the color of the icon
  ///
  /// This method keeps the UI consistent and prevents duplication.
  static Future<void> _showDialog({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color colorIcon,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.colorGraphite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          icon: Icon(icon, size: 28, color: colorIcon),
          content: Text(
            message,
            style: AppTextStyle.light14.copyWith(color: AppColors.colorPureWhite),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text('OK', style: AppTextStyle.medium14.copyWith(color: AppColors.colorAzureBlueDark)),
            ),
          ],
        );
      },
    );
  }
}
