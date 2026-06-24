import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/timesheet_overview_entity.dart';
import '../repositories/timesheet_repository.dart';

class GetTimesheetOverviewUseCase
    implements UseCase<TimesheetOverviewEntity, GetTimesheetOverviewParams> {
  final ITimesheetRepository repository;

  GetTimesheetOverviewUseCase(this.repository);

  @override
  Future<Either<Failure, TimesheetOverviewEntity>> call(
    GetTimesheetOverviewParams params,
  ) async {
    return await repository.fetchOverview(
      month: params.month,
      year: params.year,
    );
  }
}

class GetTimesheetOverviewParams {
  final int month;
  final int year;

  const GetTimesheetOverviewParams({required this.month, required this.year});
}
