import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class UpdateEmployeeSubSkillsParams {
  final String employeeId;
  final String subSkillsJson;

  UpdateEmployeeSubSkillsParams({
    required this.employeeId,
    required this.subSkillsJson,
  });
}

class UpdateEmployeeSubSkillsUseCase {
  final IProfileRepository repository;

  UpdateEmployeeSubSkillsUseCase(this.repository);

  Future<Either<Failure, void>> call(UpdateEmployeeSubSkillsParams params) {
    return repository.updateEmployeeSubSkills(
      params.employeeId,
      params.subSkillsJson,
    );
  }
}
