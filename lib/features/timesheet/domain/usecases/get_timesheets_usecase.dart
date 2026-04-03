import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class GetTimesheetsUseCase {
  final ITimesheetRepository repository;

  GetTimesheetsUseCase(this.repository);

  Future<Either<Failure, List<TimesheetEntity>>> call({
    required int start,
    required int limit,
  }) async {
    return await repository.fetchTimesheets(start: start, limit: limit);
  }
}
