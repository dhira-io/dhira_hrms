import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/services/notification_manager.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'file_operation_state.dart';

class FileOperationCubit extends Cubit<FileOperationState> {
  final DioClient dioClient;
  final LocalStorageService localStorageService;

  FileOperationCubit({
    required this.dioClient,
    required this.localStorageService,
  }) : super(const FileOperationState.initial());

  Future<void> handleFileAction({
    required String fileUrl,
    required String fileName,
    required AppLocalizations l10n,
  }) async {
    final baseUrl = dioClient.baseUrl;
    final fullUrl = fileUrl.startsWith(AppConstants.httpPrefix)
        ? fileUrl
        : '$baseUrl$fileUrl';

    final lowerFileName = fileName.toLowerCase();

    final isImage = AppConstants.imageExtensions.any(
      (ext) => lowerFileName.endsWith(ext),
    );
    final isDocument = AppConstants.documentExtensions.any(
      (ext) => lowerFileName.endsWith(ext),
    );

    if (isImage) {
      final headers = await getAuthHeaders();
      emit(
        FileOperationState.showImagePreview(
          imageUrl: fullUrl,
          headers: headers,
        ),
      );
    } else if (isDocument) {
      await downloadFile(fullUrl, fileName, l10n);
    } else {
      await openUrl(fullUrl, l10n);
    }
  }

  Future<void> downloadFile(
    String url,
    String fileName,
    AppLocalizations l10n,
  ) async {
    emit(const FileOperationState.downloading());
    try {
      String? downloadPath;
      if (Platform.isAndroid) {
        // Try the standard public download path first
        const String publicDownloadPath = "/storage/emulated/0/Download";
        final publicDir = Directory(publicDownloadPath);
        
        if (await publicDir.exists()) {
          downloadPath = publicDownloadPath;
        } else {
          // Fallback to calculated path if standard one doesn't exist
          final extDir = await getExternalStorageDirectory();
          if (extDir != null) {
            final List<String> paths =
                extDir.path.split(AppConstants.androidPathSeparator);
            String newPath = "";
            for (int x = 1; x < paths.length; x++) {
              String folder = paths[x];
              if (folder == AppConstants.androidDataFolder) break;
              newPath += "${AppConstants.androidPathSeparator}$folder";
            }
            newPath =
                "$newPath${AppConstants.androidPathSeparator}${AppConstants.androidDownloadFolder}";
            final dir = Directory(newPath);
            if (!await dir.exists()) {
              await dir.create(recursive: true);
            }
            downloadPath = newPath;
          } else {
            throw Exception("Could not access external storage");
          }
        }
      } else {
        final dir = await getApplicationDocumentsDirectory();
        downloadPath = dir.path;
      }

      // Standardize the file name (in case it's a path)
      final rawFileName =
          fileName.split(AppConstants.androidPathSeparator).last;
      
      // Append timestamp to avoid PathExistsException if a file with same name exists
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final nameParts = rawFileName.split('.');
      String finalFileName;
      if (nameParts.length > 1) {
        final extension = nameParts.removeLast();
        finalFileName = "${nameParts.join('.')}_$timestamp.$extension";
      } else {
        finalFileName = "${rawFileName}_$timestamp";
      }

      final savePath =
          "$downloadPath${AppConstants.androidPathSeparator}$finalFileName";

      ToastUtils.showInfo(l10n.downloadingFile);

      await dioClient.dio.download(url, savePath);


      try {
        final notificationManager = Get.find<NotificationManager>();
        await notificationManager.showCustomLocalNotification(
          title: l10n.fileDownloaded,
          body: finalFileName,
          payload: jsonEncode({'localFilePath': savePath}),
        );
      } catch (e, stack) {
        debugPrint("Error showing custom local notification: $e\n$stack");
      }

      emit(FileOperationState.downloadSuccess(savePath));
    } catch (e) {
      ToastUtils.showError("${l10n.failedToDownloadFile}: $e");
      emit(FileOperationState.downloadFailure(e.toString()));
    }
  }

  Future<Map<String, String>?> getAuthHeaders() async {
    final cookieMap = localStorageService.getCookieMap();
    if (cookieMap != null) {
      final cookieHeader = cookieMap.entries
          .map(
            (e) => "${e.key}${AppConstants.cookieKeyValueSeparator}${e.value}",
          )
          .join(AppConstants.cookieSeparator);
      return {AppConstants.cookieHeaderKey: cookieHeader};
    }
    return null;
  }

  Future<void> openUrl(String url, AppLocalizations l10n) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ToastUtils.showError(l10n.couldNotOpenFile);
    }
  }

  void reset() {
    emit(const FileOperationState.initial());
  }
}
