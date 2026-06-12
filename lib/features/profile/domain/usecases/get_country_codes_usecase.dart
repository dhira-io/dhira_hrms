import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country_code_entity.dart';
import '../repositories/profile_repository.dart';

class GetCountryCodesUseCase implements UseCase<List<CountryCodeEntity>, NoParams> {
  final IProfileRepository repository;

  GetCountryCodesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CountryCodeEntity>>> call(NoParams params) async {
    return await repository.getCountryCodes();
  }
}
