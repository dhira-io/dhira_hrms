import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/holiday_list_leave_policy_entity.dart';
import '../repositories/i_attendance_repository.dart';

class GetHolidayListLeavePolicyUseCase {
  final IAttendanceRepository repository;

  GetHolidayListLeavePolicyUseCase(this.repository);

  Future<Either<Failure, HolidayListLeavePolicyEntity>> call(String employee) {
    return repository.getHolidayListLeavePolicy(employee);
  }
}
