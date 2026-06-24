import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_regularization_constants.dart';

part 'attendance_regularization_event.freezed.dart';

@freezed
class AttendanceRegularizationEvent with _$AttendanceRegularizationEvent {
  const factory AttendanceRegularizationEvent.regularizationStarted() =
      AttendanceRegularizationStarted;

  const factory AttendanceRegularizationEvent.dateChanged(DateTime date) =
      AttendanceRegularizationDateChanged;

  const factory AttendanceRegularizationEvent.requestTypeChanged(
    AttendanceRegularizationRequestType type,
  ) = AttendanceRegularizationRequestTypeChanged;

  const factory AttendanceRegularizationEvent.inTimeChanged(TimeOfDay? time) =
      AttendanceRegularizationInTimeChanged;

  const factory AttendanceRegularizationEvent.outTimeChanged(TimeOfDay? time) =
      AttendanceRegularizationOutTimeChanged;

  const factory AttendanceRegularizationEvent.routeToHRChanged(bool value) =
      AttendanceRegularizationRouteToHRChanged;

  const factory AttendanceRegularizationEvent.reasonChanged(String reason) =
      AttendanceRegularizationReasonChanged;

  const factory AttendanceRegularizationEvent.uploadFileRequested({
    required String filePath,
    required String fileName,
    required int fileSize,
  }) = AttendanceRegularizationUploadFileRequested;

  const factory AttendanceRegularizationEvent.pickFileRequested() =
      AttendanceRegularizationPickFileRequested;

  const factory AttendanceRegularizationEvent.fileRemoved() =
      AttendanceRegularizationFileRemoved;

  const factory AttendanceRegularizationEvent.nextPressed() =
      AttendanceRegularizationNextPressed;

  const factory AttendanceRegularizationEvent.previousPressed() =
      AttendanceRegularizationPreviousPressed;

  const factory AttendanceRegularizationEvent.submitRequested() =
      AttendanceRegularizationSubmitRequested;

  const factory AttendanceRegularizationEvent.resetRequested() =
      AttendanceRegularizationResetRequested;
}
