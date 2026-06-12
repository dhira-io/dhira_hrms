import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class SearchLocationsUseCase {
  final IProfileRepository repository;

  SearchLocationsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(String query) async {
    return await repository.searchLocations(query);
  }
}
