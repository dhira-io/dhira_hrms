import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class GetWeekWiseTimesheetUseCase {
  final ITimesheetRepository repository;

  GetWeekWiseTimesheetUseCase(this.repository);

  Future<Either<Failure, List<ProjectAssignmentEntity>>> call({
    required int month,
    required int year,
  }) async {
    return await repository.fetchWeekWiseDetails(month: month, year: year);
  }
}
