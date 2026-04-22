import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../domain/repositories/timesheet_repository.dart';
import '../datasources/timesheet_remote_datasource.dart';
import '../models/project_assignment_model.dart';
import '../models/timesheet_overview_model.dart';
import '../../domain/entities/timesheet_overview_entity.dart';

class TimesheetRepositoryImpl implements ITimesheetRepository {
  final TimesheetRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TimesheetRepositoryImpl(this.remoteDataSource, this.networkInfo);

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
  Future<Either<Failure, String>> createTimesheet({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignmentEntity> assignments,
    required int docStatus,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final payload = {
          "employee": employee,
          "organization_department": department,
          "approver": approver,
          "from_date": fromDate,
          "to_date": toDate,
          "project_assignments": assignments.map((a) => {
            "project": a.project,
            "date": DateTimeUtils.formatToYMD(DateTime.tryParse(a.date!) ?? DateTime.now()),
            "hours_details": "0.00/0.00", // Placeholder for backend-style string
            "expected_hours": a.expectedHours,
            "spent_hours": a.spentHours,
            "raised_by": employee,
            "completed": 0,
            "approved": 0,
            "applicable_for_compensatory_off": 0,
            "status": docStatus == 1 ? "Pending" : (a.status ?? "Draft"),
          }).toList(),
        };
        
        debugPrint("CREATE(Custom) payload is ${jsonEncode(payload)}");
        
        final result = await remoteDataSource.createTimesheet(payload);
        return Right(result);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
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
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final payload = _buildSyncPayload(assignments, employee, docStatus: approved);
        payload['name'] = name;
        payload['docstatus'] = approved; // In the Bloc, 'approved' is used for docstatus (1=Pending)
        
        debugPrint("UPDATE(SYNC) payload is ${jsonEncode(payload)}");

        final result = await remoteDataSource.updateTimesheet(payload);
        return Right(result);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  Map<String, dynamic> _buildSyncPayload(List<ProjectAssignmentEntity> assignments, String employee, {int? docStatus}) {
    final Map<String, dynamic> changes = {};

    for (var a in assignments) {
      if (a.date == null) continue;
      final date = DateTime.tryParse(a.date!) ?? DateTime.now();
      
      final weekKey = DateTimeUtils.getTimesheetWeekKey(date);
      final dayKey = DateTimeUtils.getTimesheetDayKey(date);
      final ymdDate = DateTimeUtils.formatToYMD(date);

      if (!changes.containsKey(weekKey)) {
        changes[weekKey] = <String, dynamic>{};
      }
      
      final Map<String, dynamic> weekData = changes[weekKey];
      if (!weekData.containsKey(dayKey)) {
        weekData[dayKey] = <Map<String, dynamic>>[];
      }

      final List dayTasks = weekData[dayKey];
      dayTasks.add({
        if (a.name != null && a.name!.isNotEmpty) "name": a.name,
        "date": ymdDate,
        "project": a.project,
        "spent_hours": a.spentHours,
        "expected_hours": a.expectedHours,
        "description": a.description ?? "",
        "task_data": a.taskData ?? "",
        "raised_by": employee,
        "status": (docStatus == 1) ? "Pending" : (a.status ?? "Draft"),
      });
    }

    return {"changes": changes};
  }
  @override
  Future<Either<Failure, List<ProjectAssignmentEntity>>> fetchWeekWiseDetails({
    required int month,
    required int year,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final raw = await remoteDataSource.fetchWeekWiseDetails(month: month, year: year);
        final List<ProjectAssignmentEntity> allAssignments = [];

        if (raw['message'] != null && raw['message'] is Map) {
          final message = raw['message'] as Map<String, dynamic>;

          for (var weekEntry in message.entries) {
            final weekData = weekEntry.value;
            if (weekData is Map) {
              // Support both "days" wrapper and direct day keys
              final Map<String, dynamic> daysMap = (weekData['days'] != null && weekData['days'] is Map) 
                  ? weekData['days'] 
                  : Map<String, dynamic>.from(weekData);

              for (var dayEntry in daysMap.entries) {
                final dayValue = dayEntry.value;
                // A day entry must be a list of tasks
                if (dayValue is List) {
                  for (var taskJson in dayValue) {
                    final model = ProjectAssignmentModel.fromJson(taskJson);
                    final parent = taskJson['parent'];
                    allAssignments.add(model.copyWith(parent: parent).toEntity());
                  }
                }
              }
            }
          }
        }

        debugPrint("REPO: Extracted ${allAssignments.length} total assignments for month $month/$year");
        return Right(allAssignments);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> deleteTimesheetEntry({
    required String name,
    required String parent,
    required String date,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final payload = {
          "name": name,
          "parent": parent,
          "date": date,
        };
        await remoteDataSource.deleteTimesheetEntry(payload);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, TimesheetOverviewEntity>> fetchOverview({
    required int month,
    required int year,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final raw = await remoteDataSource.getTimesheetOverview(month: month, year: year);
        if (raw['message'] != null && raw['message'] is Map) {
          final model = TimesheetOverviewModel.fromJson(raw['message']);
          return Right(model.toEntity());
        }
        return Left(ServerFailure("Invalid overview response"));
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
