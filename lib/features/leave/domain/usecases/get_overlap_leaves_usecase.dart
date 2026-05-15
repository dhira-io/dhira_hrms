import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/overlap_leave_entity.dart';
import '../repositories/leave_repository.dart';

class GetOverlapLeavesUseCase {
  final ILeaveRepository repository;

  GetOverlapLeavesUseCase(this.repository);

  Future<Either<Failure, List<OverlapLeaveEntity>>> call({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) {
    return repository.getApprovedLeavesSameProject(
      employeeId: employeeId,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
