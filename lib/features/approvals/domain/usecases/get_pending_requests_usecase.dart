// lib/features/approvals/domain/usecases/get_pending_requests_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import '../../../../core/error/failures.dart';
import '../entities/approval_request_entity.dart';
import '../repositories/i_approvals_repository.dart';

class GetPendingRequestsUseCase {
  final IApprovalsRepository repository;

  GetPendingRequestsUseCase(this.repository);

  /// Executes the business logic to fetch pending requests based on type.
  /// Uses the Dartz Either type for functional error handling.
  Future<Either<Failure, List<ApprovalRequestEntity>>> call(ApprovalType type, ApprovalCategory category) async {
    return await repository.getPendingRequests(type, category);
  }
}