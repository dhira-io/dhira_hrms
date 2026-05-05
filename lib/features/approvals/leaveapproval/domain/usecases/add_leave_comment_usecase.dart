import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/comment_entity.dart';
import '../repositories/i_leave_approval_repository.dart';

class AddLeaveCommentUseCase {
  final ILeaveApprovalRepository repository;

  AddLeaveCommentUseCase(this.repository);

  Future<Either<Failure, void>> call(String referenceDoctype, String referenceName, String content) async {
    return await repository.addComment(referenceDoctype, referenceName, content);
  }
}
