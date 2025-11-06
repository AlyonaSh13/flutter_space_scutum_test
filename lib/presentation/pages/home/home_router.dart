import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_scutum_test/di/injector.dart';
import 'package:flutter_space_scutum_test/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_space_scutum_test/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter_space_scutum_test/presentation/pages/home/home_page.dart';
import 'package:flutter_space_scutum_test/presentation/pages/home/weather_page.dart';
import 'package:go_router/go_router.dart';

/// Routing configuration for the Home feature.
///
/// This class organizes all routes related to the main functionality:
/// - the task list screen (HomePage)
/// - the weather screen (WeatherPage)
///
/// It uses feature-based routing to keep navigation separated
/// and scalable as the app grows.
class HomeRouter {
  /// Route path for the initial homepage of the app.
  static const String initial = '/initial';

  /// Route path for the weather screen.
  static const String weatherPage = '/weather_page';

  /// List of route definitions belonging to this feature.
  ///
  /// Each route:
  /// - defines a unique path
  /// - provides the required BLoC using dependency injection
  /// - builds a specific page inside a `BlocProvider`
  ///
  /// This ensures each screen has its own isolated state.
  static List<RouteBase> get routes => [
    /// Home page route (Task list)
    GoRoute(
      path: initial,
      builder: (context, state) {
        return BlocProvider(create: (_) => inject<TasksBloc>(), child: const HomePage());
      },
    ),

    /// Weather page route
    GoRoute(
      path: weatherPage,
      builder: (context, state) {
        return BlocProvider(create: (context) => inject<WeatherBloc>(), child: const WeatherPage());
      },
    ),
  ];
}
