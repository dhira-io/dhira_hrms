import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_approvals_repository.dart';

class SubmitCompOffWorkflowActionUseCase {
  final IApprovalsRepository repository;

  SubmitCompOffWorkflowActionUseCase(this.repository);

  Future<Either<Failure, void>> call(String compOffRequestName, String action) async {
    return await repository.submitCompOffWorkflowAction(compOffRequestName, action);
  }
}
