import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/attendance_entities.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements IAttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AttendanceRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, AttendanceStatusEntity>> getCheckinStatus(String empid) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getCheckinStatus(empid);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> punchIn(String empid) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.punchIn(empid);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> punchOut(String empid) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.punchOut(empid);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<AttendanceLogEntity>>> getAttendanceLogs(String empid) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getAttendanceLogs(empid);
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, Map<String, String>>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final events = await remoteDataSource.getCalendarEvents(
          employee: employee,
          fromDate: fromDate,
          toDate: toDate,
        );
        return Right(events);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> startBreak(String empid) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.startBreak(empid);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> endBreak(String empid) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.endBreak(empid);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, AttendanceWorkDurationsEntity>> getWorkDurations(
      String empid) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getWorkDurations(empid);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, AttendanceMonthSummaryEntity>> getAttendanceMonthSummary({
    required String employee,
    required int month,
    required int year,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getAttendanceMonthSummary(
          employee: employee,
          month: month,
          year: year,
        );
        return Right(model);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<LeaveHistoryEntity>>> getLeaveHistory(
      String employee) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getLeaveHistory(employee);
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
