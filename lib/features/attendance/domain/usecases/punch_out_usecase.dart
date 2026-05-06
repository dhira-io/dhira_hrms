import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../repositories/i_attendance_repository.dart';

class PunchOutUseCase {
  final IAttendanceRepository repository;

  PunchOutUseCase(this.repository);

  Future<Either<Failure, AttendanceStatusEntity>> call(String empid) async {
    return await repository.punchOut(empid);
  }
}
