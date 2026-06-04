import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_balance_entity.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_leave_approval_repository.dart';

class GetLeaveBalanceApprovalUseCase {
  final ILeaveApprovalRepository repository;

  GetLeaveBalanceApprovalUseCase(this.repository);

  Future<Either<Failure, LeaveBalanceEntity>> call(
    String employeeId,
    String todayDate,
    String gender,
  ) async {
    return await repository.getLeaveBalance(employeeId, todayDate, gender);
  }
}
