import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../repositories/i_attendance_repository.dart';

class GetWorkDurationsUseCase {
  final IAttendanceRepository repository;

  GetWorkDurationsUseCase(this.repository);

  Future<Either<Failure, AttendanceWorkDurationsEntity>> call(String empid) async {
    return await repository.getWorkDurations(empid);
  }
}
