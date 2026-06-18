import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class SaveSubSkillsForSkillParams {
  final String employeeId;
  final String skillName;
  final String subSkillsJson;

  SaveSubSkillsForSkillParams({
    required this.employeeId,
    required this.skillName,
    required this.subSkillsJson,
  });
}

class SaveSubSkillsForSkillUseCase {
  final IProfileRepository repository;

  SaveSubSkillsForSkillUseCase(this.repository);

  Future<Either<Failure, void>> call(SaveSubSkillsForSkillParams params) {
    return repository.saveSubSkillsForSkill(
      params.employeeId,
      params.skillName,
      params.subSkillsJson,
    );
  }
}
