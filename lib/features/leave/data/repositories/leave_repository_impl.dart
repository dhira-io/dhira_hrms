import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/leave_entities.dart';
import '../../domain/repositories/leave_repository.dart';
import '../datasources/leave_remote_datasource.dart';

import '../../domain/entities/leave_details_entity.dart';

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
  Future<Either<Failure, LeaveBalanceEntity>> getLeaveBalance(
    String employeeId,
    String todayDate,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final detailsModel = await remoteDataSource.getLeaveDetails(
          employee: employeeId,
          date: todayDate,
        );

        num totalAllocated = 0.0;
        num used = 0.0;
        num pending = 0.0;

        for (var allocation in detailsModel.leaveAllocation.values) {
          totalAllocated += allocation.totalLeaves;
          used += allocation.leavesTaken;
          pending += allocation.leavesPendingApproval;
        }

        return Right(
          LeaveBalanceEntity(
            totalAllocated: totalAllocated.toInt(),
            used: used.toInt(),
            pending: pending.toInt(),
            available: (totalAllocated - used - pending).toInt(),
          ),
        );
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, LeaveDetailsEntity>> getLeaveDetails({
    required String employee,
    required String date,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getLeaveDetails(
          employee: employee,
          date: date,
        );
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
