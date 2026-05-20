import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/sa_tracking_entity.dart';
import '../repositories/i_performance_repository.dart';

class GetSaTrackingUseCase {
  final IPerformanceRepository repository;

  GetSaTrackingUseCase(this.repository);

  Future<Either<Failure, SaTrackingEntity>> call(String selfAssessmentId) {
    return repository.getSaTracking(selfAssessmentId);
  }
}
