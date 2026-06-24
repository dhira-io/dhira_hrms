import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class CreateTimesheetUseCase implements UseCase<String, CreateTimesheetParams> {
  final ITimesheetRepository repository;

  CreateTimesheetUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(CreateTimesheetParams params) async {
    return await repository.createTimesheet(
      employee: params.employee,
      department: params.department,
      approver: params.approver,
      fromDate: params.fromDate,
      toDate: params.toDate,
      assignments: params.assignments,
      docStatus: params.docStatus,
    );
  }
}

class CreateTimesheetParams {
  final String employee;
  final String department;
  final String approver;
  final String fromDate;
  final String toDate;
  final List<ProjectAssignmentEntity> assignments;
  final int docStatus;

  const CreateTimesheetParams({
    required this.employee,
    required this.department,
    required this.approver,
    required this.fromDate,
    required this.toDate,
    required this.assignments,
    required this.docStatus,
  });
}
