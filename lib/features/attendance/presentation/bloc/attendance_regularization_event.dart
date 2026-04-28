import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_regularization_entity.dart';

part 'attendance_regularization_event.freezed.dart';

@freezed
class AttendanceRegularizationEvent with _$AttendanceRegularizationEvent {
  const factory AttendanceRegularizationEvent.started({required DateTime date}) = Started;
  const factory AttendanceRegularizationEvent.submitRequested(
      AttendanceRegularizationEntity regularization) = SubmitRequested;
  const factory AttendanceRegularizationEvent.uploadFileRequested({
    required String filePath,
    required String fileName,
  }) = UploadFileRequested;
}
