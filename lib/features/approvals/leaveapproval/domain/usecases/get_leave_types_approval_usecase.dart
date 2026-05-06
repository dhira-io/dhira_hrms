import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_type_entity.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_leave_approval_repository.dart';

class GetLeaveTypesApprovalUseCase {
  final ILeaveApprovalRepository repository;

  GetLeaveTypesApprovalUseCase(this.repository);

  Future<Either<Failure, List<LeaveTypeEntity>>> call() async {
    return await repository.fetchLeaveTypes();
  }
}
