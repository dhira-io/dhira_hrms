import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/comment_entity.dart';
import '../repositories/i_leave_approval_repository.dart';

class GetLeaveCommentsUseCase {
  final ILeaveApprovalRepository repository;

  GetLeaveCommentsUseCase(this.repository);

  Future<Either<Failure, List<CommentEntity>>> call(String doctype, String requestId) async {
    return await repository.getComments(doctype, requestId);
  }
}
