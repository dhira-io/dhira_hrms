import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entities.dart';
import '../repositories/i_attendance_repository.dart';

class GetLeaveDetailsUseCase
    implements UseCase<LeaveDetailsEntity, GetLeaveDetailsParams> {
  final IAttendanceRepository repository;

  GetLeaveDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, LeaveDetailsEntity>> call(
    GetLeaveDetailsParams params,
  ) async {
    final result = await repository.getLeaveDetails(
      employee: params.employee,
      date: params.date,
    );

    return result.map((details) {
      final gender = params.gender?.toLowerCase();

      // Create a modifiable copy of the leave allocations
      final filteredAllocation = Map<String, LeaveAllocationEntity>.from(
        details.leaveAllocation,
      );

      if (gender == 'male') {
        // Remove Maternity Leave for males
        filteredAllocation.removeWhere(
          (key, value) => key.toLowerCase().contains('maternity'),
        );
      } else if (gender == 'female') {
        // Remove Paternity Leave for females
        filteredAllocation.removeWhere(
          (key, value) => key.toLowerCase().contains('paternity'),
        );
      }

      return details.copyWith(
        leaveAllocation: filteredAllocation,
      );
    });
  }
}

class GetLeaveDetailsParams {
  final String employee;
  final String date;
  final String? gender;

  GetLeaveDetailsParams({
    required this.employee,
    required this.date,
    this.gender,
  });
}
