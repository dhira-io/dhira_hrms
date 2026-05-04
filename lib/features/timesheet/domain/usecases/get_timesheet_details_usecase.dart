import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class GetTimesheetDetailsUseCase {
  final ITimesheetRepository repository;

  GetTimesheetDetailsUseCase(this.repository);

  Future<Either<Failure, TimesheetEntity>> call(String timesheetId) async {
    return await repository.getTimesheetDetails(timesheetId);
  }
}
