import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class GetActiveSelfAssessmentIdUseCase {
  final IPerformanceRepository repository;

  GetActiveSelfAssessmentIdUseCase(this.repository);

  Future<Either<Failure, String?>> call(String employeeId) async {
    return await repository.getActiveSelfAssessmentId(employeeId);
  }
}
