import 'package:flutter_space_scutum_test/core/usecase/usecase.dart';
import 'package:flutter_space_scutum_test/data/repository/task_repository.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:injectable/injectable.dart';

/// Use case responsible for adding a new task.
///
/// This class isolates the business rule for task creation
/// and delegates the persistence to the repository layer.
/// It receives a fully constructed [TaskDomain] entity.
@Injectable()
class AddTaskUseCase extends UseCase<void, TaskDomain> {
  const AddTaskUseCase(this._repository);

  /// Repository handling task persistence.
  final TaskRepository _repository;

  @override
  Future<void> call(TaskDomain params) => _repository.addTask(task: params);
}
