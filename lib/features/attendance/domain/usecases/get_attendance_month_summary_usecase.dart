import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_month_summary_entity.dart';
import '../repositories/i_attendance_repository.dart';

class GetAttendanceMonthSummaryUseCase {
  final IAttendanceRepository repository;

  GetAttendanceMonthSummaryUseCase(this.repository);

  Future<Either<Failure, AttendanceMonthSummaryEntity>> call({
    required String employee,
    required int month,
    required int year,
  }) async {
    return await repository.getAttendanceMonthSummary(
      employee: employee,
      month: month,
      year: year,
    );
  }
}
