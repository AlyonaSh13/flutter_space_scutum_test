import 'package:flutter_space_scutum_test/core/usecase/usecase.dart';
import 'package:flutter_space_scutum_test/data/repository/task_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case responsible for deleting a task by its unique ID.
///
/// This encapsulates the deletion logic and ensures
/// the domain layer communicates only through the repository abstraction.
@Injectable()
class DeleteTaskByIdUseCase extends UseCase<void, String> {
  const DeleteTaskByIdUseCase(this._repository);

  final TaskRepository _repository;

  @override
  Future<void> call(String params) => _repository.deleteTaskById(id: params);
}
