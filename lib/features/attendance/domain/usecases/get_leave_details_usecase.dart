import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class GetLeaveDetailsUseCase
    implements UseCase<LeaveDetailsEntity, GetLeaveDetailsParams> {
  final IAttendanceRepository repository;

  GetLeaveDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, LeaveDetailsEntity>> call(
    GetLeaveDetailsParams params,
  ) async {
    return await repository.getLeaveDetails(
      employee: params.employee,
      date: params.date,
    );
  }
}

class GetLeaveDetailsParams {
  final String employee;
  final String date;

  GetLeaveDetailsParams({required this.employee, required this.date});
}
