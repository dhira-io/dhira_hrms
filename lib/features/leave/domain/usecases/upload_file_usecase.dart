import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/leave_repository.dart';

class UploadFileUseCase {
  final ILeaveRepository repository;

  UploadFileUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String filePath,
    required String fileName,
    required String employeeId,
  }) async {
    return await repository.uploadFile(
      filePath: filePath,
      fileName: fileName,
      employeeId: employeeId,
    );
  }
}
