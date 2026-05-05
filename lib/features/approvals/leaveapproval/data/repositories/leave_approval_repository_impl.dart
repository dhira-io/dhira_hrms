import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/data/datasources/leave_approval_remote_datasource.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/repositories/i_leave_approval_repository.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../../domain/entities/approval_request_entity.dart';
import '../../../domain/entities/approval_type.dart';
import '../../../domain/entities/comment_entity.dart';

class LeaveApprovalRepositoryImpl implements ILeaveApprovalRepository {
  final LeaveApprovalRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LeaveApprovalRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ApprovalRequestEntity>>> getPendingLeaves(ApprovalCategory category) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getPendingLeaves(category);
        final entities = models.map((model) => model.toEntity(ApprovalType.leave)).toList();
        return Right(entities);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> submitLeaveWorkflowAction(String leaveApplicationName, String action) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.submitLeaveWorkflowAction(leaveApplicationName, action);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> addComment(String referenceDoctype, String referenceName, String content) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.addComment(
          referenceDoctype,
          referenceName,
          content,
        );
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(String doctype, String requestId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getComments(doctype, requestId);
        return Right(models.map((m) => m.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
