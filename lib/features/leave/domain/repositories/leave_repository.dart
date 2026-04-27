import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/leave_entities.dart';
import '../entities/overlap_leave_entity.dart';

abstract class ILeaveRepository {
  Future<Either<Failure, List<LeaveTypeEntity>>> fetchLeaveTypes();

  Future<Either<Failure, bool>> submitLeaveApplication({
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
  });

  Future<Either<Failure, bool>> updateLeaveApplication({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
  });

  Future<Either<Failure, LeaveBalanceEntity>> getLeaveBalance(String employeeId, String todayDate, String gender);

  Future<Either<Failure, LeaveStatisticsEntity>> getLeaveStatistics({
    required String employeeId,
    required String fromDate,
    required String toDate,
  });

  Future<Either<Failure, List<OverlapLeaveEntity>>> getApprovedLeavesSameProject({
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
