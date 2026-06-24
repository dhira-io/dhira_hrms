import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_punch_summary_entity.dart';
import '../repositories/i_attendance_regularization_repository.dart';

class GetRegularizationPunchSummaryUseCase
    implements UseCase<AttendancePunchSummaryEntity, String> {
  final IAttendanceRegularizationRepository repository;

  GetRegularizationPunchSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, AttendancePunchSummaryEntity>> call(
    String params,
  ) async {
    return await repository.getAttendancePunchSummary(attendanceDate: params);
  }
}
