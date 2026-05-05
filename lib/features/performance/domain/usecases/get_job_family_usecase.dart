import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class GetJobFamilyUseCase {
  final IPerformanceRepository repository;

  GetJobFamilyUseCase(this.repository);

  Future<Either<Failure, String?>> call(String employeeId) {
    return repository.getJobFamily(employeeId);
  }
}
