import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_regularization_entity.dart';
import '../repositories/i_attendance_repository.dart';

class SubmitRegularizationUseCase
    implements UseCase<Unit, AttendanceRegularizationEntity> {
  final IAttendanceRepository repository;

  SubmitRegularizationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
    AttendanceRegularizationEntity regularization,
  ) async {
    return await repository.submitRegularization(regularization);
  }
}
