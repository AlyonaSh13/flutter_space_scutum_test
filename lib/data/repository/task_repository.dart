import 'package:flutter_space_scutum_test/data/datasources/database/services/task_service.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:injectable/injectable.dart';

/// Repository interface for managing task-related operations.
///
/// This abstraction allows the domain layer to remain completely
/// independent from the underlying data source (Hive, REST API, etc.).
///
/// Implementations of this interface handle the actual persistence logic.
abstract class TaskRepository {
  /// Saves a new task or overwrites an existing one.
  Future<void> addTask({required TaskDomain task});

  /// Deletes a task using its unique ID.
  Future<void> deleteTaskById({required String id});

  /// Returns all stored tasks from the data source.
  Future<List<TaskDomain>> getTasks();

  /// Updates an existing task in the data source.
  Future<void> updateTask({required TaskDomain task});
}

/// Repository implementation that uses [TaskService]
/// to interact with Hive storage.
///
/// This class acts as a bridge:
/// - **Domain layer** talks to the repository
/// - **Repository** delegates to the service (Hive)
///
/// This separation ensures testability and clean architecture alignment.
@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this._taskService);

  /// Service responsible for direct Hive access and data mapping.
  final TaskService _taskService;

  @override
  Future<void> addTask({required TaskDomain task}) async {
    await _taskService.addTask(task: task);
  }

  @override
  Future<void> deleteTaskById({required String id}) async {
    await _taskService.deleteTaskById(id: id);
  }

  @override
  Future<List<TaskDomain>> getTasks() async {
    return _taskService.getTasks();
  }

  @override
  Future<void> updateTask({required TaskDomain task}) async {
    await _taskService.updateTask(task: task);
  }
}
