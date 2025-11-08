import 'package:flutter_space_scutum_test/core/usecase/usecase.dart';
import 'package:flutter_space_scutum_test/data/repository/weather_repository.dart';
import 'package:flutter_space_scutum_test/domain/entities/weather_domain.dart';
import 'package:injectable/injectable.dart';

/// Use case responsible for fetching weather data for a specific city.
///
/// Delegates the actual network request to the weather repository
/// but exposes a clean interface to the domain/business layer.
@Injectable()
class GetWeatherUseCase extends UseCase<WeatherDomain, String> {
  const GetWeatherUseCase(this._repository);

  final WeatherRepository _repository;

  @override
  Future<WeatherDomain> call(String city) => _repository.getWeather(city);
}
