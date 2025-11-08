import 'package:equatable/equatable.dart';
import 'package:flutter_space_scutum_test/domain/entities/enums/task_category.dart';
import 'package:uuid/uuid.dart';

/// Domain entity representing a task in the business layer.
///
/// This class:
/// - defines the essential properties of a task
/// - contains no framework-specific or storage-specific logic
/// - is immutable (except through `copyWith`)
///
/// The domain layer should not depend on any external data sources
/// or UI logic — only pure business rules.
class TaskDomain extends Equatable {
  const TaskDomain({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isCompleted,
  });

  /// Factory constructor used for creating a new task instance.
  ///
  /// Generates a unique UUID for each new task and sets
  /// `isCompleted` to `false` by default.
  factory TaskDomain.create({required String title, required String description, required TaskCategory category}) {
    return TaskDomain(
      id: const Uuid().v4(),
      title: title,
      description: description,
      category: category,
      isCompleted: false,
    );
  }

  /// Unique identifier for the task.
  final String id;

  /// Task title.
  final String title;

  /// Optional description or additional details.
  final String description;

  /// Task category (work, personal, home, etc.)
  final TaskCategory category;

  /// Completion status of the task.
  final bool isCompleted;

  /// Creates a modified copy of the current task.
  ///
  /// This method follows the immutable data pattern and allows
  /// updating only the specified fields, leaving the rest unchanged.
  TaskDomain copyWith({String? id, String? title, String? description, TaskCategory? category, bool? isCompleted}) {
    return TaskDomain(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Properties used by `Equatable` to determine object equality.
  @override
  List<Object> get props => [id, title, description, category, isCompleted];
}
