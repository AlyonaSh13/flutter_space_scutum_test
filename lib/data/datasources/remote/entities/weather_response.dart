import 'package:flutter_space_scutum_test/domain/entities/weather_domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

/// Top-level API response model for OpenWeather.
///
/// This class represents the exact structure returned by the API.
/// It is mapped **from JSON only** (no toJson) since we never send it back.
///
/// Each nested field has its own response class (CoordResponse, WindResponse, etc.).
/// The `toDomain()` method converts this raw DTO into a clean domain model.
@JsonSerializable(createToJson: false)
class WeatherResponse {
  const WeatherResponse({
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

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);

  /// Geographic coordinates (lon, lat).
  @JsonKey(name: 'coord')
  final CoordResponse location;

  /// Weather conditions (may contain multiple states).
  @JsonKey(name: 'weather')
  final List<WeatherConditionResponse> conditions;

  /// Internal API field, usually `"stations"`.
  final String base;

  /// Temperature details (current, min, max, feels_like, etc.).
  @JsonKey(name: 'main')
  final TemperatureResponse temperature;

  /// Horizontal visibility in meters.
  final int? visibility;

  /// Wind information (speed, direction, gust).
  final WindResponse wind;

  /// Rain volume during the last hour (nullable).
  final RainResponse? rain;

  /// Cloudiness in %.
  final CloudsResponse clouds;

  /// Timestamp of the measurement (Unix).
  @JsonKey(name: 'dt')
  final int timestamp;

  /// System data (country code, sunrise, sunset).
  @JsonKey(name: 'sys')
  final WeatherInfoResponse info;

  /// Timezone offset in seconds.
  final int timezone;

  /// City ID.
  final int id;

  /// City name.
  @JsonKey(name: 'name')
  final String cityName;

  /// Request status code (200, 404, etc.).
  @JsonKey(name: 'cod')
  final int statusCode;

  /// Converts this DTO into a domain entity used by the rest of the app.
  WeatherDomain toDomain() => WeatherDomain(
    location: location.toDomain(),
    conditions: conditions.map((e) => e.toDomain()).toList(),
    base: base,
    temperature: temperature.toDomain(),
    wind: wind.toDomain(),
    clouds: clouds.toDomain(),
    timestamp: timestamp,
    info: info.toDomain(),
    timezone: timezone,
    id: id,
    cityName: cityName,
    statusCode: statusCode,
    visibility: visibility,
    rain: rain?.toDomain(),
  );
}

/// ===============================
/// COORDINATES
/// ===============================
@JsonSerializable(createToJson: false)
class CoordResponse {
  const CoordResponse({required this.longitude, required this.latitude});

  factory CoordResponse.fromJson(Map<String, dynamic> json) => _$CoordResponseFromJson(json);

  /// Longitude.
  @JsonKey(name: 'lon')
  final double longitude;

  /// Latitude.
  @JsonKey(name: 'lat')
  final double latitude;

  CoordDomain toDomain() => CoordDomain(longitude: longitude, latitude: latitude);
}

/// ===============================
/// WEATHER CONDITIONS
/// ===============================
@JsonSerializable(createToJson: false)
class WeatherConditionResponse {
  const WeatherConditionResponse({
    required this.id,
    required this.group,
    required this.description,
    required this.iconCode,
  });

  factory WeatherConditionResponse.fromJson(Map<String, dynamic> json) => _$WeatherConditionResponseFromJson(json);

  /// Weather condition ID.
  final int id;

  /// Group of weather parameters (Rain, Snow, Clouds...).
  @JsonKey(name: 'main')
  final String group;

  /// Human-readable description.
  final String description;

  /// Icon code for retrieving weather icons.
  @JsonKey(name: 'icon')
  final String iconCode;

  WeatherConditionDomain toDomain() =>
      WeatherConditionDomain(id: id, group: group, description: description, iconCode: iconCode);
}

/// ===============================
/// TEMPERATURE BLOCK
/// ===============================
@JsonSerializable(createToJson: false)
class TemperatureResponse {
  const TemperatureResponse({
    required this.current,
    required this.feelsLike,
    required this.min,
    required this.max,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.groundLevel,
    this.visibility,
  });

  factory TemperatureResponse.fromJson(Map<String, dynamic> json) => _$TemperatureResponseFromJson(json);

  /// Current temperature.
  @JsonKey(name: 'temp')
  final double current;

  /// "Feels like" temperature.
  @JsonKey(name: 'feels_like')
  final double feelsLike;

  /// Minimum temperature.
  @JsonKey(name: 'temp_min')
  final double min;

  /// Maximum temperature.
  @JsonKey(name: 'temp_max')
  final double max;

  /// Atmospheric pressure.
  final int? pressure;

  /// Humidity percentage.
  final int? humidity;

  /// Sea level pressure (if provided).
  @JsonKey(name: 'sea_level')
  final int? seaLevel;

  /// Ground level pressure.
  @JsonKey(name: 'grnd_level')
  final int? groundLevel;

  /// Visibility override (rarely provided).
  final int? visibility;

  TemperatureDomain toDomain() => TemperatureDomain(
    current: current,
    feelsLike: feelsLike,
    min: min,
    max: max,
    pressure: pressure,
    humidity: humidity,
    seaLevel: seaLevel,
    groundLevel: groundLevel,
    visibility: visibility,
  );
}

/// ===============================
/// WIND
/// ===============================
@JsonSerializable(createToJson: false)
class WindResponse {
  const WindResponse({required this.speed, required this.degrees, this.gust});

  factory WindResponse.fromJson(Map<String, dynamic> json) => _$WindResponseFromJson(json);

  /// Wind speed in m/s.
  final double speed;

  /// Wind direction (degrees).
  @JsonKey(name: 'deg')
  final int degrees;

  /// Wind gust (optional).
  final double? gust;

  WindDomain toDomain() => WindDomain(speed: speed, degrees: degrees);
}

/// ===============================
/// RAIN
/// ===============================
@JsonSerializable(createToJson: false)
class RainResponse {
  const RainResponse({required this.oneHour});

  factory RainResponse.fromJson(Map<String, dynamic> json) => _$RainResponseFromJson(json);

  /// Rain volume in the last hour (mm).
  @JsonKey(name: '1h')
  final double? oneHour;

  RainDomain toDomain() => RainDomain(oneHour: oneHour);
}

/// ===============================
/// CLOUDS
/// ===============================
@JsonSerializable(createToJson: false)
class CloudsResponse {
  const CloudsResponse({required this.all});

  factory CloudsResponse.fromJson(Map<String, dynamic> json) => _$CloudsResponseFromJson(json);

  /// Cloudiness percentage.
  final int all;

  CloudsDomain toDomain() => CloudsDomain(all: all);
}

/// ===============================
/// SYSTEM INFO
/// ===============================
@JsonSerializable(createToJson: false)
class WeatherInfoResponse {
  const WeatherInfoResponse({required this.country, required this.sunrise, required this.sunset});

  factory WeatherInfoResponse.fromJson(Map<String, dynamic> json) => _$WeatherInfoResponseFromJson(json);

  /// Country code (UA, US, etc.).
  final String country;

  /// Sunrise timestamp.
  final int sunrise;

  /// Sunset timestamp.
  final int sunset;

  WeatherInfoDomain toDomain() => WeatherInfoDomain(country: country, sunrise: sunrise, sunset: sunset);
}
