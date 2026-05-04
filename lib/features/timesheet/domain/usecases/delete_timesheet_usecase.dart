import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/timesheet_repository.dart';

class DeleteTimesheetUseCase {
  final ITimesheetRepository repository;

  DeleteTimesheetUseCase(this.repository);

  Future<Either<Failure, bool>> call(String timesheetId) async {
    return await repository.deleteTimesheet(timesheetId);
  }
}
