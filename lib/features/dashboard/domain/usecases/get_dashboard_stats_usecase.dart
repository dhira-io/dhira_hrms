import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_dashboard_repository.dart';
import '../entities/dashboard_stats_entity.dart';

class GetDashboardStatsUseCase {
  final IDashboardRepository repository;

  GetDashboardStatsUseCase(this.repository);

  Future<Either<Failure, DashboardStatsEntity>> call(String employeeId) async {
    return await repository.getDashboardStats(employeeId);
  }
}
