import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_space_scutum_test/core/environments/app_environment.dart';
import 'package:injectable/injectable.dart';

/// Development environment configuration.
/// This class is activated when the app runs in the `dev` environment.
///
/// Responsibilities:
/// - Provide the base URL for weather API calls in development mode.
/// - Load the API key from the `.env` file using `flutter_dotenv`.
///
/// `@LazySingleton` ensures that the environment instance is created once
/// and reused across the entire app lifecycle.
@LazySingleton(as: AppEnvironment)
@dev
class DevelopmentEnvironment implements AppEnvironment {
  /// Base URL used for all OpenWeather API requests
  /// during development.
  @override
  String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5';

  /// Weather API key loaded from the `.env` file.
  /// If the key is missing, an empty string is used to avoid crashes.
  @override
  String weatherApiKey = dotenv.env['WEATHER_API_KEY'] ?? '';
}
