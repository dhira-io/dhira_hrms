import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class UpdateSaTrackingUseCase {
  final IPerformanceRepository repository;

  UpdateSaTrackingUseCase(this.repository);

  Future<Either<Failure, void>> call(
    String selfAssessmentId,
    Map<String, dynamic> data,
  ) {
    return repository.updateSaTracking(selfAssessmentId, data);
  }
}
