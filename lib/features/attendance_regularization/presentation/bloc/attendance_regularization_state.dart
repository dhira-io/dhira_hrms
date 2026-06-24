import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_punch_summary_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import '../../domain/entities/attendance_regularization_constants.dart';

import 'package:dhira_hrms/core/utils/date_time_utils.dart';

part 'attendance_regularization_state.freezed.dart';

enum AttendanceRegularizationLoadingKind { punchSummary, upload, submit }

enum AttendanceRegularizationSuccessKind { fileUpload, submission }

enum AttendanceRegularizationValidationError { dateRequired, timeRequired, reasonTooShort, fileTooLarge }

@freezed
class AttendanceRegularizationFormData with _$AttendanceRegularizationFormData {
  const factory AttendanceRegularizationFormData({
    DateTime? date,
    @Default(AttendanceRegularizationRequestType.missedPunch)
    AttendanceRegularizationRequestType requestType,
    TimeOfDay? inTime,
    TimeOfDay? outTime,
    @Default(false) bool routeToHR,
    @Default('') String reason,
    String? selectedFileName,
    String? uploadedFileUrl,
    AttendancePunchSummaryEntity? punchSummary,
    @Default(false) bool isPunchSummaryLoading,
  }) = _AttendanceRegularizationFormData;

  const AttendanceRegularizationFormData._();

  bool get canContinue =>
      date != null &&
      inTime != null &&
      outTime != null &&
      reason.trim().length >= 10;

  double? get durationHours {
    if (inTime == null || outTime == null) return null;
    final double inVal = inTime!.hour + inTime!.minute / 60.0;
    final double outVal = outTime!.hour + outTime!.minute / 60.0;
    double diff = outVal - inVal;
    if (diff < 0) {
      diff += 24.0;
    }
    return diff;
  }

  String getFormattedDuration(String hoursLabel) {
    final double? diff = durationHours;
    if (diff == null) return '';
    final String formattedDiff = diff % 1 == 0
        ? diff.toInt().toString()
        : diff.toStringAsFixed(1);
    return '$formattedDiff $hoursLabel';
  }

  String get getFormattedDate {
    if (date == null) return '';
    return DateTimeUtils.formatDate(
      date!,
      pattern: DateTimeUtils.patternDayMonthYear,
    );
  }
}

@freezed
class AttendanceRegularizationState with _$AttendanceRegularizationState {
  const factory AttendanceRegularizationState.initial({
    @Default(AttendanceRegularizationFormData()) AttendanceRegularizationFormData formData,
    @Default(0) int currentStep,
  }) = _Initial;

  const factory AttendanceRegularizationState.loading({
    required AttendanceRegularizationFormData formData,
    required AttendanceRegularizationLoadingKind kind,
    @Default(0) int currentStep,
  }) = _Loading;

  const factory AttendanceRegularizationState.success({
    required AttendanceRegularizationFormData formData,
    required AttendanceRegularizationSuccessKind kind,
    @Default(0) int currentStep,
  }) = _Success;

  const factory AttendanceRegularizationState.error({
    required AttendanceRegularizationFormData formData,
    String? message,
    AttendanceRegularizationValidationError? validationError,
    @Default(0) int currentStep,
  }) = _Error;

  const AttendanceRegularizationState._();
}

extension AttendanceRegularizationValidationErrorX on AttendanceRegularizationValidationError {
  String getMessage(AppLocalizations l10n) {
    switch (this) {
      case AttendanceRegularizationValidationError.dateRequired:
        return l10n.pleaseSelectDate;
      case AttendanceRegularizationValidationError.timeRequired:
        return l10n.pleaseSelectTimes;
      case AttendanceRegularizationValidationError.reasonTooShort:
        return l10n.reasonMinTenError;
      case AttendanceRegularizationValidationError.fileTooLarge:
        return l10n.fileSizeError(10);
    }
  }
}
