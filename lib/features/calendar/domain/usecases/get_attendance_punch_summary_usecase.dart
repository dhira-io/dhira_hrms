import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import '../entities/attendance_punch_summary_entity.dart';
import '../repositories/i_calendar_repository.dart';

class GetCalendarPunchSummaryUseCase {
  final ICalendarRepository repository;

  GetCalendarPunchSummaryUseCase(this.repository);

  Future<Either<Failure, AttendancePunchSummaryEntity>> call({
    required String attendanceDate,
  }) {
    return repository.getAttendancePunchSummary(
      attendanceDate: attendanceDate,
    );
  }
}
