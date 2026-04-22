import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/leave_details_entity.dart';
import '../repositories/leave_repository.dart';

class GetLeaveDetailsUseCase {
  final ILeaveRepository repository;

  GetLeaveDetailsUseCase(this.repository);

  Future<Either<Failure, LeaveDetailsEntity>> call({
    required String employee,
    required String date,
  }) async {
    return await repository.getLeaveDetails(employee: employee, date: date);
  }
}
