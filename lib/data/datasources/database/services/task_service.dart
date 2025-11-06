import 'package:flutter_space_scutum_test/core/utils/constants.dart';
import 'package:flutter_space_scutum_test/data/datasources/database/models/task_model.dart';
import 'package:flutter_space_scutum_test/data/datasources/database/services/base_service_mixin.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

/// Service responsible for CRUD operations on tasks using Hive.
///
/// This service:
/// - interacts directly with Hive storage
/// - converts Hive models <-> domain models
/// - provides high-level methods for task persistence
///
/// It uses [BaseServiceMixin] to avoid duplicating box initialization logic.
@Injectable()
class TaskService with BaseServiceMixin<TaskModel> {
  /// Name of the Hive box where tasks are stored.
  @override
  String get boxName => Constants.tasksBox;

  /// Adapter used for serializing/deserializing [TaskModel].
  @override
  TypeAdapter<TaskModel> get adapter => TaskModelAdapter();

  /// Saves a new task or overwrites an existing one.
  Future<void> addTask({required TaskDomain task}) async {
    final box = await getBox();
    await box.put(task.id, TaskModel.fromDomain(task));
  }

  /// Deletes a task by its unique ID.
  Future<void> deleteTaskById({required String id}) async {
    final box = await getBox();
    await box.delete(id);
  }

  /// Returns all stored tasks sorted by ID.
  ///
  /// Converts each Hive model into a domain entity to keep
  /// the rest of the app independent of Hive.
  Future<List<TaskDomain>> getTasks() async {
    final box = await getBox();

    final tasks = box.values.map((m) => m.toDomain()).toList();
    tasks.sort((a, b) => a.id.compareTo(b.id));

    return tasks;
  }

  /// Updates an existing task.
  ///
  /// Uses the same logic as [addTask] since Hive's `put`
  /// overwrites the value at the given key.
  Future<void> updateTask({required TaskDomain task}) async {
    final box = await getBox();
    await box.put(task.id, TaskModel.fromDomain(task));
  }
}
