import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_approvals_repository.dart';

class SubmitAttendanceWorkflowActionUseCase {
  final IApprovalsRepository repository;

  SubmitAttendanceWorkflowActionUseCase(this.repository);

  Future<Either<Failure, void>> call(String attendanceRequestName, String action) async {
    return await repository.submitAttendanceWorkflowAction(attendanceRequestName, action);
  }
}
