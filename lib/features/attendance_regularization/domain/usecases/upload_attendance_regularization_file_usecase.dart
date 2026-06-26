import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import '../repositories/i_attendance_regularization_repository.dart';

class UploadFileParams {
  final String filePath;
  final String fileName;

  const UploadFileParams({required this.filePath, required this.fileName});
}

class UploadAttendanceRegularizationFileUseCase
    implements UseCase<String, UploadFileParams> {
  final IAttendanceRegularizationRepository repository;

  UploadAttendanceRegularizationFileUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(
    UploadFileParams params,
  ) async {
    return await repository.uploadFile(
      filePath: params.filePath,
      fileName: params.fileName,
    );
  }
}
