import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class GetTeamLeavesUseCase
    implements UseCase<List<TeamLeaveEntity>, GetTeamLeavesParams> {
  final IAttendanceRepository repository;

  GetTeamLeavesUseCase(this.repository);

  @override
  Future<Either<Failure, List<TeamLeaveEntity>>> call(
    GetTeamLeavesParams params,
  ) async {
    return await repository.getTeamLeaves(
      employee: params.employee,
      fromDate: params.fromDate,
      toDate: params.toDate,
    );
  }
}

class GetTeamLeavesParams {
  final String employee;
  final String fromDate;
  final String toDate;

  GetTeamLeavesParams({
    required this.employee,
    required this.fromDate,
    required this.toDate,
  });
}
