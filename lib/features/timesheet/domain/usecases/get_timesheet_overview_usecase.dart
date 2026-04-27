import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_overview_entity.dart';
import '../repositories/timesheet_repository.dart';

class GetTimesheetOverviewUseCase {
  final ITimesheetRepository repository;

  GetTimesheetOverviewUseCase(this.repository);

  Future<Either<Failure, TimesheetOverviewEntity>> call({
    required int month,
    required int year,
  }) async {
    return await repository.fetchOverview(month: month, year: year);
  }
}
