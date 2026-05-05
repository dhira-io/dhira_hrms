import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/comment_entity.dart';
import '../repositories/i_approvals_repository.dart';

class GetCommentsUseCase {
  final IApprovalsRepository repository;

  GetCommentsUseCase(this.repository);

  Future<Either<Failure, List<CommentEntity>>> call(String doctype, String requestId) async {
    return await repository.getComments(doctype, requestId);
  }
}
