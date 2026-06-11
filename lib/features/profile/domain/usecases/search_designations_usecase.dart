import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class SearchDesignationsUseCase {
  final IProfileRepository repository;

  SearchDesignationsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(String query) {
    return repository.searchDesignations(query);
  }
}
