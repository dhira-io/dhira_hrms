import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import '../entities/team_leave_entity.dart';
import '../repositories/i_calendar_repository.dart';

class GetCalendarTeamLeavesUseCase
    implements UseCase<List<TeamLeaveEntity>, GetCalendarTeamLeavesParams> {
  final ICalendarRepository repository;

  GetCalendarTeamLeavesUseCase(this.repository);

  @override
  Future<Either<Failure, List<TeamLeaveEntity>>> call(
    GetCalendarTeamLeavesParams params,
  ) async {
    return await repository.getTeamLeaves(
      employee: params.employee,
      fromDate: params.fromDate,
      toDate: params.toDate,
    );
  }
}

class GetCalendarTeamLeavesParams extends Equatable {
  final String employee;
  final String fromDate;
  final String toDate;

  const GetCalendarTeamLeavesParams({
    required this.employee,
    required this.fromDate,
    required this.toDate,
  });

  @override
  List<Object?> get props => [employee, fromDate, toDate];
}
