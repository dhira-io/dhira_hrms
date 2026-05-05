import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/approval_request_entity.dart';
import '../../../domain/entities/comment_entity.dart';

abstract class ILeaveApprovalRepository {
  Future<Either<Failure, List<ApprovalRequestEntity>>> getPendingLeaves(ApprovalCategory category);
  Future<Either<Failure, void>> submitLeaveWorkflowAction(String leaveApplicationName, String action);
  Future<Either<Failure, void>> addComment(String referenceDoctype, String referenceName, String content);
  Future<Either<Failure, List<CommentEntity>>> getComments(String doctype, String requestId);
}
