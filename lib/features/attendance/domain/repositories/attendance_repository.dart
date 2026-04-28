import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../entities/holiday_list_leave_policy_entity.dart';

abstract class IAttendanceRepository {
  Future<Either<Failure, AttendanceStatusEntity>> getCheckinStatus(String empid);
  Future<Either<Failure, AttendanceStatusEntity>> punchIn(String empid);
  Future<Either<Failure, AttendanceStatusEntity>> punchOut(String empid);
  Future<Either<Failure, List<AttendanceLogEntity>>> getAttendanceLogs(String empid);
  Future<Either<Failure, Map<String, String>>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  });
  Future<Either<Failure, AttendanceStatusEntity>> startBreak(String empid);
  Future<Either<Failure, AttendanceStatusEntity>> endBreak(String empid);
  Future<Either<Failure, AttendanceWorkDurationsEntity>> getWorkDurations(
      String empid);
  Future<Either<Failure, AttendanceMonthSummaryEntity>> getAttendanceMonthSummary({
    required String employee,
    required int month,
    required int year,
  });
  Future<Either<Failure, List<LeaveHistoryEntity>>> getLeaveHistory(
      String employee);
  Future<Either<Failure, LeaveDetailsEntity>> getLeaveDetails({
    required String employee,
    required String date,
  });
  Future<Either<Failure, List<TeamLeaveEntity>>> getTeamLeaves({
    required String employee,
    required String fromDate,
    required String toDate,
  });
  Future<Either<Failure, HolidayListLeavePolicyEntity>>
      getHolidayListLeavePolicy(String employee);
}
