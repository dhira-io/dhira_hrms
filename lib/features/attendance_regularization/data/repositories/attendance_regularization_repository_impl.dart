import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/exceptions.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/network/network_info.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_punch_summary_entity.dart';
import '../datasources/attendance_regularization_remote_datasource.dart';
import '../../domain/entities/attendance_regularization_entity.dart';
import '../../domain/repositories/i_attendance_regularization_repository.dart';
import '../models/attendance_regularization_model.dart';

class AttendanceRegularizationRepositoryImpl
    implements IAttendanceRegularizationRepository {
  final IAttendanceRegularizationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AttendanceRegularizationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> submitRegularization(
    AttendanceRegularizationEntity regularization,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.submitRegularization(
          AttendanceRegularizationModel.fromEntity(regularization),
        );
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message, code: e.code));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      }
    });
  }

  @override
  Future<Either<Failure, String>> uploadFile({
    required String filePath,
    required String fileName,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final fileUrl = await remoteDataSource.uploadFile(
          filePath: filePath,
          fileName: fileName,
        );
        return Right(fileUrl);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message, code: e.code));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      }
    });
  }

  @override
  Future<Either<Failure, AttendancePunchSummaryEntity>> getAttendancePunchSummary({
    required String attendanceDate,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getAttendancePunchSummary(
          attendanceDate: attendanceDate,
        );
        return Right(model.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message, code: e.code));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      }
    });
  }
}
