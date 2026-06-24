import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class UpdateTimesheetUseCase implements UseCase<String, UpdateTimesheetParams> {
  final ITimesheetRepository repository;

  UpdateTimesheetUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(UpdateTimesheetParams params) async {
    return await repository.updateTimesheet(
      name: params.name,
      employee: params.employee,
      department: params.department,
      approver: params.approver,
      approved: params.approved,
      fromDate: params.fromDate,
      toDate: params.toDate,
      hoursTotal: params.hoursTotal,
      assignments: params.assignments,
    );
  }
}

class UpdateTimesheetParams {
  final String name;
  final String employee;
  final String department;
  final String approver;
  final int approved;
  final String fromDate;
  final String toDate;
  final double hoursTotal;
  final List<ProjectAssignmentEntity> assignments;

  const UpdateTimesheetParams({
    required this.name,
    required this.employee,
    required this.department,
    required this.approver,
    required this.approved,
    required this.fromDate,
    required this.toDate,
    required this.hoursTotal,
    required this.assignments,
  });
}
