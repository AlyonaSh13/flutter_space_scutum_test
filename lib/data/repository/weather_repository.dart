import 'package:flutter_space_scutum_test/core/environments/app_environment.dart';
import 'package:flutter_space_scutum_test/data/datasources/remote/client/rest_client.dart';
import 'package:flutter_space_scutum_test/domain/entities/weather_domain.dart';
import 'package:injectable/injectable.dart';

/// Repository interface for weather-related operations.
///
/// The domain layer depends on this abstraction instead of
/// a concrete data source implementation (Retrofit, HTTP, etc.).
/// This ensures clean architecture, testability, and flexibility.
abstract class WeatherRepository {
  /// Fetches the current weather information for the given [city].
  Future<WeatherDomain> getWeather(String city);
}

/// Concrete implementation of [WeatherRepository] that uses:
/// - [RestClient] for making API requests (Retrofit/Dio)
/// - [AppEnvironment] for base URL and API key
///
/// This class sits between the data layer and the domain layer.
/// It converts raw network DTOs into domain entities.
@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._client, this._environment);

  /// Retrofit client used for performing HTTP requests.
  final RestClient _client;

  /// Environment configuration that provides base URL and API key.
  final AppEnvironment _environment;

  @override
  Future<WeatherDomain> getWeather(String city) async {
    try {
      final response = await _client.getWeather(
        query: city,
        appid: _environment.weatherApiKey,
        units: 'metric', // Celsius
        lang: 'ua', // Ukrainian language
      );

      // Convert API response DTO into domain entity.
      return response.toDomain();
    } catch (e) {
      // Allow higher layers (use cases / blocs) to handle error.
      rethrow;
    }
  }
}
