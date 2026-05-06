import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/repositories/i_timesheet_approval_repository.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../../domain/entities/approval_request_entity.dart';
import '../../../domain/entities/approval_type.dart';
import '../datasources/timesheet_approval_remote_datasource.dart';

class TimesheetApprovalRepositoryImpl implements ITimesheetApprovalRepository {
  final TimesheetApprovalRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TimesheetApprovalRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ApprovalRequestEntity>>> getPendingTimesheets(ApprovalCategory category) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getPendingTimesheets(category);
        final entities = models.map((model) => model.toEntity(ApprovalType.timesheet)).toList();
        return Right(entities);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> submitTimesheetWorkflowAction(String timesheetName, String action) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.submitTimesheetWorkflowAction(timesheetName, action);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }


  @override
  Future<Either<Failure, TimesheetApprovalEntity>> getTimesheetDetails(String timesheetId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getTimesheetDetails(timesheetId);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> syncTimesheetWeekWise(Map<String, dynamic> payload) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.syncTimesheetWeekWise(payload);
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> deleteTimesheet(String timesheetId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.deleteTimesheet(timesheetId);
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchEmployees() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final data = await remoteDataSource.fetchEmployees();
        return Right(data);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

}
