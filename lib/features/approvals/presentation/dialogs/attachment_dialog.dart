import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/approval_card/office_doc_viewer.dart';

class AttachmentDialog extends StatelessWidget {
  final String url;

  const AttachmentDialog({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final String path = Uri.parse(url).path.toLowerCase();
    final bool isPdf = path.endsWith('.pdf');
    final bool isImage = path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.gif') ||
        path.endsWith('.webp');
    final bool isOffice = path.endsWith('.xlsx') ||
        path.endsWith('.xls') ||
        path.endsWith('.docx') ||
        path.endsWith('.doc') ||
        path.endsWith('.pptx') ||
        path.endsWith('.ppt');

    String dialogTitle;
    if (isPdf) {
      dialogTitle = l10n.pdfViewer;
    } else if (isImage) {
      dialogTitle = l10n.imageViewer;
    } else if (isOffice) {
      dialogTitle = l10n.documentViewer;
    } else {
      dialogTitle = l10n.attachmentsLabel;
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.p8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      dialogTitle,
                      style: AppTextStyle.labelLarge.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: _AttachmentPreview(
              url: url,
              isPdf: isPdf,
              isImage: isImage,
              isOffice: isOffice,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () async {
                      final fileName = url.split('/').last;
                      await Get.find<FileOperationCubit>().downloadFile(
                        url,
                        fileName,
                        l10n,
                      );
                    },
                    child: Text(
                      l10n.download,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentPreview extends StatelessWidget {
  final String url;
  final bool isPdf;
  final bool isImage;
  final bool isOffice;

  const _AttachmentPreview({
    required this.url,
    required this.isPdf,
    required this.isImage,
    required this.isOffice,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final storage = Get.find<LocalStorageService>();
    final cookieMap = storage.getCookieMap();
    final Map<String, String> headers = {};
    
    if (cookieMap != null) {
      final cookieHeader = cookieMap.entries
          .map((e) => "${e.key}=${e.value}")
          .join("; ");
      headers["Cookie"] = cookieHeader;
    }

    if (isPdf) {
      return SfPdfViewer.network(
        url,
        headers: headers,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          ToastUtils.showError('${l10n.somethingWentWrong}: ${details.error}');
        },
      );
    } else if (isImage) {
      return InteractiveViewer(
        child: Image.network(
          url,
          headers: headers,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, color: AppColors.error, size: AppConstants.p48),
                const SizedBox(height: AppConstants.p8),
                Text(l10n.somethingWentWrong),
              ],
            ),
          ),
        ),
      );
    } else if (isOffice) {
      final String viewerUrl =
          'https://docs.google.com/gview?embedded=true&url=${Uri.encodeComponent(url)}';
      return OfficeDocViewer(viewerUrl: viewerUrl);
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.p32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.insert_drive_file, size: AppConstants.iconXLarge, color: AppColors.onSurfaceVariant),
              SizedBox(height: AppConstants.p16),
              Text(l10n.unsupportedPreviewType, style: AppTextStyle.bodyMedium),
              const SizedBox(height: AppConstants.p8),
              Text(l10n.useBrowserToViewFile, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }
  }
}
