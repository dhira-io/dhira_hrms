import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';

class MockTaskRepositoryImpl implements ITaskRepository {
  final List<TaskEntity> _mockTasks = List.generate(
    50,
    (index) => TaskEntity(
      id: 'TASK-${index + 1}',
      title: 'Mock Task Title ${index + 1}',
      description: 'This is a description for the mock task ${index + 1}. Please review and complete.',
      status: index % 3 == 0 ? 'Completed' : (index % 2 == 0 ? 'In Progress' : 'Pending'),
      dueDate: DateTime.now().add(Duration(days: index)),
      priority: index % 5 == 0 ? 'High' : (index % 3 == 0 ? 'Medium' : 'Low'),
    ),
  );

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks({
    required int start,
    required int length,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      if (start >= _mockTasks.length) {
        return const Right([]);
      }
      final end = (start + length < _mockTasks.length) ? start + length : _mockTasks.length;
      final paginatedList = _mockTasks.sublist(start, end);
      return Right(paginatedList);
    } catch (e) {
      return const Left(ServerFailure("Failed to fetch mock tasks"));
    }
  }
}
