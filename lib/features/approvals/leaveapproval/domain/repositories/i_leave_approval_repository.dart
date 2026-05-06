import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_balance_entity.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_statistics_entity.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_type_entity.dart';
import 'package:dhira_hrms/features/leave/domain/entities/overlap_leave_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/approval_request_entity.dart';
import '../../../domain/entities/comment_entity.dart';

abstract class ILeaveApprovalRepository {
  Future<Either<Failure, List<ApprovalRequestEntity>>> getPendingLeaves(ApprovalCategory category);
  Future<Either<Failure, void>> submitLeaveWorkflowAction(String leaveApplicationName, String action);
  Future<Either<Failure, void>> addComment(String referenceDoctype, String referenceName, String content);
  Future<Either<Failure, List<CommentEntity>>> getComments(String doctype, String requestId);
  
  // Leave Management methods for Edit flow
  Future<Either<Failure, List<LeaveTypeEntity>>> fetchLeaveTypes();
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
  });
  Future<Either<Failure, LeaveBalanceEntity>> getLeaveBalance(String employeeId, String todayDate, String gender);
  Future<Either<Failure, LeaveStatisticsEntity>> getLeaveStatistics({
    required String employeeId,
    required String fromDate,
    required String toDate,
  });
  Future<Either<Failure, List<OverlapLeaveEntity>>> getOverlapLeaves({
    required String employeeId,
    required String fromDate,
    required String toDate,
  });
  Future<Either<Failure, String>> uploadFile({
    required String filePath,
    required String fileName,
    required String employeeId,
  });
}
