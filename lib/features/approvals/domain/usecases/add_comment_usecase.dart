import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_approvals_repository.dart';

class AddCommentUseCase {
  final IApprovalsRepository repository;

  AddCommentUseCase(this.repository);

  Future<Either<Failure, void>> call(String referenceDoctype, String referenceName, String content) {
    return repository.addComment(referenceDoctype, referenceName, content);
  }
}
