import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:flutter_space_scutum_test/domain/usecases/add_task_usecase.dart';
import 'package:injectable/injectable.dart';

part 'task_state.dart';
part 'task_event.dart';

/// BLoC responsible for handling actions related to a **single task**.
///
/// Currently supports:
/// - adding a new task
///
/// This BLoC emits:
/// - [TaskInitialState]
/// - [TaskLoadingState]
/// - [TaskSuccessState]
/// - [TaskErrorState]
///
/// It uses the [AddTaskUseCase] to keep the business logic separate
/// from the presentation layer.
@Injectable()
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(this._addTaskUseCase) : super(const TaskInitialState()) {
    on<TaskAddEvent>(_onAddTask);
  }

  /// Use case responsible for adding a new task.
  final AddTaskUseCase _addTaskUseCase;

  /// Handles the [TaskAddEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the use case to add the task.
  /// 3. Emit success on completion.
  /// 4. Emit error if any exception occurs.
  Future<void> _onAddTask(TaskAddEvent event, Emitter<TaskState> emit) async {
    try {
      emit(const TaskLoadingState());

      await _addTaskUseCase.call(event.task);

      emit(const TaskSuccessState());
    } catch (_) {
      emit(const TaskErrorState());
    }
  }
}
