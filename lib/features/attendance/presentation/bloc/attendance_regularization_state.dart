import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_punch_summary_entity.dart';
import '../../domain/entities/regularization_constants.dart';

part 'attendance_regularization_state.freezed.dart';

enum RegularizationLoadingKind { punchSummary, upload, submit }

enum RegularizationSuccessKind { fileUpload, submission }

enum RegularizationValidationError { dateRequired, timeRequired, reasonTooShort }

@freezed
abstract class RegularizationFormData with _$RegularizationFormData {
  const factory RegularizationFormData({
    DateTime? date,
    @Default(RegularizationRequestType.missedPunch)
    RegularizationRequestType requestType,
    TimeOfDay? inTime,
    TimeOfDay? outTime,
    @Default(false) bool routeToHR,
    @Default('') String reason,
    String? selectedFileName,
    String? uploadedFileUrl,
    AttendancePunchSummaryEntity? punchSummary,
    @Default(false) bool isPunchSummaryLoading,
  }) = _RegularizationFormData;

  const RegularizationFormData._();

  bool get canContinue =>
      date != null &&
      inTime != null &&
      outTime != null &&
      reason.trim().length >= 10;
}

@freezed
sealed class AttendanceRegularizationState
    with _$AttendanceRegularizationState {
  const factory AttendanceRegularizationState.initial({
    @Default(RegularizationFormData()) RegularizationFormData formData,
  }) = _Initial;

  const factory AttendanceRegularizationState.loading({
    required RegularizationFormData formData,
    required RegularizationLoadingKind kind,
  }) = _Loading;

  const factory AttendanceRegularizationState.success({
    required RegularizationFormData formData,
    required RegularizationSuccessKind kind,
  }) = _Success;

  const factory AttendanceRegularizationState.error({
    required RegularizationFormData formData,
    String? message,
    RegularizationValidationError? validationError,
  }) = _Error;

  const AttendanceRegularizationState._();
}
