import 'package:flutter_space_scutum_test/core/utils/constants.dart';
import 'package:flutter_space_scutum_test/domain/entities/enums/task_category.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:hive_ce/hive.dart';

part 'task_model.g.dart';

/// Hive data model used for local task persistence.
///
/// This class represents how a task is stored inside Hive.
/// It is intentionally separated from the domain model:
/// - Domain → business logic representation
/// - Model (this class) → serialized database format
///
/// All fields must be explicitly annotated with @HiveField
/// and each field index must remain unchanged once released.
@HiveType(typeId: Constants.taskTypeId)
class TaskModel {
  /// Creates a new Hive-compatible task model.
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isCompleted,
  });

  /// Converts a domain entity [TaskDomain] into a Hive model.
  ///
  /// This method keeps the data transformation consistent and avoids
  /// duplicating mapping logic in the repository.
  factory TaskModel.fromDomain(TaskDomain task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      category: task.category.value,
      isCompleted: task.isCompleted,
    );
  }

  /// Unique task ID used as the Hive key.
  @HiveField(0)
  final String id;

  /// Title of the task.
  @HiveField(1)
  final String title;

  /// Optional description or details of the task.
  @HiveField(2)
  final String description;

  /// Category stored as a string.
  ///
  /// NOTE: We store the enum's `value` rather than its index so that
  /// category order changes won't break persisted data.
  @HiveField(3)
  final String category;

  /// Indicates whether the task is completed.
  @HiveField(4)
  final bool isCompleted;

  /// Converts the Hive model back into a domain entity.
  ///
  /// Reverse-maps the `category` string back to a [TaskCategory] enum.
  TaskDomain toDomain() => TaskDomain(
    id: id,
    title: title,
    description: description,
    category: TaskCategory.values.firstWhere((e) => e.value == category),
    isCompleted: isCompleted,
  );
}
