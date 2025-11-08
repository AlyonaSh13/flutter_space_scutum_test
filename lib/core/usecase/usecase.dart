/// Base class for use cases that require input parameters.
///
/// This class enforces a consistent API for all use cases in the domain layer.
/// Each use case:
/// - returns a value of type [T]
/// - receives input parameters of type [P]
/// - is executed via the `call()` method
///
/// Example:
/// ```dart
/// class GetWeatherUseCase extends UseCase<Weather, WeatherParams> {
///   @override
///   Future<Weather> call(WeatherParams params) {
///     return repository.getWeather(params.city);
///   }
/// }
/// ```
abstract class UseCase<T, P> {
  const UseCase();

  /// Executes the use case using the provided [params].
  Future<T> call(P params);
}

/// Base class for use cases that do NOT require input parameters.
///
/// Useful for simple actions like:
/// - loading all tasks
/// - fetching cached data
/// - checking authentication state
///
/// Example:
/// ```dart
/// class LoadTasksUseCase extends ExecuteUseCase<List<Task>> {
///   @override
///   Future<List<Task>> execute() {
///     return repository.getTasks();
///   }
/// }
/// ```
abstract class ExecuteUseCase<T> {
  const ExecuteUseCase();

  /// Executes the use case without any input parameters.
  Future<T> execute();
}
