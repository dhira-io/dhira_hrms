import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/i_leave_approval_repository.dart';

class UploadLeaveFileUseCase {
  final ILeaveApprovalRepository repository;

  UploadLeaveFileUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String filePath,
    required String fileName,
    String? leaveId,
  }) async {
    return await repository.uploadFile(
      filePath: filePath,
      fileName: fileName,
      leaveId: leaveId,
    );
  }
}
