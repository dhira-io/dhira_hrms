import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_timesheet_approval_repository.dart';

class SubmitTimesheetActionUseCase {
  final ITimesheetApprovalRepository repository;

  SubmitTimesheetActionUseCase(this.repository);

  Future<Either<Failure, void>> call(String timesheetName, String action) async {
    return await repository.submitTimesheetWorkflowAction(timesheetName, action);
  }
}
