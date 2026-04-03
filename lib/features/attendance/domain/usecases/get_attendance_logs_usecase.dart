import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceLogsUseCase {
  final IAttendanceRepository repository;

  GetAttendanceLogsUseCase(this.repository);

  Future<Either<Failure, List<AttendanceLogEntity>>> call(String empid) async {
    return await repository.getAttendanceLogs(empid);
  }
}
