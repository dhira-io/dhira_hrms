import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/auth/domain/entities/user_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/constants/timesheet_constants.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/timesheet_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/timesheet_overview_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'timesheet_status.dart';
import 'timesheet_success_type.dart';
import 'timesheet_attachment_type.dart';

part 'timesheet_state.freezed.dart';

@freezed
class TimesheetState with _$TimesheetState {
  const factory TimesheetState({
    @Default(TimesheetStateStatus.initial) TimesheetStateStatus status,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    String? initialTimesheetId,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    @Default(false) bool isSubmitWeeklyLoading,
    @Default(false) bool hasDraftTasksInSelectedWeek,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
    @Default([]) List<ProjectAssignmentEntity> assignmentsForSelectedDay,
    String? currentWeekActiveId,
    @Default("") String formattedOverviewWeeks,
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
    @Default("") String formTaskData,
    @Default("") String formDescription,
    @Default("") String formExpectedHours,
    @Default("") String formSpentHours,
    ProjectEntity? formSelectedProject,
    @Default(0.0) double weeklyTotalHours,
    @Default({}) Set<DateTime> taskDays,
    @Default({}) Set<DateTime> holidayDays,
    @Default("") String currentWeekRangeText,
    @Default([]) List<DateTime> holidays,
    @Default(false) bool isUploading,
    String? uploadedFileUrl,
    String? errorMessage,
    String? successMessage,
    TimesheetSuccessType? successType,
    String? viewAttachmentUrl,
    TimesheetAttachmentType? viewAttachmentType,
  }) = _TimesheetState;

  const TimesheetState._();

  int get currentTaskNumber {
    if (editingTask != null) {
      final indexInSelectedDay = assignmentsForSelectedDay.indexOf(editingTask!);
      if (indexInSelectedDay != -1) {
        return indexInSelectedDay + 1;
      } else if (editingIndex != null) {
        return editingIndex! + 1;
      }
      return 1;
    }
    return assignmentsForSelectedDay.length + 1;
  }

  bool get isInitialLoading =>
      (status == TimesheetStateStatus.initial ||
          status == TimesheetStateStatus.loading) &&
      editAssignments.isEmpty;

  bool get isErrorEmpty =>
      status == TimesheetStateStatus.error && editAssignments.isEmpty;

  double getHoursForDay(DateTime day) {
    return editAssignments.where((e) {
      if (e.date == null) return false;
      final parsed = DateTime.tryParse(e.date!)?.toLocal();
      return parsed != null && DateTimeUtils.isSameDay(parsed, day);
    }).fold(0.0, (sum, e) => sum + e.spentHours);
  }

  double get selectedDayHours => getHoursForDay(selectedDate ?? DateTime.now());

  // Daily hours — business rule: 9.5h target
  double get selectedDayRemainingHours =>
      (TimesheetConstants.dailyTargetHours - selectedDayHours)
          .clamp(0.0, TimesheetConstants.dailyTargetHours);

  double get selectedDayProgressPercent =>
      (selectedDayHours / TimesheetConstants.dailyTargetHours).clamp(0.0, 1.0);

  int get selectedDayProgressPercentInt =>
      (selectedDayProgressPercent * 100).toInt();

  // Weekly range computed values — business rule: 48h target
  double get weeklyRemainingHours =>
      (TimesheetConstants.weeklyTargetHours - weeklyTotalHours)
          .clamp(0.0, TimesheetConstants.weeklyTargetHours);

  double get weeklyProgressPercent =>
      (weeklyTotalHours / TimesheetConstants.weeklyTargetHours).clamp(0.0, 1.0);

  int get weeklyProgressPercentInt => (weeklyProgressPercent * 100).toInt();

  int get currentWeekOfYear =>
      DateTimeUtils.getWeekOfYear(selectedDate ?? DateTime.now());

  bool get isThisWeek {
    final date = selectedDate ?? DateTime.now();
    final startOfWeek = DateTimeUtils.getStartOfWeek(date);
    final startOfCurrentWeek = DateTimeUtils.getStartOfWeek(DateTime.now());
    return DateTimeUtils.isSameDay(startOfWeek, startOfCurrentWeek);
  }

  int get currentWeekYear {
    final startOfWeek =
        DateTimeUtils.getStartOfWeek(selectedDate ?? DateTime.now());
    return startOfWeek.year;
  }

  bool get isPreviousWeekAllowed {
    final date = selectedDate ?? DateTime.now();
    final startOfWeek = DateTimeUtils.getStartOfWeek(date);
    return DateTimeUtils.isWeekAllowed(
        startOfWeek.subtract(const Duration(days: 7)));
  }

  bool get isNextWeekAllowed {
    final date = selectedDate ?? DateTime.now();
    final startOfWeek = DateTimeUtils.getStartOfWeek(date);
    return DateTimeUtils.isWeekAllowed(
        startOfWeek.add(const Duration(days: 7)));
  }

  String get activeTimesheetIdOrDefault =>
      currentWeekActiveId ?? initialTimesheetId ?? '0';
}

extension ProjectAssignmentEntityX on ProjectAssignmentEntity {
  bool get isApproved => status == TimesheetStatus.approved;
  bool get isRejected => status == TimesheetStatus.rejected;
  bool get isPending => status == TimesheetStatus.pending;

  double get variance => spentHours - expectedHours;
  String get varianceSign => variance >= 0 ? '+' : '';
}
