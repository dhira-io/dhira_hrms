import 'package:file_picker/file_picker.dart';
import '../utils/toast_utils.dart';
import '../../l10n/app_localizations.dart';

class FileValidationUtils {
  FileValidationUtils._();

  /// Default maximum file size allowed (5MB).
  static const int defaultMaxFileSize = 5 * 1024 * 1024;

  /// Maximum number of files allowed for certain uploads.
  static const int defaultMaxUploadCount = 3;

  /// Default allowed extensions for documents and images.
  static const List<String> leaveAllowedExtensions = [
    'pdf',
    'docx',
    'xlsx',
    'pptx',
    'jpg',
    'png',
    'jpeg',
  ];

  /// Validates a file's size and extension.
  /// Shows a toast message if the size exceeds the limit.
  static bool validateFile({
    required PlatformFile file,
    required AppLocalizations l10n,
    int maxSizeBytes = defaultMaxFileSize,
  }) {
    if (file.size > maxSizeBytes) {
      ToastUtils.showError(l10n.fileSizeExceedsLimit);
      return false;
    }
    return true;
  }

  /// Checks if more files can be uploaded based on current count.
  /// Shows a toast message if the limit is reached.
  static bool canUploadMore({
    required int currentCount,
    required AppLocalizations l10n,
    int maxCount = defaultMaxUploadCount,
  }) {
    if (currentCount >= maxCount) {
      ToastUtils.showInfo(l10n.maximumFileUploadReached);
      return false;
    }
    return true;
  }
}
