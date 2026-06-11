import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/resume_entity.dart';
import '../repositories/profile_repository.dart';

class GetEmployeeResumeUseCase {
  final IProfileRepository repository;

  GetEmployeeResumeUseCase(this.repository);

  Future<Either<Failure, ResumeEntity>> call(String employeeId) {
    return repository.getEmployeeResume(employeeId);
  }
}
