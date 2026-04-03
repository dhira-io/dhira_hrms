import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/leave_entities.dart';
import '../repositories/leave_repository.dart';

class GetLeaveBalanceUseCase {
  final ILeaveRepository repository;

  GetLeaveBalanceUseCase(this.repository);

  Future<Either<Failure, LeaveBalanceEntity>> call(String employeeId, String todayDate) async {
    return await repository.getLeaveBalance(employeeId, todayDate);
  }
}
