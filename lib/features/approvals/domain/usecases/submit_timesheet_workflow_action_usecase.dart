import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_approvals_repository.dart';

class SubmitTimesheetWorkflowActionUseCase {
  final IApprovalsRepository repository;

  SubmitTimesheetWorkflowActionUseCase(this.repository);

  Future<Either<Failure, void>> call(String timesheetName, String action) async {
    return await repository.submitTimesheetWorkflowAction(timesheetName, action);
  }
}
