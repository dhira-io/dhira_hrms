import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/leave_repository.dart';

class CancelLeaveUseCase {
  final ILeaveRepository repository;

  CancelLeaveUseCase(this.repository);

  Future<Either<Failure, bool>> call(String name) async {
    return await repository.cancelLeaveApplication(name);
  }
}
