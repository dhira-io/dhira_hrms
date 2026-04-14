import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

class GetCalendarEventsUseCase {
  final IAttendanceRepository repository;

  GetCalendarEventsUseCase(this.repository);

  Future<Either<Failure, Map<String, String>>> call({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    return await repository.getCalendarEvents(
      employee: employee,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
