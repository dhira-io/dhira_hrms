import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/timesheet_repository.dart';

class DeleteTimesheetUseCase implements UseCase<void, DeleteTimesheetParams> {
  final ITimesheetRepository repository;

  DeleteTimesheetUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTimesheetParams params) async {
    return await repository.deleteTimesheet(timesheetName: params.timesheetName);
  }
}

class DeleteTimesheetParams {
  final String timesheetName;

  const DeleteTimesheetParams({required this.timesheetName});
}
