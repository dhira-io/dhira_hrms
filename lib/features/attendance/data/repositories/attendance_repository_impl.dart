import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/attendance_entities.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements IAttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AttendanceStatusEntity>> getCheckinStatus(String empid) async {
    try {
      final model = await remoteDataSource.getCheckinStatus(empid);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to fetch status"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> punchIn(String empid) async {
    try {
      final model = await remoteDataSource.punchIn(empid);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Punch In Failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> punchOut(String empid) async {
    try {
      final model = await remoteDataSource.punchOut(empid);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Punch Out Failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceLogEntity>>> getAttendanceLogs(String empid) async {
    try {
      final models = await remoteDataSource.getAttendanceLogs(empid);
      return Right(models.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to fetch logs"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<DateTime, String>>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      final events = await remoteDataSource.getCalendarEvents(
        employee: employee,
        fromDate: fromDate,
        toDate: toDate,
      );
      return Right(events);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to fetch calendar events"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
