import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class UpsertResumeRowParams {
  final String employeeId;
  final String section;
  final String rowDataJson;
  final String? rowName;

  UpsertResumeRowParams({
    required this.employeeId,
    required this.section,
    required this.rowDataJson,
    this.rowName,
  });
}

class UpsertResumeRowUseCase {
  final IProfileRepository repository;

  UpsertResumeRowUseCase(this.repository);

  Future<Either<Failure, void>> call(UpsertResumeRowParams params) {
    return repository.upsertResumeRow(
      params.employeeId,
      params.section,
      params.rowDataJson,
      rowName: params.rowName,
    );
  }
}
