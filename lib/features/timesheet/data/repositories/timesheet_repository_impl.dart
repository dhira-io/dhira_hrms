import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../domain/repositories/timesheet_repository.dart';
import '../datasources/timesheet_remote_datasource.dart';
import '../models/timesheet_models.dart';

class TimesheetRepositoryImpl implements ITimesheetRepository {
  final TimesheetRemoteDataSource remoteDataSource;

  TimesheetRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<TimesheetEntity>>> fetchTimesheets({
    required int start,
    required int limit,
  }) async {
    try {
      final models = await remoteDataSource.fetchTimesheets(start: start, limit: limit);
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, TimesheetEntity>> fetchSingleTimesheet(String timesheetId) async {
    try {
      final model = await remoteDataSource.fetchSingleTimesheet(timesheetId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> fetchProjects() async {
    try {
      final models = await remoteDataSource.fetchProjects();
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure.fromException(e));
    }
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
    try {
      final payload = {
        "employee": employee,
        "organization_department": department,
        "approver": approver,
        "from_date": fromDate,
        "to_date": toDate,
        "project_assignments": assignments
            .map((a) => ProjectAssignmentModel.fromEntity(a).toJson())
            .toList(),
      };
      final success = await remoteDataSource.createTimesheet(payload);
      return Right(success);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTimesheet({
    required String name,
    required String employee,
    required String department,
    required String approver,
    required int approved,
    required double hoursTotal,
    required List<ProjectAssignmentEntity> assignments,
  }) async {
    try {
      final payload = {
        "name": name,
        "employee": employee,
        "organization_department": department,
        "approver": approver,
        "approved": approved,
        "hours_total": hoursTotal,
        "project_assignments": assignments
            .map((a) => ProjectAssignmentModel.fromEntity(a).toJson())
            .toList(),
      };
      final success = await remoteDataSource.updateTimesheet(payload);
      return Right(success);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
