import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';

abstract class ITaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks({
    required int start,
    required int length,
  });
}
