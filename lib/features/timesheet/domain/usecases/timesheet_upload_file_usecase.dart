import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/timesheet_repository.dart';

class TimesheetUploadFileUseCase implements UseCase<String, String> {
  final ITimesheetRepository repository;

  TimesheetUploadFileUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String filePath) async {
    return await repository.uploadFile(filePath: filePath);
  }
}
