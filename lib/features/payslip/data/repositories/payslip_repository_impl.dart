import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/payslip_entities.dart';
import '../../domain/repositories/i_payslip_repository.dart';
import '../datasources/payslip_remote_datasource.dart';

class PayslipRepositoryImpl implements IPayslipRepository {
  final PayslipRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PayslipRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PayslipEntity>>> getPayslips({
    required String employeeId,
    required int start,
    required int limit,
  }) async {
    return await networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.fetchPayslips(
          employeeId: employeeId,
          start: start,
          limit: limit,
        );
        return Right(models.map((m) => m.toEntity()).toList());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, PayslipDetailEntity>> getPayslipDetail({
    required String name,
  }) async {
    return await networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.fetchPayslipDetail(name: name);
        return Right(model.toEntity());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    });
  }
}
