import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/network/network_info.dart';
import 'package:dhira_hrms/features/calendar/data/datasources/calendar_remote_datasource.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/repositories/i_calendar_repository.dart';

import 'package:dhira_hrms/features/calendar/domain/entities/team_leave_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/attendance_punch_summary_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/leave_history_entity.dart';

class CalendarRepositoryImpl implements ICalendarRepository {
  final ICalendarRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CalendarRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Map<String, String>>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    return networkInfo.executeSafely(() async {
      return await remoteDataSource.getCalendarEvents(
        employee: employee,
        fromDate: fromDate,
        toDate: toDate,
      );
    });
  }

  @override
  Future<Either<Failure, CalendarSummaryEntity>> getCalendarSummary({
    required String employee,
    required int month,
    required int year,
  }) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.getCalendarSummary(
        employee: employee,
        month: month,
        year: year,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<TeamLeaveEntity>>> getTeamLeaves({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    return networkInfo.executeSafely(() async {
      final models = await remoteDataSource.getTeamLeaves(
        employee: employee,
        fromDate: fromDate,
        toDate: toDate,
      );
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, AttendancePunchSummaryEntity>> getAttendancePunchSummary({
    required String attendanceDate,
  }) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.getAttendancePunchSummary(
        attendanceDate: attendanceDate,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<LeaveHistoryEntity>>> getLeaveHistory({
    required String employee,
    int limitStart = 0,
    int limitPageLength = 100,
  }) async {
    return networkInfo.executeSafely(() async {
      final models = await remoteDataSource.getLeaveHistory(
        employee: employee,
        limitStart: limitStart,
        limitPageLength: limitPageLength,
      );
      return models.map((e) => e.toEntity()).toList();
    });
  }
}
