import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/approval_request_entity.dart';
import '../repositories/i_leave_approval_repository.dart';

class GetPendingLeavesUseCase {
  final ILeaveApprovalRepository repository;

  GetPendingLeavesUseCase(this.repository);

  Future<Either<Failure, List<ApprovalRequestEntity>>> call(ApprovalCategory category) async {
    return await repository.getPendingLeaves(category);
  }
}
