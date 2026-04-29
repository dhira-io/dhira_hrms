import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/performance_entity.dart';
import '../../domain/repositories/i_performance_repository.dart';
import '../datasources/performance_remote_datasource.dart';
import '../models/performance_model.dart';

class PerformanceRepositoryImpl implements IPerformanceRepository {
  final IPerformanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PerformanceRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, PerformanceEntity>> getPerformanceSummary(
    String employeeId,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getPerformanceSummary(employeeId);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
