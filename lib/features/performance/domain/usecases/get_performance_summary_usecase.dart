import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/performance_entity.dart';
import '../repositories/i_performance_repository.dart';

class GetPerformanceSummaryUseCase {
  final IPerformanceRepository repository;

  GetPerformanceSummaryUseCase(this.repository);

  Future<Either<Failure, PerformanceEntity>> call(String employeeId) {
    return repository.getPerformanceSummary(employeeId);
  }
}
