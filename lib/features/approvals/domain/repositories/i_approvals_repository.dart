import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import '../../../../core/error/failures.dart';
import '../entities/approvals_access_entity.dart';
import '../entities/approvals_summary_entity.dart';

abstract class IApprovalsRepository {
  Future<Either<Failure, ApprovalsAccessEntity>> getApprovalsAccess();
  Future<Either<Failure, ApprovalsSummaryEntity>> getApprovalsSummary();
  // New method for paginated/list data
  Future<Either<Failure, List<ApprovalRequestEntity>>> getPendingRequests(ApprovalType type, ApprovalCategory category);
  Future<Either<Failure, void>> addComment(String referenceDoctype, String referenceName, String content);
}