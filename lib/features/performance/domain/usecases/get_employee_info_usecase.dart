import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class GetEmployeeInfoUseCase {
  final IPerformanceRepository repository;

  GetEmployeeInfoUseCase(this.repository);

  Future<Either<Failure, Map<String, String>>> call(String employeeId) {
    return repository.getEmployeeInfo(employeeId);
  }
}
