import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_statistics_entity.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_leave_approval_repository.dart';

class GetLeaveStatisticsApprovalUseCase {
  final ILeaveApprovalRepository repository;

  GetLeaveStatisticsApprovalUseCase(this.repository);

  Future<Either<Failure, LeaveStatisticsEntity>> call(
    GetLeaveStatisticsParams params,
  ) async {
    return await repository.getLeaveStatistics(
      employeeId: params.employeeId,
      fromDate: params.fromDate,
      toDate: params.toDate,
    );
  }
}

class GetLeaveStatisticsParams {
  final String employeeId;
  final String fromDate;
  final String toDate;

  GetLeaveStatisticsParams({
    required this.employeeId,
    required this.fromDate,
    required this.toDate,
  });
}
