import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class GetWeekWiseTimesheetUseCase
    implements UseCase<List<ProjectAssignmentEntity>, GetWeekWiseTimesheetParams> {
  final ITimesheetRepository repository;

  GetWeekWiseTimesheetUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProjectAssignmentEntity>>> call(
    GetWeekWiseTimesheetParams params,
  ) async {
    return await repository.fetchWeekWiseDetails(
      month: params.month,
      year: params.year,
    );
  }
}

class GetWeekWiseTimesheetParams {
  final int month;
  final int year;

  const GetWeekWiseTimesheetParams({required this.month, required this.year});
}
