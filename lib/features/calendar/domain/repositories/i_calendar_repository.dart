import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/team_leave_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/attendance_punch_summary_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/leave_history_entity.dart';

abstract class ICalendarRepository {
  Future<Either<Failure, Map<String, String>>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  });

  Future<Either<Failure, CalendarSummaryEntity>> getCalendarSummary({
    required String employee,
    required int month,
    required int year,
  });

  Future<Either<Failure, List<TeamLeaveEntity>>> getTeamLeaves({
    required String employee,
    required String fromDate,
    required String toDate,
  });

  Future<Either<Failure, AttendancePunchSummaryEntity>> getAttendancePunchSummary({
    required String attendanceDate,
  });

  Future<Either<Failure, List<LeaveHistoryEntity>>> getLeaveHistory({
    required String employee,
    int limitStart = 0,
    int limitPageLength = 100,
  });
}
