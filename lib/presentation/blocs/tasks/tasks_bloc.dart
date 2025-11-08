import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_space_scutum_test/domain/entities/enums/task_category.dart';
import 'package:flutter_space_scutum_test/domain/entities/enums/task_status.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:flutter_space_scutum_test/domain/usecases/delete_task_by_id_usecase.dart';
import 'package:flutter_space_scutum_test/domain/usecases/get_tasks_usecase.dart';
import 'package:flutter_space_scutum_test/domain/usecases/update_task_usecase.dart';
import 'package:injectable/injectable.dart';

part 'tasks_state.dart';
part 'tasks_event.dart';

/// BLoC responsible for managing **the list of tasks**, including:
/// - loading tasks
/// - updating tasks
/// - deleting tasks
/// - filtering by category or status
///
/// This BLoC represents the state of the entire tasks screen.
@Injectable()
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc(this._deleteTaskByIdUseCase, this._getTasksUseCase, this._updateTaskUseCase)
    : super(const TasksInitialState()) {
    on<TasksLoadEvent>(_onLoadTasks);
    on<TasksDeleteTaskEvent>(_onDeleteTask);
    on<TasksUpdateTaskEvent>(_onUpdateTask);
    on<TasksSetStatusFilterEvent>(_onSetStatusFilter);
    on<TasksSetCategoryFilterEvent>(_onSetCategoryFilter);
  }

  /// Use case responsible for deleting a task by ID.
  final DeleteTaskByIdUseCase _deleteTaskByIdUseCase;

  /// Use case responsible for retrieving the full list of tasks.
  final GetTasksUseCase _getTasksUseCase;

  /// Use case responsible for updating an existing task.
  final UpdateTaskUseCase _updateTaskUseCase;

  /// Handles loading and filtering tasks.
  ///
  /// Steps:
  /// 1. Emit loading state with current filters and cached tasks.
  /// 2. Load fresh tasks via use case.
  /// 3. Apply filters (category + status).
  /// 4. Emit loaded state with filtered results.
  Future<void> _onLoadTasks(TasksLoadEvent event, Emitter<TasksState> emit) async {
    try {
      emit(
        TasksLoadingState(tasks: state.tasks, filterStatus: state.filterStatus, filterCategory: state.filterCategory),
      );

      final tasks = await _getTasksUseCase.execute();
      List<TaskDomain> tasksResult = tasks;

      // Filter by category
      if (state.filterCategory != TaskCategory.all) {
        tasksResult = tasksResult.where((t) => t.category == state.filterCategory).toList();
      }

      // Filter by completion status
      switch (state.filterStatus) {
        case TaskStatus.notCompleted:
          tasksResult = tasksResult.where((t) => !t.isCompleted).toList();
        case TaskStatus.completed:
          tasksResult = tasksResult.where((t) => t.isCompleted).toList();
        case TaskStatus.all:
      }

      emit(
        TasksLoadedState(tasks: tasksResult, filterStatus: state.filterStatus, filterCategory: state.filterCategory),
      );
    } catch (_) {
      emit(TasksErrorState(tasks: state.tasks, filterStatus: state.filterStatus, filterCategory: state.filterCategory));
    }
  }

  /// Handles deleting a task.
  ///
  /// After deletion, triggers a reload of the tasks list.
  Future<void> _onDeleteTask(TasksDeleteTaskEvent event, Emitter<TasksState> emit) async {
    try {
      emit(
        TasksLoadingState(tasks: state.tasks, filterStatus: state.filterStatus, filterCategory: state.filterCategory),
      );

      await _deleteTaskByIdUseCase.call(event.id);

      add(const TasksLoadEvent());
    } catch (_) {
      emit(TasksErrorState(tasks: state.tasks, filterStatus: state.filterStatus, filterCategory: state.filterCategory));
    }
  }

  /// Handles updating a task.
  ///
  /// After update, reloads the tasks list to keep UI consistent.
  Future<void> _onUpdateTask(TasksUpdateTaskEvent event, Emitter<TasksState> emit) async {
    try {
      emit(
        TasksLoadingState(tasks: state.tasks, filterStatus: state.filterStatus, filterCategory: state.filterCategory),
      );

      await _updateTaskUseCase(event.task);

      add(const TasksLoadEvent());
    } catch (_) {
      emit(TasksErrorState(tasks: state.tasks, filterStatus: state.filterStatus, filterCategory: state.filterCategory));
    }
  }

  /// Sets a new status filter (all / completed / not completed)
  /// and reloads tasks.
  Future<void> _onSetStatusFilter(TasksSetStatusFilterEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadedState(tasks: state.tasks, filterStatus: event.status, filterCategory: state.filterCategory));

    add(const TasksLoadEvent());
  }

  /// Sets a new category filter and reloads tasks.
  Future<void> _onSetCategoryFilter(TasksSetCategoryFilterEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadedState(tasks: state.tasks, filterStatus: state.filterStatus, filterCategory: event.category));

    add(const TasksLoadEvent());
  }
}
