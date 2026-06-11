import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class UpdateEmployeeResumeParams {
  final String employeeId;
  final String resumeDataJson;

  UpdateEmployeeResumeParams({
    required this.employeeId,
    required this.resumeDataJson,
  });
}

class UpdateEmployeeResumeUseCase {
  final IProfileRepository repository;

  UpdateEmployeeResumeUseCase(this.repository);

  Future<Either<Failure, void>> call(UpdateEmployeeResumeParams params) {
    return repository.updateEmployeeResume(
      params.employeeId,
      params.resumeDataJson,
    );
  }
}
