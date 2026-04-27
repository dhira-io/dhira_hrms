import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class CreateTimesheetUseCase {
  final ITimesheetRepository repository;

  CreateTimesheetUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignmentEntity> assignments,
    required int docStatus,
  }) async {
    return await repository.createTimesheet(
      employee: employee,
      department: department,
      approver: approver,
      fromDate: fromDate,
      toDate: toDate,
      assignments: assignments,
      docStatus: docStatus,
    );
  }
}
