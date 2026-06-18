import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class SearchSkillsUseCase {
  final IProfileRepository repository;

  SearchSkillsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(String query) {
    return repository.searchSkills(query);
  }
}
