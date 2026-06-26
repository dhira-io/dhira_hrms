import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/leave_history_entity.dart';
import '../repositories/i_calendar_repository.dart';

class GetCalendarLeaveHistoryUseCase
    implements UseCase<List<LeaveHistoryEntity>, String> {
  final ICalendarRepository repository;

  GetCalendarLeaveHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<LeaveHistoryEntity>>> call(
    String employee,
  ) async {
    return await repository.getLeaveHistory(employee);
  }
}
