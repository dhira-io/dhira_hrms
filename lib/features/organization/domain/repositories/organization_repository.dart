import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/organization_entity.dart';
import '../entities/org_chart_node_entity.dart';

abstract class IOrganizationRepository {
  Future<Either<Failure, List<OrganizationEntity>>> getOrganizations();
  Future<Either<Failure, OrgChartNodeEntity>> getOrganizationChart();
}
