import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_regularization_entity.dart';
import '../repositories/i_attendance_repository.dart';

class SubmitRegularizationUseCase {
  final IAttendanceRepository repository;

  SubmitRegularizationUseCase(this.repository);

  Future<Either<Failure, Unit>> call(
    AttendanceRegularizationEntity regularization,
  ) async {
    return await repository.submitRegularization(regularization);
  }
}
