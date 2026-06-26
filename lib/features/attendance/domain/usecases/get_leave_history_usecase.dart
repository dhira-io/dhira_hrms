import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';
import '../repositories/i_attendance_repository.dart';

class GetLeaveHistoryParams {
  final String employee;
  final int limitStart;
  final int limitPageLength;

  const GetLeaveHistoryParams({
    required this.employee,
    this.limitStart = 0,
    this.limitPageLength = 10,
  });
}

class GetLeaveHistoryUseCase
    implements UseCase<List<LeaveHistoryEntity>, GetLeaveHistoryParams> {
  final IAttendanceRepository repository;

  GetLeaveHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<LeaveHistoryEntity>>> call(
    GetLeaveHistoryParams params,
  ) async {
    return await repository.getLeaveHistory(
      employee: params.employee,
      limitStart: params.limitStart,
      limitPageLength: params.limitPageLength,
    );
  }
}
