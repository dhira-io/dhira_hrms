import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/policy_entity.dart';
import '../../domain/repositories/i_policy_repository.dart';
import '../datasources/policy_remote_datasource.dart';
import '../models/policy_model.dart';
import '../models/policy_pdf_model.dart';
import '../../domain/entities/policy_pdf_entity.dart';

class PolicyRepositoryImpl implements IPolicyRepository {
  final IPolicyRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PolicyRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PolicyEntity>>> getPolicies() async {
    return await networkInfo.connectedAndRun<List<PolicyEntity>>(() async {
      try {
        final models = await remoteDataSource.getPolicies();
        return Right(models.map((e) => e.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, PolicyPdfEntity>> getPolicyPdf(String fileUrl) async {
    return await networkInfo.connectedAndRun<PolicyPdfEntity>(() async {
      try {
        final model = await remoteDataSource.getPolicyPdf(fileUrl);
        return Right(model.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    });
  }
}
