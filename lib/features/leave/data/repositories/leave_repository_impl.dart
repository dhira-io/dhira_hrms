import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_details_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/leave_entities.dart';
import '../../domain/repositories/leave_repository.dart';
import '../datasources/leave_remote_datasource.dart';

class LeaveRepositoryImpl implements ILeaveRepository {
  final LeaveRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LeaveRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<LeaveTypeEntity>>> fetchLeaveTypes() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.fetchLeaveTypes();
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> submitLeaveApplication({
    required String employeeId,
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.submitLeaveApplication(
            employeeId: employeeId,
            employeeName: employeeName,
            leaveType: leaveType,
            fromDate: fromDate,
            toDate: toDate,
            reason: reason,
            halfDay: halfDay,
            halfDayDate: halfDayDate,
            halfDaySegment: halfDaySegment,
            totalleavedays: totalleavedays
        );
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> updateLeaveApplication({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.updateLeaveApplication(
          leaveId: leaveId,
          fromDate: fromDate,
          toDate: toDate,
          reason: reason,
          halfDay: halfDay,
          halfDayDate: halfDayDate,
          halfDaySegment: halfDaySegment,
          totalleavedays: totalleavedays,
        );
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, LeaveBalanceEntity>> getLeaveBalance(String employeeId, String todayDate, String gender) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getLeaveBalance(employeeId, todayDate, gender);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}