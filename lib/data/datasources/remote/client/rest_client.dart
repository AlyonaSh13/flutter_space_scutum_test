import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_space_scutum_test/data/datasources/remote/entities/weather_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

/// Retrofit API client responsible for making HTTP requests
/// to the remote weather service.
///
/// This interface defines all endpoints and their parameters.
/// Retrofit automatically generates the implementation inside
/// `rest_client.g.dart` based on the annotations below.
///
/// Usage:
/// ```dart
/// final client = RestClient(dio, baseUrl: env.weatherBaseUrl);
/// final weather = await client.getWeather(
///   query: 'Kharkiv',
///   appid: env.weatherApiKey,
///   units: 'metric',
///   lang: 'ua',
/// );
/// ```
@RestApi()
abstract class RestClient {
  /// Creates an instance of the generated API client.
  ///
  /// The [baseUrl] is usually provided from the environment
  /// layer (e.g., DevelopmentEnvironment, ProductionEnvironment).
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// Fetches current weather data for a specific location.
  ///
  /// Parameters:
  /// - [query] — the city name (e.g., "Kharkiv")
  /// - [appid] — OpenWeather API key
  /// - [units] — measurement units ("metric", "imperial")
  /// - [lang] — response language ("en", "ua", "ru")
  ///
  /// Endpoint reference:
  /// https://api.openweathermap.org/data/2.5/weather
  @GET("/weather")
  Future<WeatherResponse> getWeather({
    @Query('q') required String? query,
    @Query('appid') required String? appid,
    @Query('units') required String? units,
    @Query('lang') required String? lang,
  });
}
