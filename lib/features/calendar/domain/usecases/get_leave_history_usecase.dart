import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/leave_history_entity.dart';
import '../repositories/i_calendar_repository.dart';

class GetCalendarLeaveHistoryParams {
  final String employee;
  final int limitStart;
  final int limitPageLength;

  const GetCalendarLeaveHistoryParams({
    required this.employee,
    this.limitStart = 0,
    this.limitPageLength = 100,
  });
}

class GetCalendarLeaveHistoryUseCase
    implements UseCase<List<LeaveHistoryEntity>, GetCalendarLeaveHistoryParams> {
  final ICalendarRepository repository;

  GetCalendarLeaveHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<LeaveHistoryEntity>>> call(
    GetCalendarLeaveHistoryParams params,
  ) async {
    return await repository.getLeaveHistory(
      employee: params.employee,
      limitStart: params.limitStart,
      limitPageLength: params.limitPageLength,
    );
  }
}
