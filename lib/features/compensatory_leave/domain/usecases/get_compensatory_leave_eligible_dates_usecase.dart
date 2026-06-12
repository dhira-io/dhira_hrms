import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/repositories/i_compensatory_leave_repository.dart';

class GetCompensatoryLeaveEligibleDatesUseCase {
  final ICompensatoryLeaveRepository repository;

  GetCompensatoryLeaveEligibleDatesUseCase(this.repository);

  Future<Either<Failure, List<CompensatoryLeaveEligibleDateEntity>>> call(
    String employeeId,
  ) {
    return repository.getEligibleDates(employeeId);
  }
}
