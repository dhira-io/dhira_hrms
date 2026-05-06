import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/approval_request_entity.dart';
import '../repositories/i_timesheet_approval_repository.dart';

class GetPendingTimesheetsUseCase {
  final ITimesheetApprovalRepository repository;

  GetPendingTimesheetsUseCase(this.repository);

  Future<Either<Failure, List<ApprovalRequestEntity>>> call(ApprovalCategory category) async {
    return await repository.getPendingTimesheets(category);
  }
}
