import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/timesheet_repository.dart';

class SyncTimesheetWeekWiseUseCase {
  final ITimesheetRepository repository;

  SyncTimesheetWeekWiseUseCase(this.repository);

  Future<Either<Failure, bool>> call(Map<String, dynamic> payload) async {
    return await repository.syncTimesheetWeekWise(payload);
  }
}
