import 'package:equatable/equatable.dart';
import 'package:flutter_space_scutum_test/core/utils/constants.dart';

/// Domain entity representing the aggregated weather information.
///
/// This class is used exclusively inside the **domain layer** and
/// contains clean, framework-independent business data.
/// All mapping from DTOs (API responses) is done in the data layer.
class WeatherDomain extends Equatable {
  const WeatherDomain({
    required this.location,
    required this.conditions,
    required this.base,
    required this.temperature,
    required this.visibility,
    required this.wind,
    required this.rain,
    required this.clouds,
    required this.timestamp,
    required this.info,
    required this.timezone,
    required this.id,
    required this.cityName,
    required this.statusCode,
  });

  /// Geographic coordinates.
  final CoordDomain location;

  /// List of current weather conditions (may contain multiple entries).
  final List<WeatherConditionDomain> conditions;

  /// Internal OpenWeather field, usually `"stations"`.
  final String base;

  /// Temperature-related data (current, feels_like, min, max, etc.).
  final TemperatureDomain temperature;

  /// Visibility in meters.
  final int? visibility;

  /// Wind information.
  final WindDomain wind;

  /// Rain volume for the last hour (nullable).
  final RainDomain? rain;

  /// Cloudiness in percentage.
  final CloudsDomain clouds;

  /// Timestamp (UNIX) of the weather measurement.
  final int timestamp;

  /// System information (country, sunrise, sunset).
  final WeatherInfoDomain info;

  /// Timezone offset in seconds.
  final int timezone;

  /// City ID.
  final int id;

  /// City name.
  final String cityName;

  /// API status code (e.g., 200, 404).
  final int statusCode;

  /// Converts the UNIX timestamp into a [DateTime].
  ///
  /// OpenWeather API returns seconds, but Dart expects milliseconds.
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp * Constants.secondsToMilliseconds);

  @override
  List<Object?> get props => [
    location,
    conditions,
    base,
    temperature,
    visibility,
    wind,
    rain,
    clouds,
    timestamp,
    info,
    timezone,
    id,
    cityName,
    statusCode,
  ];
}

/// ===============================
/// LOCATION
/// ===============================

/// Domain representation of geographic coordinates.
class CoordDomain {
  const CoordDomain({required this.longitude, required this.latitude});

  final double longitude;
  final double latitude;
}

/// ===============================
/// WEATHER CONDITIONS
/// ===============================

/// Domain model for a single weather condition entry.
class WeatherConditionDomain {
  const WeatherConditionDomain({
    required this.id,
    required this.group,
    required this.description,
    required this.iconCode,
  });

  /// Condition ID.
  final int id;

  /// Group of weather types (e.g., Clouds, Rain, Snow).
  final String group;

  /// Human-readable description.
  final String description;

  /// Icon code for fetching the weather icon.
  final String iconCode;
}

/// ===============================
/// TEMPERATURE
/// ===============================

/// Domain model containing temperature and pressure data.
class TemperatureDomain {
  const TemperatureDomain({
    required this.current,
    required this.feelsLike,
    required this.min,
    required this.max,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.groundLevel,
    required this.visibility,
  });

  /// Current temperature.
  final double current;

  /// "Feels like" temperature.
  final double feelsLike;

  /// Minimum temperature.
  final double min;

  /// Maximum temperature.
  final double max;

  /// Atmospheric pressure in hPa.
  final int? pressure;

  /// Humidity percentage.
  final int? humidity;

  /// Sea level pressure (optional).
  final int? seaLevel;

  /// Ground level pressure (optional).
  final int? groundLevel;

  /// Visibility override (rarely present).
  final int? visibility;
}

/// ===============================
/// WIND
/// ===============================

/// Domain model containing wind information.
class WindDomain {
  const WindDomain({required this.speed, required this.degrees, this.gust});

  /// Wind speed in m/s.
  final double speed;

  /// Wind direction in degrees.
  final int degrees;

  /// Wind gust speed (optional).
  final double? gust;
}

/// ===============================
/// RAIN
/// ===============================

/// Domain model representing rain volume for the past hour.
class RainDomain {
  const RainDomain({required this.oneHour});

  /// Rain volume in mm for the last hour.
  final double? oneHour;
}

/// ===============================
/// CLOUDS
/// ===============================

/// Domain model representing percentage of cloud coverage.
class CloudsDomain {
  const CloudsDomain({required this.all});

  /// Cloudiness in percentage (0-100).
  final int all;
}

/// ===============================
/// SYSTEM INFO
/// ===============================

/// Domain model containing system metadata (country, sunrise, sunset).
class WeatherInfoDomain {
  const WeatherInfoDomain({required this.country, required this.sunrise, required this.sunset});

  /// Country code (e.g., "UA").
  final String country;

  /// Sunrise timestamp (UNIX seconds).
  final int sunrise;

  /// Sunset timestamp (UNIX seconds).
  final int sunset;
}
