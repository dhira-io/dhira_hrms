import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/exceptions.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/network/network_info.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';
import 'package:dhira_hrms/features/policy/domain/repositories/i_policy_repository.dart';
import 'package:dhira_hrms/features/policy/data/datasources/policy_remote_datasource.dart';
import 'package:dhira_hrms/features/policy/data/models/policy_model.dart';
import 'package:dhira_hrms/features/policy/data/models/policy_pdf_model.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_pdf_entity.dart';

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
      }
    });
  }
}
