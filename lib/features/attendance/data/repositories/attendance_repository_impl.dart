import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/attendance/data/models/attendance_regularization_model.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_regularization_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/attendance_entities.dart';
import '../../domain/repositories/i_attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

import '../../../../core/error/exceptions.dart';

class AttendanceRepositoryImpl implements IAttendanceRepository {
  final IAttendanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AttendanceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AttendanceStatusEntity>> getCheckinStatus(
    String empid,
  ) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.getCheckinStatus(empid);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> punchIn(String empid) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.punchIn(empid);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> punchOut(String empid) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.punchOut(empid);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<AttendanceLogEntity>>> getAttendanceLogs(
    String empid,
  ) async {
    return networkInfo.executeSafely(() async {
      final models = await remoteDataSource.getAttendanceLogs(empid);
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Map<String, String>>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    return networkInfo.executeSafely(() async {
      return await remoteDataSource.getCalendarEvents(
        employee: employee,
        fromDate: fromDate,
        toDate: toDate,
      );
    });
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> startBreak(
    String empid,
  ) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.startBreak(empid);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, AttendanceStatusEntity>> endBreak(String empid) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.endBreak(empid);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, AttendanceWorkDurationsEntity>> getWorkDurations(
    String empid,
  ) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.getWorkDurations(empid);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, AttendanceMonthSummaryEntity>>
  getAttendanceMonthSummary({
    required String employee,
    required int month,
    required int year,
  }) async {
    return networkInfo.executeSafely(() async {
      return await remoteDataSource.getAttendanceMonthSummary(
        employee: employee,
        month: month,
        year: year,
      );
    });
  }

  @override
  Future<Either<Failure, List<LeaveHistoryEntity>>> getLeaveHistory(
    String employee,
  ) async {
    return networkInfo.executeSafely(() async {
      final models = await remoteDataSource.getLeaveHistory(employee);
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, LeaveDetailsEntity>> getLeaveDetails({
    required String employee,
    required String date,
  }) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.getLeaveDetails(
        employee: employee,
        date: date,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<TeamLeaveEntity>>> getTeamLeaves({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    return networkInfo.executeSafely(() async {
      final models = await remoteDataSource.getTeamLeaves(
        employee: employee,
        fromDate: fromDate,
        toDate: toDate,
      );
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, HolidayListLeavePolicyEntity>>
  getHolidayListLeavePolicy(String employee) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.getHolidayListLeavePolicy(employee);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> submitRegularization(
    AttendanceRegularizationEntity regularization,
  ) async {
    return networkInfo.executeSafely(() async {
      await remoteDataSource.submitRegularization(
        AttendanceRegularizationModel.fromEntity(regularization),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, String>> uploadFile({
    required String filePath,
    required String fileName,
  }) async {
    return networkInfo.executeSafely(() async {
      return await remoteDataSource.uploadFile(
        filePath: filePath,
        fileName: fileName,
      );
    });
  }
}
