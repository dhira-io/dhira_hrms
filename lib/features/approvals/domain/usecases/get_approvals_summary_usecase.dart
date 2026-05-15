import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/approvals_summary_entity.dart';
import '../repositories/i_approvals_repository.dart';

// lib/features/approvals/domain/usecases/get_approvals_summary_usecase.dart
class GetApprovalsSummaryUseCase {
  final IApprovalsRepository repository;
  GetApprovalsSummaryUseCase(this.repository);

  // Remove any required arguments if you just want to fetch the summary
  Future<Either<Failure, ApprovalsSummaryEntity>> call() async {
    return await repository.getApprovalsSummary();
  }
}