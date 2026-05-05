import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_timesheet_approval_repository.dart';

class GetEmployeesUseCase {
  final ITimesheetApprovalRepository repository;

  GetEmployeesUseCase(this.repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> call() async {
    return await repository.fetchEmployees();
  }
}
