import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/approvals_access_entity.dart';
import '../../domain/entities/approvals_summary_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/repositories/i_approvals_repository.dart';
import '../datasources/approvals_remote_datasource.dart';
import '../../leaveapproval/domain/repositories/i_leave_approval_repository.dart';
import '../../timesheetapproval/domain/repositories/i_timesheet_approval_repository.dart';

class ApprovalsRepositoryImpl implements IApprovalsRepository {
  final ApprovalsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final ILeaveApprovalRepository leaveApprovalRepository;
  final ITimesheetApprovalRepository timesheetApprovalRepository;

  ApprovalsRepositoryImpl(
    this.remoteDataSource,
    this.networkInfo,
    this.leaveApprovalRepository,
    this.timesheetApprovalRepository,
  );

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
  Future<Either<Failure, List<ApprovalRequestEntity>>> getPendingRequests(
      ApprovalType type,
      ApprovalCategory category,
      ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        // We keep the generic logic here to not change the flow of using ApprovalRequestEntity
        final models = await remoteDataSource.getPendingRequests(
          type,
          category: category,
        );

        final entities = models.map((model) => model.toEntity(type)).toList();

        return Right(entities);
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
          '<div class="ql-editor read-mode"><p>$content</p></div>',
        );
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> submitLeaveWorkflowAction(String leaveApplicationName, String action) async {
    return leaveApprovalRepository.submitLeaveWorkflowAction(leaveApplicationName, action);
  }

  @override
  Future<Either<Failure, void>> submitAttendanceWorkflowAction(String attendanceRequestName, String action) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.submitAttendanceWorkflowAction(attendanceRequestName, action);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> submitTimesheetWorkflowAction(String timesheetName, String action) async {
    return timesheetApprovalRepository.submitTimesheetWorkflowAction(timesheetName, action);
  }

  @override
  Future<Either<Failure, void>> submitCompOffWorkflowAction(String compOffRequestName, String action) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.submitCompOffWorkflowAction(compOffRequestName, action);
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
