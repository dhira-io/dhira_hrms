import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../repositories/i_attendance_repository.dart';

class PunchInUseCase {
  final IAttendanceRepository repository;

  PunchInUseCase(this.repository);

  Future<Either<Failure, AttendanceStatusEntity>> call(String empid) async {
    return await repository.punchIn(empid);
  }
}
