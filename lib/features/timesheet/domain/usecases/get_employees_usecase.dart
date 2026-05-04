import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/timesheet_repository.dart';

class GetEmployeesUseCase {
  final ITimesheetRepository repository;

  GetEmployeesUseCase(this.repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> call() async {
    return await repository.fetchEmployees();
  }
}
