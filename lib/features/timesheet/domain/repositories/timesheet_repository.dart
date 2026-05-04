import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';

abstract class ITimesheetRepository {
  Future<Either<Failure, List<TimesheetEntity>>> fetchTimesheets({
    required String employee,
    required int start,
    required int limit,
  });

  Future<Either<Failure, TimesheetEntity>> fetchSingleTimesheet(String timesheetId);

  Future<Either<Failure, List<ProjectEntity>>> fetchProjects();

  Future<Either<Failure, bool>> createTimesheet({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignmentEntity> assignments,
  });

  Future<Either<Failure, bool>> updateTimesheet({
    required String name,
    required String employee,
    required String department,
    required String approver,
    required int approved,
    required String fromDate,
    required String toDate,
    required double hoursTotal,
    required List<ProjectAssignmentEntity> assignments,
  });

  Future<Either<Failure, TimesheetEntity>> getTimesheetDetails(String timesheetId);
  Future<Either<Failure, bool>> syncTimesheetWeekWise(Map<String, dynamic> payload);
  Future<Either<Failure, bool>> deleteTimesheet(String timesheetId);
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchEmployees();
}
