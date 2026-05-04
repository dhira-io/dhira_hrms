import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/leave_repository.dart';

class UpdateLeaveUseCase {
  final ILeaveRepository repository;

  UpdateLeaveUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String leaveId,
    required String employeeId,
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? workflowState,
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
    );
  }
}
