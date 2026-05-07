import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/leave/domain/entities/overlap_leave_entity.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_leave_approval_repository.dart';

class GetOverlapLeavesApprovalUseCase {
  final ILeaveApprovalRepository repository;

  GetOverlapLeavesApprovalUseCase(this.repository);

  Future<Either<Failure, List<OverlapLeaveEntity>>> call({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) async {
    return await repository.getOverlapLeaves(
      employeeId: employeeId,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
