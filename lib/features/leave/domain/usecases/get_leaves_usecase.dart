import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/leave_entities.dart';
import '../repositories/leave_repository.dart';

class GetLeavesUseCase {
  final ILeaveRepository repository;

  GetLeavesUseCase(this.repository);

  Future<Either<Failure, List<LeaveEntity>>> call({
    required int start,
    required int length,
  }) async {
    return await repository.fetchLeaveApplicationsList(
      start: start,
      length: length,
    );
  }
}
