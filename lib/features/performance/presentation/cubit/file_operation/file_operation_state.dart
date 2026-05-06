import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_operation_state.freezed.dart';

@freezed
class FileOperationState with _$FileOperationState {
  const factory FileOperationState.initial() = _Initial;
  const factory FileOperationState.downloading() = _Downloading;
  const factory FileOperationState.downloadSuccess(String path) = _DownloadSuccess;
  const factory FileOperationState.downloadFailure(String message) =
      _DownloadFailure;
  const factory FileOperationState.showImagePreview({
    required String imageUrl,
    Map<String, String>? headers,
  }) = _ShowImagePreview;
}
