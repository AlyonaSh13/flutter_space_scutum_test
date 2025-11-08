/// Represents the available categories a task can belong to.
///
/// Each enum value includes:
/// - a human-readable `title` (used in the UI)
/// - a stable `value` (used for persistence in Hive and filtering)
///
/// The separation ensures that UI labels can be changed freely
/// without breaking stored data or backend integrations.
enum TaskCategory {
  all,
  work,
  personal,
  learn,
  home,
  other;

  /// Human-readable title used in the UI.
  ///
  /// These titles are localized (Ukrainian in this case) and displayed
  /// on filter chips, list items, dialog selectors, etc.
  String get title {
    return switch (this) {
      TaskCategory.all => 'Всі',
      TaskCategory.work => 'Робота',
      TaskCategory.personal => 'Особисті справи',
      TaskCategory.learn => 'Навчання',
      TaskCategory.home => 'Дім',
      TaskCategory.other => 'Інше',
    };
  }

  /// Stable string value used for:
  /// - storing categories in Hive
  /// - comparing/filtering tasks
  ///
  /// We store category as a string instead of an index
  /// to avoid issues when enum order changes.
  String get value {
    return switch (this) {
      TaskCategory.all => 'all',
      TaskCategory.work => 'work',
      TaskCategory.personal => 'personal',
      TaskCategory.learn => 'learn',
      TaskCategory.home => 'home',
      TaskCategory.other => 'other',
    };
  }
}
