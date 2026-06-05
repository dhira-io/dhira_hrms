import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/resume_entity.dart';
import '../repositories/profile_repository.dart';

class GetSubSkillsUseCase {
  final IProfileRepository repository;

  GetSubSkillsUseCase(this.repository);

  Future<Either<Failure, List<SubSkillEntity>>> call(String skillName) {
    return repository.getSubSkills(skillName);
  }
}
