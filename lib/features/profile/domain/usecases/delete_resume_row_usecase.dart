import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class DeleteResumeRowParams {
  final String employeeId;
  final String section;
  final String rowName;

  DeleteResumeRowParams({
    required this.employeeId,
    required this.section,
    required this.rowName,
  });
}

class DeleteResumeRowUseCase {
  final IProfileRepository repository;

  DeleteResumeRowUseCase(this.repository);

  Future<Either<Failure, void>> call(DeleteResumeRowParams params) {
    return repository.deleteResumeRow(
      params.employeeId,
      params.section,
      params.rowName,
    );
  }
}
