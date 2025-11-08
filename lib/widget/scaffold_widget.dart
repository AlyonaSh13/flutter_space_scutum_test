import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';

/// A custom wrapper around Flutter's [Scaffold] to ensure
/// consistent styling and background color throughout the app.
///
/// This widget centralizes layout structure and enforces
/// a shared dark theme background (`colorNightBlack`) across all pages.
///
/// Features:
/// - Custom background color for unified visual design.
/// - Optional AppBar, BottomNavigationBar, and FloatingActionButton.
/// - Clean and reusable layout wrapper for all screens.
class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    required this.body,
    super.key,
    this.bottomNavigationBar,
    this.appBar,
    this.floatingActionButton,
  });

  /// The main content of the screen.
  final Widget body;

  /// Optional bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// Optional app bar displayed at the top of the screen.
  final PreferredSizeWidget? appBar;

  /// Optional floating action button.
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Top app bar if provided.
      appBar: appBar,

      /// Ensures consistent application dark background theme.
      backgroundColor: AppColors.colorNightBlack,

      /// Main page content.
      body: body,

      /// Optional bottom navigation bar.
      bottomNavigationBar: bottomNavigationBar,

      /// Optional floating action button.
      floatingActionButton: floatingActionButton,
    );
  }
}
