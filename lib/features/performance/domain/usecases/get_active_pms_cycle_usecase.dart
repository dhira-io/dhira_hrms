import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/pms_cycle_entity.dart';
import '../repositories/i_performance_repository.dart';

class GetActivePmsCycleUseCase {
  final IPerformanceRepository repository;

  GetActivePmsCycleUseCase(this.repository);

  Future<Either<Failure, PmsCycleEntity?>> call() {
    return repository.getActivePmsCycle();
  }
}
