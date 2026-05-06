import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class CheckManagerStatusUseCase {
  final IPerformanceRepository repository;

  CheckManagerStatusUseCase(this.repository);

  Future<Either<Failure, bool>> call(String employeeId) async {
    return await repository.checkManagerStatus(employeeId);
  }
}
