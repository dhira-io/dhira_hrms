import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/leave_repository.dart';

class UpdateLeaveStatusUseCase implements UseCase<bool, UpdateLeaveStatusParams> {
  final ILeaveRepository repository;

  UpdateLeaveStatusUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateLeaveStatusParams params) async {
    return await repository.updateLeaveApplicationStatus(
      leaveApplicationName: params.leaveApplicationName,
      newStatus: params.newStatus,
    );
  }
}

class UpdateLeaveStatusParams {
  final String leaveApplicationName;
  final String newStatus;

  UpdateLeaveStatusParams({
    required this.leaveApplicationName,
    required this.newStatus,
  });
}
