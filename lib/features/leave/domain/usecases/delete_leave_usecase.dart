import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/leave_repository.dart';

class DeleteLeaveUseCase {
  final ILeaveRepository repository;

  DeleteLeaveUseCase(this.repository);

  Future<Either<Failure, bool>> call(String name) async {
    return await repository.deleteLeaveApplication(name);
  }
}
