import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../domain/repositories/timesheet_repository.dart';
import '../datasources/timesheet_remote_datasource.dart';

class TimesheetRepositoryImpl implements ITimesheetRepository {
  final TimesheetRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TimesheetRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<TimesheetEntity>>> fetchTimesheets({
    required String employee,
    required int start,
    required int limit,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.fetchTimesheets(
          employee: employee,
          start: start,
          limit: limit,
        );
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, TimesheetEntity>> fetchSingleTimesheet(String timesheetId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.fetchSingleTimesheet(timesheetId);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> fetchProjects() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.fetchProjects();
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> createTimesheet({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignmentEntity> assignments,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final totalExpected = assignments.fold(0.0, (sum, item) => sum + item.expectedHours);
        final totalSpent = assignments.fold(0.0, (sum, item) => sum + item.spentHours);

        final payload = {
          "employee": employee,
          "organization_department": department,
          "approver": approver,
          "from_date": fromDate,
          "to_date": toDate,
          "hours_total": totalSpent,
          "total_spent_hours": totalSpent,
          "expected_hours_total": totalExpected,
          "project_assignments": assignments.map((a) {
            final spent = a.spentHours;
            final expected = a.expectedHours;
            return {
              "project": a.project,
              "date": a.date,
              "hours_details": "${spent.toStringAsFixed(2)}/${expected.toStringAsFixed(2)}",
              "expected_hours": expected,
              "raised_by": employee,
              "spent_hours": spent,
              "completed": 0,
              "approved": 0,
              "applicable_for_compensatory_off": 0,
              "status": "Pending",
            };
          }).toList(),
        };

        debugPrint("payload is ${jsonEncode(payload)}   --ok"  );
        final success = await remoteDataSource.createTimesheet(payload);
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
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
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final totalExpected = assignments.fold(0.0, (sum, item) => sum + item.expectedHours);
        final totalSpent = assignments.fold(0.0, (sum, item) => sum + item.spentHours);

        final payload = {
          "name": name,
          "employee": employee,
          "organization_department": department,
          "approver": approver,
          "approved": approved,
          "from_date": fromDate, 
          "to_date": toDate,
          "hours_total": totalSpent,
          "total_spent_hours": totalSpent,
          "expected_hours_total": totalExpected,
          "project_assignments": assignments.map((a) {
            final spent = a.spentHours;
            final expected = a.expectedHours;
            return {
              "project": a.project,
              "date": a.date,
              "hours_details": "${spent.toStringAsFixed(2)} / ${expected.toStringAsFixed(2)}",
              "expected_hours": expected,
              "raised_by": employee,
              "spent_hours": spent,
              "completed": 0,
              "approved": 0,
              "applicable_for_compensatory_off": 0,
              "status": "Pending",
            };
          }).toList(),
        };
        final success = await remoteDataSource.updateTimesheet(payload);
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
