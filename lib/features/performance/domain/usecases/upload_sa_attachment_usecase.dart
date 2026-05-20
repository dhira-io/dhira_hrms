import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class UploadSaAttachmentUseCase {
  final IPerformanceRepository repository;

  UploadSaAttachmentUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String filePath,
    required String fileName,
    required String selfAssessmentId,
  }) {
    return repository.uploadSaAttachment(
      filePath: filePath,
      fileName: fileName,
      selfAssessmentId: selfAssessmentId,
    );
  }
}
