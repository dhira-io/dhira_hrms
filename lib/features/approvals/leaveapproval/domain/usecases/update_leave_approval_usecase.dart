import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_leave_approval_repository.dart';

class UpdateLeaveApprovalUseCase {
  final ILeaveApprovalRepository repository;

  UpdateLeaveApprovalUseCase(this.repository);

  Future<Either<Failure, bool>> call({
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
    return await repository.updateLeaveApplication(
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
  }
}
