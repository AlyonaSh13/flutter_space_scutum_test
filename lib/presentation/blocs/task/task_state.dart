part of 'task_bloc.dart';

/// Base class for all states emitted by [TaskBloc].
///
/// Each state represents the status of the add-task operation.
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any interaction happens.
class TaskInitialState extends TaskState {
  const TaskInitialState();
}

/// State emitted when a task is being added (loading indicator).
class TaskLoadingState extends TaskState {
  const TaskLoadingState();
}

/// State emitted when a task has been successfully added.
class TaskSuccessState extends TaskState {
  const TaskSuccessState();
}

/// State emitted when an error occurs while adding a task.
class TaskErrorState extends TaskState {
  const TaskErrorState();
}
