import 'package:flutter_space_scutum_test/core/utils/constants.dart';
import 'package:intl/intl.dart';

/// Extension that adds helper formatting methods to [DateTime].
///
/// This extension improves readability and keeps date/time
/// formatting consistent across the entire project.
extension DateTimeExtension on DateTime {
  /// Returns the time in "HH:mm" format (e.g., "12:45").
  ///
  /// The format pattern itself is stored in [Constants.timeHmFormat]
  /// to avoid hardcoded (magic) strings and ensure consistency.
  String get timeHm {
    return DateFormat(Constants.timeHmFormat).format(this);
  }
}
