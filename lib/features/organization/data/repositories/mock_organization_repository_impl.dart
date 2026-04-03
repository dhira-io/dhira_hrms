import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/org_chart_node_entity.dart';
import '../../domain/entities/organization_entity.dart';
import '../../domain/repositories/organization_repository.dart';

class MockOrganizationRepositoryImpl implements IOrganizationRepository {
  @override
  Future<Either<Failure, List<OrganizationEntity>>> getOrganizations() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return const Right([
      OrganizationEntity(id: "1", name: "Dhira HQ", department: "Executive", location: "New York", employeeCount: 15),
      OrganizationEntity(id: "2", name: "Engineering Hub", department: "Engineering", location: "San Francisco", employeeCount: 42),
      OrganizationEntity(id: "3", name: "Design Studio", department: "Design", location: "London", employeeCount: 12),
      OrganizationEntity(id: "4", name: "Customer Success", department: "Support", location: "Remote", employeeCount: 25),
    ]);
  }

  @override
  Future<Either<Failure, OrgChartNodeEntity>> getOrganizationChart() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return const Right(
      OrgChartNodeEntity(
        id: "CEO-1",
        name: "Alice Smith",
        role: "CEO",
        children: [
          OrgChartNodeEntity(
            id: "CTO-1",
            name: "Bob Johnson",
            role: "CTO",
            children: [
              OrgChartNodeEntity(id: "ENG-1", name: "Charlie Brown", role: "Engineering Manager"),
              OrgChartNodeEntity(id: "ENG-2", name: "Diana Prince", role: "Senior Developer"),
            ],
          ),
          OrgChartNodeEntity(
            id: "CFO-1",
            name: "Eve Green",
            role: "CFO",
            children: [
              OrgChartNodeEntity(id: "FIN-1", name: "Frank White", role: "Accountant"),
            ],
          ),
        ],
      )
    );
  }
}
