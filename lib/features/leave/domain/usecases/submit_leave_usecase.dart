import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/leave_repository.dart';

class SubmitLeaveUseCase {
  final ILeaveRepository repository;

  SubmitLeaveUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String employeeId,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) async {
    return await repository.submitLeaveApplication(
      employeeId: employeeId,
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      reason: reason,
      halfDay: halfDay,
      halfDayDate: halfDayDate,
    );
  }
}
