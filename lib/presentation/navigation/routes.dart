import 'package:flutter_space_scutum_test/presentation/pages/home/home_router.dart';
import 'package:flutter_space_scutum_test/presentation/pages/not_found/not_found_page.dart';
import 'package:go_router/go_router.dart';

/// Centralized router configuration for the application.
///
/// Uses `GoRouter` to define the navigation graph,
/// including:
/// - initial route
/// - routes from feature modules (e.g., HomeRouter)
/// - global error page
///
/// Keeping routing in a dedicated class ensures clean structure
/// and makes navigation configuration scalable.
class Routes {
  /// Global GoRouter instance used throughout the app.
  ///
  /// - [initialLocation] defines the starting page of the app.
  /// - Route definitions are imported from `HomeRouter`
  ///   (following feature-based routing organization).
  /// - [errorBuilder] displays a fallback UI when no route matches.
  static final GoRouter router = GoRouter(
    initialLocation: HomeRouter.initial,
    routes: [
      ...HomeRouter.routes, // Feature-based routing structure
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
