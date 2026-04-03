import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class UpdateTimesheetUseCase {
  final ITimesheetRepository repository;

  UpdateTimesheetUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String name,
    required String employee,
    required String department,
    required String approver,
    required int approved,
    required double hoursTotal,
    required List<ProjectAssignmentEntity> assignments,
  }) async {
    return await repository.updateTimesheet(
      name: name,
      employee: employee,
      department: department,
      approver: approver,
      approved: approved,
      hoursTotal: hoursTotal,
      assignments: assignments,
    );
  }
}
