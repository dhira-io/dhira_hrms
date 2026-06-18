import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../repositories/i_attendance_repository.dart';

class EndBreakUseCase {
  final IAttendanceRepository repository;

  EndBreakUseCase(this.repository);

  Future<Either<Failure, AttendanceStatusEntity>> call(String empid) async {
    return await repository.endBreak(empid);
  }
}
