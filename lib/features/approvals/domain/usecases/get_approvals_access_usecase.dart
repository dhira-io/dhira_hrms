// lib/features/approvals/domain/usecases/get_approvals_access_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/approvals_access_entity.dart';
import '../repositories/i_approvals_repository.dart';

class GetApprovalsAccessUseCase {
  final IApprovalsRepository repository;

  GetApprovalsAccessUseCase(this.repository);

  // Ensure this method signature matches the BLoC call: no positional arguments
  Future<Either<Failure, ApprovalsAccessEntity>> call() async {
    return await repository.getApprovalsAccess();
  }
}