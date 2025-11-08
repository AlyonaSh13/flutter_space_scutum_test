import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_space_scutum_test/domain/entities/weather_domain.dart';
import 'package:flutter_space_scutum_test/domain/usecases/get_weather_usecase.dart';
import 'package:injectable/injectable.dart';

part 'weather_state.dart';
part 'weather_event.dart';

/// BLoC responsible for fetching and managing **current weather data**.
///
/// This BLoC:
/// - triggers weather loading
/// - exposes loading, loaded, and error states
/// - stores the last successfully loaded weather data
///
/// It interacts with the domain layer through [GetWeatherUseCase].
@Injectable()
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._getWeatherUseCase) : super(const WeatherInitialState()) {
    on<WeatherLoadEvent>(_onLoadWeather);
  }

  /// Use case responsible for fetching weather data for a given city.
  final GetWeatherUseCase _getWeatherUseCase;

  /// Handles the [WeatherLoadEvent].
  ///
  /// Flow:
  /// 1. Emit loading state while preserving old weather data (if any).
  /// 2. Call the use case to fetch the weather.
  /// 3. Emit loaded state with fresh data.
  /// 4. Emit error state if the request fails.
  Future<void> _onLoadWeather(WeatherLoadEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadingState(weather: state.weather));

      // NOTE: The city name is hardcoded to “Kharkiv”.
      // If needed, you can modify WeatherLoadEvent to carry a dynamic city.
      final weather = await _getWeatherUseCase.call('Kharkiv');

      emit(WeatherLoadedState(weather: weather));
    } catch (_) {
      emit(WeatherErrorState(weather: state.weather));
    }
  }
}
