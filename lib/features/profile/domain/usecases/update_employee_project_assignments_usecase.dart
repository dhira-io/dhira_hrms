import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class UpdateEmployeeProjectAssignmentsUseCase {
  final IProfileRepository repository;

  UpdateEmployeeProjectAssignmentsUseCase(this.repository);

  Future<Either<Failure, void>> call(String employeeId, String assignmentsJson) async {
    return await repository.updateEmployeeProjectAssignments(employeeId, assignmentsJson);
  }
}
