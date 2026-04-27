import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/leave_statistics_entity.dart';
import '../repositories/leave_repository.dart';

class GetLeaveStatisticsUseCase implements UseCase<LeaveStatisticsEntity, GetLeaveStatisticsParams> {
  final ILeaveRepository repository;

  GetLeaveStatisticsUseCase(this.repository);

  @override
  Future<Either<Failure, LeaveStatisticsEntity>> call(GetLeaveStatisticsParams params) async {
    return await repository.getLeaveStatistics(
      employeeId: params.employeeId,
      fromDate: params.fromDate,
      toDate: params.toDate,
    );
  }
}

class GetLeaveStatisticsParams {
  final String employeeId;
  final String fromDate;
  final String toDate;

  GetLeaveStatisticsParams({
    required this.employeeId,
    required this.fromDate,
    required this.toDate,
  });
}
