import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_summary_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/repositories/i_compensatory_leave_repository.dart';

class GetCompensatoryLeaveSummaryUseCase {
  final ICompensatoryLeaveRepository repository;

  GetCompensatoryLeaveSummaryUseCase(this.repository);

  Future<Either<Failure, CompensatoryLeaveSummaryEntity>> call(String employeeId) {
    return repository.getCompensatoryLeaveSummary(employeeId);
  }
}
