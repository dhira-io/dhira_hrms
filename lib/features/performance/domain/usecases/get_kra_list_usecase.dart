import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class GetKraListUseCase {
  final IPerformanceRepository repository;

  GetKraListUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(String jobFamily) async {
    return await repository.getKraList(jobFamily);
  }
}
