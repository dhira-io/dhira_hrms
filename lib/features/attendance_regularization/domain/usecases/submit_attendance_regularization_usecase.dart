import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import '../entities/attendance_regularization_entity.dart';
import '../repositories/i_attendance_regularization_repository.dart';

class SubmitAttendanceRegularizationUseCase
    implements UseCase<Unit, AttendanceRegularizationEntity> {
  final IAttendanceRegularizationRepository repository;

  SubmitAttendanceRegularizationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
    AttendanceRegularizationEntity params,
  ) async {
    return await repository.submitRegularization(params);
  }
}
