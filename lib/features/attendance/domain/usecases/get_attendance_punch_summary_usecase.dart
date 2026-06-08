import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/attendance_punch_summary_entity.dart';
import '../repositories/i_attendance_repository.dart';

class GetAttendancePunchSummaryUseCase {
  final IAttendanceRepository repository;

  GetAttendancePunchSummaryUseCase(this.repository);

  Future<Either<Failure, AttendancePunchSummaryEntity>> call({
    required String attendanceDate,
  }) {
    return repository.getAttendancePunchSummary(
      attendanceDate: attendanceDate,
    );
  }
}
