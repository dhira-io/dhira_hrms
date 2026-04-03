import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final ITaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call({required int start, required int length}) async {
    return await repository.getTasks(start: start, length: length);
  }
}
