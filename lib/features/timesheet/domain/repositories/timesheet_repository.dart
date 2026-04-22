import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';

abstract class ITimesheetRepository {
  Future<Either<Failure, List<ProjectEntity>>> fetchProjects();

  Future<Either<Failure, String>> createTimesheet({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignmentEntity> assignments,
    required int docStatus,
  });

  Future<Either<Failure, String>> updateTimesheet({
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

  Future<Either<Failure, List<ProjectAssignmentEntity>>> fetchWeekWiseDetails({
    required int month,
    required int year,
  });

  Future<Either<Failure, void>> deleteTimesheetEntry({
    required String name,
    required String parent,
    required String date,
  });
}
