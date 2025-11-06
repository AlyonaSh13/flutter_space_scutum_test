/// Abstraction for application environment configuration.
/// Each concrete implementation (dev, prod, staging) must provide:
/// - the base URL for the weather API
/// - the API key used for authentication
abstract class AppEnvironment {
  /// Base URL for the OpenWeather API.
  String get weatherBaseUrl;

  /// API key used to authorize requests to the weather service.
  String get weatherApiKey;
}
