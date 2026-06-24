import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/timesheet_repository.dart';

class DeleteTimesheetEntryUseCase
    implements UseCase<void, DeleteTimesheetEntryParams> {
  final ITimesheetRepository repository;

  DeleteTimesheetEntryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTimesheetEntryParams params) async {
    return await repository.deleteTimesheetEntry(
      name: params.name,
      parent: params.parent,
      date: params.date,
    );
  }
}

class DeleteTimesheetEntryParams {
  final String name;
  final String parent;
  final String date;

  const DeleteTimesheetEntryParams({
    required this.name,
    required this.parent,
    required this.date,
  });
}
