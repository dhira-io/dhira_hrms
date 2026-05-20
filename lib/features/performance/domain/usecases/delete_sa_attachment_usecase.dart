import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class DeleteSaAttachmentUseCase {
  final IPerformanceRepository repository;

  DeleteSaAttachmentUseCase(this.repository);

  Future<Either<Failure, void>> call(String fileId) {
    return repository.deleteSaAttachment(fileId);
  }
}
