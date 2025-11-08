import 'package:flutter_space_scutum_test/core/usecase/usecase.dart';
import 'package:flutter_space_scutum_test/data/repository/task_repository.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:injectable/injectable.dart';

/// Use case responsible for retrieving all tasks.
///
/// Since this operation does not require parameters,
/// it extends [ExecuteUseCase].
@Injectable()
class GetTasksUseCase extends ExecuteUseCase<List<TaskDomain>> {
  const GetTasksUseCase(this._repository);

  final TaskRepository _repository;

  @override
  Future<List<TaskDomain>> execute() => _repository.getTasks();
}
