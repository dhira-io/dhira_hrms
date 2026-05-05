import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/approval_request_entity.dart';

abstract class ITimesheetApprovalRepository {
  Future<Either<Failure, List<ApprovalRequestEntity>>> getPendingTimesheets(ApprovalCategory category);
  Future<Either<Failure, void>> submitTimesheetWorkflowAction(String timesheetName, String action);

  Future<Either<Failure, TimesheetApprovalEntity>> getTimesheetDetails(String timesheetId);
  Future<Either<Failure, bool>> syncTimesheetWeekWise(Map<String, dynamic> payload);
  Future<Either<Failure, bool>> deleteTimesheet(String timesheetId);
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchEmployees();

}
