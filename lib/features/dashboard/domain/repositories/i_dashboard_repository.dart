import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_stats_entity.dart';

abstract class IDashboardRepository {
  Future<Either<Failure, DashboardStatsEntity>> getDashboardStats(String employeeId);
}
