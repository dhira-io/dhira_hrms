import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class GetSingleTimesheetUseCase {
  final ITimesheetRepository repository;

  GetSingleTimesheetUseCase(this.repository);

  Future<Either<Failure, TimesheetEntity>> call(String timesheetId) async {
    return await repository.fetchSingleTimesheet(timesheetId);
  }
}
