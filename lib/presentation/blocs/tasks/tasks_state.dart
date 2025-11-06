part of 'tasks_bloc.dart';

/// Base class for all task list states.
///
/// Each state contains:
/// - the current list of tasks
/// - the active status filter
/// - the active category filter
///
/// This keeps the entire UI in sync.
abstract class TasksState extends Equatable {
  const TasksState({required this.tasks, required this.filterStatus, required this.filterCategory});

  /// Tasks currently visible in the UI.
  final List<TaskDomain> tasks;

  /// Current completion filter.
  final TaskStatus filterStatus;

  /// Current category filter.
  final TaskCategory filterCategory;

  @override
  List<Object?> get props => [tasks, filterStatus, filterCategory];
}

/// Initial state before any action is performed.
class TasksInitialState extends TasksState {
  const TasksInitialState() : super(tasks: const [], filterStatus: TaskStatus.all, filterCategory: TaskCategory.all);
}

/// State emitted while tasks are loading.
class TasksLoadingState extends TasksState {
  const TasksLoadingState({required super.tasks, required super.filterStatus, required super.filterCategory});
}

/// State emitted when tasks have been successfully loaded.
class TasksLoadedState extends TasksState {
  const TasksLoadedState({required super.tasks, required super.filterStatus, required super.filterCategory});
}

/// State emitted when an error occurs.
class TasksErrorState extends TasksState {
  const TasksErrorState({required super.tasks, required super.filterStatus, required super.filterCategory});
}
