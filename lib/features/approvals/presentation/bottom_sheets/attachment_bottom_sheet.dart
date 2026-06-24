import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/approval_card/office_doc_viewer.dart';

class AttachmentBottomSheet extends StatelessWidget {
  final String url;

  const AttachmentBottomSheet({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final String path = Uri.parse(url).path.toLowerCase();
    final bool isPdf = path.endsWith('.pdf');
    final bool isImage =
        path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.gif') ||
        path.endsWith('.webp');
    final bool isOffice =
        path.endsWith('.xlsx') ||
        path.endsWith('.xls') ||
        path.endsWith('.docx') ||
        path.endsWith('.doc') ||
        path.endsWith('.pptx') ||
        path.endsWith('.ppt');

    String sheetTitle;
    if (isPdf) {
      sheetTitle = l10n.pdfViewer;
    } else if (isImage) {
      sheetTitle = l10n.imageViewer;
    } else if (isOffice) {
      sheetTitle = l10n.documentViewer;
    } else {
      sheetTitle = l10n.attachmentsLabel;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
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
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: Text(
                        sheetTitle,
                        style: AppTextStyle.labelLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.75,
                maxWidth: MediaQuery.of(context).size.width,
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
            return ShimmerLoading(width: double.infinity, height: 300);
          },
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppColors.of(context).error,
                  size: AppConstants.p48,
                ),
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
              Icon(
                Icons.insert_drive_file,
                size: AppConstants.iconXLarge,
                color: AppColors.of(context).onSurfaceVariant,
              ),
              const SizedBox(height: AppConstants.p16),
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
