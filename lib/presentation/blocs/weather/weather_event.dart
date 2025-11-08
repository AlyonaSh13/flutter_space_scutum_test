part of 'weather_bloc.dart';

/// Base class for all events processed by [WeatherBloc].
///
/// Events represent user interactions or triggers that require
/// a change in the weather state.
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

/// Event requesting the weather to be loaded.
///
/// Currently loads weather for a predefined city ("Kharkiv").
class WeatherLoadEvent extends WeatherEvent {
  const WeatherLoadEvent();
}
