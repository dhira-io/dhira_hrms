import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_timesheet_approval_repository.dart';

class DeleteTimesheetUseCase {
  final ITimesheetApprovalRepository repository;

  DeleteTimesheetUseCase(this.repository);

  Future<Either<Failure, bool>> call(String timesheetId) async {
    return await repository.deleteTimesheet(timesheetId);
  }
}
