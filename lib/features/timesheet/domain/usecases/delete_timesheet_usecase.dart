import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/timesheet_repository.dart';

class DeleteTimesheetUseCase {
  final ITimesheetRepository repository;

  DeleteTimesheetUseCase(this.repository);

  Future<Either<Failure, void>> call({required String timesheetName}) {
    return repository.deleteTimesheet(timesheetName: timesheetName);
  }
}
