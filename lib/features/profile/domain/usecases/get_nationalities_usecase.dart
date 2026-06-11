import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetNationalitiesUseCase implements UseCase<List<String>, NoParams> {
  final IProfileRepository repository;

  GetNationalitiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getNationalities();
  }
}
