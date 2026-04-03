import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class GetCheckinStatusUseCase {
  final IAttendanceRepository repository;

  GetCheckinStatusUseCase(this.repository);

  Future<Either<Failure, AttendanceStatusEntity>> call(String empid) async {
    return await repository.getCheckinStatus(empid);
  }
}
