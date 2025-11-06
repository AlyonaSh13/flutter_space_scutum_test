part of 'task_bloc.dart';

/// Base class for all TaskBloc events.
///
/// Events represent user actions or external triggers
/// that the BLoC must react to.
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when a new task should be added.
///
/// Contains the [TaskDomain] entity representing the new task.
class TaskAddEvent extends TaskEvent {
  const TaskAddEvent({required this.task});

  /// The task to be added.
  final TaskDomain task;

  @override
  List<Object> get props => [task];
}
