import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/approvals_access_entity.dart';
import '../../domain/entities/approvals_summary_entity.dart';
import '../../domain/repositories/i_approvals_repository.dart';
import '../datasources/approvals_remote_datasource.dart';

class ApprovalsRepositoryImpl implements IApprovalsRepository {
  final ApprovalsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ApprovalsRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ApprovalsAccessEntity>> getApprovalsAccess() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getApprovalsAccess();
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, ApprovalsSummaryEntity>> getApprovalsSummary() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getApprovalsSummary();
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }


  @override
  Future<Either<Failure, List<ApprovalRequestEntity>>> getPendingRequests(ApprovalType type) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getPendingRequests(type);
        // Mapping the list of models to entities as per Clean Architecture
        return Right(models.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }


}
