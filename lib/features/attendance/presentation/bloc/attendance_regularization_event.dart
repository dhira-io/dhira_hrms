import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/regularization_constants.dart';

part 'attendance_regularization_event.freezed.dart';

@freezed
class AttendanceRegularizationEvent with _$AttendanceRegularizationEvent {
  const factory AttendanceRegularizationEvent.regularizationStarted() =
      RegularizationStarted;

  const factory AttendanceRegularizationEvent.dateChanged(DateTime date) =
      DateChanged;

  const factory AttendanceRegularizationEvent.requestTypeChanged(
    RegularizationRequestType type,
  ) = RequestTypeChanged;

  const factory AttendanceRegularizationEvent.inTimeChanged(TimeOfDay? time) =
      InTimeChanged;

  const factory AttendanceRegularizationEvent.outTimeChanged(TimeOfDay? time) =
      OutTimeChanged;

  const factory AttendanceRegularizationEvent.routeToHRChanged(bool value) =
      RouteToHRChanged;

  const factory AttendanceRegularizationEvent.reasonChanged(String reason) =
      ReasonChanged;

  const factory AttendanceRegularizationEvent.uploadFileRequested({
    required String filePath,
    required String fileName,
  }) = UploadFileRequested;

  const factory AttendanceRegularizationEvent.fileRemoved() = FileRemoved;

  const factory AttendanceRegularizationEvent.submitRequested() = SubmitRequested;

  const factory AttendanceRegularizationEvent.resetRequested() = ResetRequested;
}
