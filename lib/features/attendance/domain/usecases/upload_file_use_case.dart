import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

class UploadFileUseCase {
  final IAttendanceRepository repository;

  UploadFileUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String filePath,
    required String fileName,
  }) async {
    return await repository.uploadFile(filePath: filePath, fileName: fileName);
  }
}
