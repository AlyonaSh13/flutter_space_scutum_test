import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/presentation/navigation/routes.dart';

/// The root widget of the application.
///
/// This widget initializes the global [MaterialApp] configuration
/// and sets up navigation using the GoRouter instance defined in `Routes`.
///
/// Key responsibilities:
/// - Provide the app’s navigation system.
/// - Disable the debug banner.
/// - Serve as the entry point for UI rendering.
///
/// This widget is used inside `main.dart` after dependency injection
/// and environment setup are complete.
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      /// GoRouter configuration (all routes for the app).
      routerConfig: Routes.router,

      /// Hides the default Flutter debug banner.
      debugShowCheckedModeBanner: false,
    );
  }
}
