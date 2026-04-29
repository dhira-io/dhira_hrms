import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/regularization_constants.dart';

part 'attendance_regularization_state.freezed.dart';

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
  }) = _RegularizationFormData;

  const RegularizationFormData._();
}

@freezed
sealed class AttendanceRegularizationState with _$AttendanceRegularizationState {
  const factory AttendanceRegularizationState.initial({
    @Default(RegularizationFormData()) RegularizationFormData formData,
  }) = _Initial;

  const factory AttendanceRegularizationState.loading({
    required RegularizationFormData formData,
    @Default(false) bool isUploading,
    @Default(false) bool isSubmitting,
  }) = _Loading;

  const factory AttendanceRegularizationState.success({
    required RegularizationFormData formData,
    @Default(false) bool isFileUploadSuccess,
    @Default(false) bool isSubmissionSuccess,
  }) = _Success;

  const factory AttendanceRegularizationState.error({
    required RegularizationFormData formData,
    required String message,
  }) = _Error;

  const AttendanceRegularizationState._();
}
