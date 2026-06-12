import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class SearchProjectsUseCase {
  final IProfileRepository repository;

  SearchProjectsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(String query) {
    return repository.searchProjects(query);
  }
}
