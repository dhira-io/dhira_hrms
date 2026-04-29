import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/performance_entity.dart';

abstract class IPerformanceRepository {
  Future<Either<Failure, PerformanceEntity>> getPerformanceSummary(String employeeId);
}
