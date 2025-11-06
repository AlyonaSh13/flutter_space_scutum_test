part of 'weather_bloc.dart';

/// Base class for all weather-related states.
///
/// Each state contains:
/// - the last successfully loaded weather information (nullable),
///   allowing the UI to keep showing previous data during refresh.
abstract class WeatherState extends Equatable {
  const WeatherState({required this.weather});

  /// Last known weather data, or null if nothing was loaded yet.
  final WeatherDomain? weather;

  @override
  List<Object?> get props => [weather];
}

/// Initial state — no weather has been loaded yet.
class WeatherInitialState extends WeatherState {
  const WeatherInitialState({super.weather});
}

/// Loading state — a request is in progress.
///
/// Keeps the previous weather data (if any) so UI can show a placeholder.
class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState({required super.weather});
}

/// Successful state — weather data has been loaded.
class WeatherLoadedState extends WeatherState {
  const WeatherLoadedState({required super.weather});
}

/// Error state — an error occurred while loading the weather.
///
/// Keeps previous weather data so the UI does not go blank.
class WeatherErrorState extends WeatherState {
  const WeatherErrorState({required super.weather});
}
