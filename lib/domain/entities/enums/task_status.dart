/// Represents the completion state of a task.
///
/// This enum is used for:
/// - filtering tasks in the UI
/// - controlling business logic inside blocs/use cases
/// - improving readability instead of using booleans
///
/// Each value includes a localized `title` used directly in the UI.
enum TaskStatus {
  all,
  notCompleted,
  completed;

  /// Human-readable title used for filters and labels in the UI.
  ///
  /// The values are localized (Ukrainian) and can be safely changed
  /// without affecting business logic or stored data.
  String get title {
    return switch (this) {
      TaskStatus.all => 'Всі',
      TaskStatus.notCompleted => 'Не виконані',
      TaskStatus.completed => 'Виконані',
    };
  }
}
