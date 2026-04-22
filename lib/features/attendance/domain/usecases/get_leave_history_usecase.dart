import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class GetLeaveHistoryUseCase
    implements UseCase<List<LeaveHistoryEntity>, String> {
  final IAttendanceRepository repository;

  GetLeaveHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<LeaveHistoryEntity>>> call(
    String employee,
  ) async {
    return await repository.getLeaveHistory(employee);
  }
}
