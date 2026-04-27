import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/timesheet_repository.dart';

class DeleteTimesheetEntryUseCase {
  final ITimesheetRepository repository;

  DeleteTimesheetEntryUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String name,
    required String parent,
    required String date,
  }) async {
    return await repository.deleteTimesheetEntry(
      name: name,
      parent: parent,
      date: date,
    );
  }
}
