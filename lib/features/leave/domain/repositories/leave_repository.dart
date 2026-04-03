import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/leave_entities.dart';

abstract class ILeaveRepository {
  Future<Either<Failure, List<LeaveEntity>>> fetchLeaveApplicationsList({
    required int start,
    required int length,
  });

  Future<Either<Failure, List<LeaveTypeEntity>>> fetchLeaveTypes();

  Future<Either<Failure, bool>> submitLeaveApplication({
    required String employeeId,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  });

  Future<Either<Failure, bool>> updateLeaveApplication({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  });

  Future<Either<Failure, bool>> deleteLeaveApplication(String name);

  Future<Either<Failure, bool>> cancelLeaveApplication(String name);

  Future<Either<Failure, LeaveBalanceEntity>> getLeaveBalance(String employeeId, String todayDate);
}
