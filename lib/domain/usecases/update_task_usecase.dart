import 'package:flutter_space_scutum_test/core/usecase/usecase.dart';
import 'package:flutter_space_scutum_test/data/repository/task_repository.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:injectable/injectable.dart';

/// Use case responsible for updating an existing task.
///
/// Follows the immutable entity pattern, where updates are provided
/// via a modified [TaskDomain] instance (usually through copyWith).
@Injectable()
class UpdateTaskUseCase extends UseCase<void, TaskDomain> {
  const UpdateTaskUseCase(this._repository);

  final TaskRepository _repository;

  @override
  Future<void> call(TaskDomain params) => _repository.updateTask(task: params);
}
