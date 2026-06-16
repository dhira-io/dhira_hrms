import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_summary_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_request_entity.dart';

abstract class ICompensatoryLeaveRepository {
  Future<Either<Failure, CompensatoryLeaveSummaryEntity>>
  getCompensatoryLeaveSummary(String employeeId);
  Future<Either<Failure, List<CompensatoryLeaveEligibleDateEntity>>>
  getEligibleDates(String employeeId, String fromDate, String toDate);
  Future<Either<Failure, bool>> submitCompensatoryLeaveRequest(
    CompensatoryLeaveRequestEntity request,
  );
}
