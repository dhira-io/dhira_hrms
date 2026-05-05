import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_leave_approval_repository.dart';

class SubmitLeaveActionUseCase {
  final ILeaveApprovalRepository repository;

  SubmitLeaveActionUseCase(this.repository);

  Future<Either<Failure, void>> call(String leaveApplicationName, String action) async {
    return await repository.submitLeaveWorkflowAction(leaveApplicationName, action);
  }
}
