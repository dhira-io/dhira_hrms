import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/leave_entities.dart';
import '../repositories/leave_repository.dart';

class GetLeaveTypesUseCase {
  final ILeaveRepository repository;

  GetLeaveTypesUseCase(this.repository);

  Future<Either<Failure, List<LeaveTypeEntity>>> call() async {
    return await repository.fetchLeaveTypes();
  }
}
