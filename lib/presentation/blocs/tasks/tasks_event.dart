part of 'tasks_bloc.dart';

/// Base class for all events related to [TasksBloc].
///
/// Events notify the BLoC that something happened
/// (user action, UI trigger, etc.).
abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

/// Event requesting to load (or reload) tasks.
class TasksLoadEvent extends TasksEvent {
  const TasksLoadEvent();
}

/// Event requesting deletion of a task by ID.
class TasksDeleteTaskEvent extends TasksEvent {
  const TasksDeleteTaskEvent({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

/// Event requesting update of a specific task.
class TasksUpdateTaskEvent extends TasksEvent {
  const TasksUpdateTaskEvent({required this.task});

  final TaskDomain task;

  @override
  List<Object> get props => [task];
}

/// Sets a new status filter for the task list.
class TasksSetStatusFilterEvent extends TasksEvent {
  const TasksSetStatusFilterEvent({required this.status});

  final TaskStatus status;

  @override
  List<Object> get props => [status];
}

/// Sets a new category filter for the task list.
class TasksSetCategoryFilterEvent extends TasksEvent {
  const TasksSetCategoryFilterEvent({required this.category});

  final TaskCategory category;

  @override
  List<Object> get props => [category];
}
