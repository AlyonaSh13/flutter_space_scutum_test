/// A centralized collection of application-wide constants.
///
/// Keeping constants in a single class ensures:
/// - no magic numbers or strings scattered across the project
/// - consistent usage of formatting patterns and API URLs
/// - easier maintenance and refactoring
class Constants {
  /// Hive type ID used for registering the `TaskHiveModel` adapter.
  /// Must be unique within the database layer.
  static const int taskTypeId = 1;

  /// Name of the Hive box where tasks are stored.
  static const String tasksBox = 'tasks';

  /// Time format used across the app to convert DateTime into "HH:mm".
  static const String timeHmFormat = 'HH:mm';

  /// Base URL for fetching weather condition icons from OpenWeather.
  /// The full icon URL is constructed like:
  /// `Constants.iconBaseUrl + '{icon}@2x.png'`
  static const String iconBaseUrl = 'https://openweathermap.org/img/wn/';

  /// Conversion factor from seconds (UNIX timestamp) to milliseconds.
  /// Needed because DateTime in Dart requires milliseconds.
  static const int secondsToMilliseconds = 1000;
}
