import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_request_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/repositories/i_compensatory_leave_repository.dart';

class SubmitCompensatoryLeaveRequestUseCase {
  final ICompensatoryLeaveRepository repository;

  SubmitCompensatoryLeaveRequestUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String employeeId,
    required CompensatoryLeaveRequestEntity request,
  }) {
    return repository.submitCompensatoryLeaveRequest(
      employeeId: employeeId,
      request: request,
    );
  }
}
