import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/timesheet_repository.dart';

class TimesheetUploadFileUseCase {
  final ITimesheetRepository repository;

  TimesheetUploadFileUseCase(this.repository);

  Future<Either<Failure, String>> call(String filePath) async {
    return await repository.uploadFile(filePath: filePath);
  }
}
