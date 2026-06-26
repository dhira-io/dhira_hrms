import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_punch_summary_entity.dart';
import '../entities/attendance_regularization_entity.dart';

abstract class IAttendanceRegularizationRepository {
  Future<Either<Failure, Unit>> submitRegularization(
    AttendanceRegularizationEntity regularization,
  );
  Future<Either<Failure, String>> uploadFile({
    required String filePath,
    required String fileName,
  });
  Future<Either<Failure, AttendancePunchSummaryEntity>> getAttendancePunchSummary({
    required String attendanceDate,
  });
}
