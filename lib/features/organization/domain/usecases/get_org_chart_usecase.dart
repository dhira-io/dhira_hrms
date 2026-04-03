import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/org_chart_node_entity.dart';
import '../repositories/organization_repository.dart';

class GetOrgChartUseCase {
  final IOrganizationRepository repository;

  GetOrgChartUseCase(this.repository);

  Future<Either<Failure, OrgChartNodeEntity>> call() async {
    return await repository.getOrganizationChart();
  }
}
