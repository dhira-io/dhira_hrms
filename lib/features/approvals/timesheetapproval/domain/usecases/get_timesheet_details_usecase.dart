import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/timesheet_approval_entity.dart';
import '../repositories/i_timesheet_approval_repository.dart';

class GetTimesheetDetailsUseCase {
  final ITimesheetApprovalRepository repository;

  GetTimesheetDetailsUseCase(this.repository);

  Future<Either<Failure, TimesheetApprovalEntity>> call(String timesheetId) async {
    return await repository.getTimesheetDetails(timesheetId);
  }
}
