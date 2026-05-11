import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/data/datasources/leave_approval_remote_datasource.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/repositories/i_leave_approval_repository.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_balance_entity.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_statistics_entity.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_type_entity.dart';
import 'package:dhira_hrms/features/leave/domain/entities/overlap_leave_entity.dart';
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

  @override
  Future<Either<Failure, List<LeaveTypeEntity>>> fetchLeaveTypes() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.fetchLeaveTypes();
        return Right(models.map((m) => m.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> updateLeaveApplication({
    required String leaveId,
    String? employeeId,
    String? employeeName,
    String? leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? workflowState,
    String? attachment,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.updateLeaveApplication(
          leaveId: leaveId,
          employeeId: employeeId,
          employeeName: employeeName,
          leaveType: leaveType,
          fromDate: fromDate,
          toDate: toDate,
          reason: reason,
          halfDay: halfDay,
          halfDayDate: halfDayDate,
          halfDaySegment: halfDaySegment,
          totalleavedays: totalleavedays,
          workflowState: workflowState,
          attachment: attachment,
        );
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, LeaveBalanceEntity>> getLeaveBalance(String employeeId, String todayDate, String gender) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getLeaveBalance(employeeId, todayDate, gender);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, LeaveStatisticsEntity>> getLeaveStatistics({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getLeaveStatistics(employeeId, fromDate, toDate);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<OverlapLeaveEntity>>> getOverlapLeaves({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getOverlapLeaves(employeeId, fromDate, toDate);
        return Right(models.map((m) => m.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, String>> uploadFile({
    required String filePath,
    required String fileName,
    required String employeeId,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final fileUrl = await remoteDataSource.uploadFile(filePath, fileName, employeeId);
        return Right(fileUrl);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
