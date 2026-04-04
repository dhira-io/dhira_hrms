import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/leave_entities.dart';
import '../../domain/repositories/leave_repository.dart';
import '../datasources/leave_remote_datasource.dart';

class LeaveRepositoryImpl implements ILeaveRepository {
  final LeaveRemoteDataSource remoteDataSource;

  LeaveRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<LeaveEntity>>> fetchLeaveApplicationsList({
    required int start,
    required int length,
  }) async {
    try {
      final models = await remoteDataSource.fetchLeaveApplicationsList(start: start, length: length);
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<LeaveTypeEntity>>> fetchLeaveTypes() async {
    try {
      final models = await remoteDataSource.fetchLeaveTypes();
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> submitLeaveApplication({
    required String employeeId,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) async {
    try {
      final success = await remoteDataSource.submitLeaveApplication(
        employeeId: employeeId,
        leaveType: leaveType,
        fromDate: fromDate,
        toDate: toDate,
        reason: reason,
        halfDay: halfDay,
        halfDayDate: halfDayDate,
      );
      return Right(success);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateLeaveApplication({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) async {
    try {
      final success = await remoteDataSource.updateLeaveApplication(
        leaveId: leaveId,
        fromDate: fromDate,
        toDate: toDate,
        reason: reason,
        halfDay: halfDay,
        halfDayDate: halfDayDate,
      );
      return Right(success);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteLeaveApplication(String name) async {
    try {
      final success = await remoteDataSource.deleteLeaveApplication(name);
      return Right(success);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelLeaveApplication(String name) async {
    try {
      final success = await remoteDataSource.cancelLeaveApplication(name);
      return Right(success);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, LeaveBalanceEntity>> getLeaveBalance(String employeeId, String todayDate) async {
    try {
      final model = await remoteDataSource.getLeaveBalance(employeeId, todayDate);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
