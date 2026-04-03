import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/organization_entity.dart';
import '../repositories/organization_repository.dart';

class GetOrganizationsUseCase {
  final IOrganizationRepository repository;

  GetOrganizationsUseCase(this.repository);

  Future<Either<Failure, List<OrganizationEntity>>> call() async {
    return await repository.getOrganizations();
  }
}
