import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/services/notification_manager.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:dhira_hrms/features/approvals/presentation/widgets/approval_card/office_doc_viewer.dart';

class CommonPdfViewer extends StatefulWidget {
  final String title;
  final String? fileUrl;
  final Uint8List? pdfBytes;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const CommonPdfViewer({
    super.key,
    required this.title,
    this.fileUrl,
    this.pdfBytes,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    String? fileUrl,
    Uint8List? pdfBytes,
    bool isLoading = false,
    String? errorMessage,
    VoidCallback? onRetry,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.of(context).transparent,
      builder: (_) {
        return CommonPdfViewer(
          title: title,
          fileUrl: fileUrl,
          pdfBytes: pdfBytes,
          isLoading: isLoading,
          errorMessage: errorMessage,
          onRetry: onRetry,
        );
      },
    );
  }

  @override
  State<CommonPdfViewer> createState() => _CommonPdfViewerState();
}

class _CommonPdfViewerState extends State<CommonPdfViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  int _totalPages = 0;
  int _currentPage = 0;
  int _rotationTurns = 0;
  bool _isLocalLoading = false;
  bool _hasLocalError = false;
  Key _pdfViewerKey = UniqueKey();

  bool _isOffice = false;

  @override
  void initState() {
    super.initState();
    if (widget.fileUrl != null) {
      final path = Uri.parse(widget.fileUrl!).path.toLowerCase();
      _isOffice = path.endsWith('.docx') ||
          path.endsWith('.doc') ||
          path.endsWith('.xlsx') ||
          path.endsWith('.xls') ||
          path.endsWith('.pptx') ||
          path.endsWith('.ppt');
      _isLocalLoading = !_isOffice;
    }
  }

  @override
  void didUpdateWidget(covariant CommonPdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fileUrl != oldWidget.fileUrl) {
      final path = widget.fileUrl != null
          ? Uri.parse(widget.fileUrl!).path.toLowerCase()
          : '';
      _isOffice = path.endsWith('.docx') ||
          path.endsWith('.doc') ||
          path.endsWith('.xlsx') ||
          path.endsWith('.xls') ||
          path.endsWith('.pptx') ||
          path.endsWith('.ppt');
      setState(() {
        _isLocalLoading = widget.fileUrl != null && !_isOffice;
        _hasLocalError = false;
        _pdfViewerKey = UniqueKey();
      });
    }
  }

  void _handleRetry() {
    if (widget.onRetry != null) {
      widget.onRetry!();
    } else {
      setState(() {
        _isLocalLoading = widget.fileUrl != null;
        _hasLocalError = false;
        _pdfViewerKey = UniqueKey();
      });
    }
  }

  Future<void> _downloadPdf() async {
    final l10n = AppLocalizations.of(context)!;
    
    // If it's a network URL, we use FileOperationCubit
    if (widget.fileUrl != null) {
      try {
        final fileOpCubit = Get.find<FileOperationCubit>();
        final baseUrl = fileOpCubit.dioClient.baseUrl;
        final url = widget.fileUrl!.startsWith('http')
            ? widget.fileUrl!
            : '$baseUrl${widget.fileUrl}';
        
        final cleanTitle = widget.title.replaceAll(RegExp(r'[^\w\s\-]'), '').replaceAll(RegExp(r'\s+'), '_');
        
        final String path = Uri.parse(widget.fileUrl!).path.toLowerCase();
        String extension = '.pdf';
        if (path.endsWith('.docx')) {
          extension = '.docx';
        } else if (path.endsWith('.doc')) {
          extension = '.doc';
        } else if (path.endsWith('.xlsx')) {
          extension = '.xlsx';
        } else if (path.endsWith('.xls')) {
          extension = '.xls';
        } else if (path.endsWith('.pptx')) {
          extension = '.pptx';
        } else if (path.endsWith('.ppt')) {
          extension = '.ppt';
        }
        
        final fileName = '$cleanTitle$extension';
        
        await fileOpCubit.downloadFile(url, fileName, l10n, appendTimestamp: false);
      } catch (e) {
        ToastUtils.showError('${l10n.failedToDownloadFile}: $e');
      }
      return;
    }

    // If we have pdfBytes, we save it locally
    if (widget.pdfBytes != null) {
      try {
        String? downloadPath;
        if (Platform.isAndroid) {
          const String publicDownloadPath = "/storage/emulated/0/Download";
          final publicDir = Directory(publicDownloadPath);

          if (await publicDir.exists()) {
            downloadPath = publicDownloadPath;
          } else {
            final extDir = await getExternalStorageDirectory();
            if (extDir != null) {
              final List<String> paths = extDir.path.split(AppConstants.androidPathSeparator);
              String newPath = "";
              for (int x = 1; x < paths.length; x++) {
                String folder = paths[x];
                if (folder == AppConstants.androidDataFolder) break;
                newPath += "${AppConstants.androidPathSeparator}$folder";
              }
              newPath = "$newPath${AppConstants.androidPathSeparator}${AppConstants.androidDownloadFolder}";
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

        final cleanTitle = widget.title.replaceAll(RegExp(r'[^\w\s\-]'), '').replaceAll(RegExp(r'\s+'), '_');
        final finalFileName = '$cleanTitle.pdf';

        final savePath = "$downloadPath${AppConstants.androidPathSeparator}$finalFileName";

        ToastUtils.showInfo(l10n.downloadingFile);

        final file = File(savePath);
        await file.writeAsBytes(widget.pdfBytes!);

        ToastUtils.showSuccess(l10n.fileDownloaded);

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
      } catch (e) {
        ToastUtils.showError("${l10n.failedToDownloadFile}: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppConstants.r20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p20,
              vertical: AppConstants.p10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: AppTextStyle.h3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.of(context).onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!widget.isLoading && !_isLocalLoading && widget.errorMessage == null && !_hasLocalError)
                  IconButton(
                    onPressed: _downloadPdf,
                    icon: Icon(
                      Icons.download_outlined,
                      color: AppColors.of(context).slateText,
                    ),
                    tooltip: l10n.download,
                  ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.of(context).slateText,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1.h),

          // PDF Viewer Body
          Expanded(
            child: _buildBody(context, l10n),
          ),

          // Footer / Controls (only show if document is successfully loaded)
          if (!widget.isLoading && !_isLocalLoading && widget.errorMessage == null && !_hasLocalError && _totalPages > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.p12,
                horizontal: AppConstants.p20,
              ),
              decoration: BoxDecoration(
                color: AppColors.of(context).surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.of(context).black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _currentPage > 1
                          ? () => _pdfViewerController.previousPage()
                          : null,
                      icon: Icon(
                        Icons.chevron_left,
                        color: _currentPage > 1
                            ? AppColors.of(context).primary
                            : AppColors.of(context).placeholdergrey,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p12,
                        vertical: AppConstants.p6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.of(context).slate200,
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                      ),
                      child: Text(
                        '$_currentPage / $_totalPages',
                        style: AppTextStyle.label.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.of(context).slateText,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      onPressed: _currentPage < _totalPages
                          ? () => _pdfViewerController.nextPage()
                          : null,
                      icon: Icon(
                        Icons.chevron_right,
                        color: _currentPage < _totalPages
                            ? AppColors.of(context).primary
                            : AppColors.of(context).slate400,
                      ),
                    ),
                    const Spacer(),
                    // Rotation Buttons
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _rotationTurns = (_rotationTurns - 1 + 4) % 4; // Rotates left
                        });
                      },
                      icon: Icon(
                        Icons.rotate_left,
                        color: AppColors.of(context).slateText,
                      ),
                      tooltip: l10n.rotateLeft,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _rotationTurns = (_rotationTurns + 1) % 4; // Rotates right
                        });
                      },
                      icon: Icon(
                        Icons.rotate_right,
                        color: AppColors.of(context).slateText,
                      ),
                      tooltip: l10n.rotateRight,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    if (widget.errorMessage != null || _hasLocalError) {
      return GenericErrorWidget(
        onRetry: _handleRetry,
        message: widget.errorMessage ?? l10n.failedToLoadPdf,
      );
    }

    if (widget.isLoading) {
      return const _PdfShimmerLoader();
    }

    if (widget.pdfBytes != null) {
      return RotatedBox(
        quarterTurns: _rotationTurns,
        child: SfPdfViewer.memory(
          widget.pdfBytes!,
          key: _pdfViewerKey,
          controller: _pdfViewerController,
          canShowScrollHead: false,
          canShowScrollStatus: false,
          onDocumentLoaded: (details) {
            setState(() {
              _totalPages = details.document.pages.count;
              _currentPage = 1;
            });
          },
          onPageChanged: (details) {
            setState(() {
              _currentPage = details.newPageNumber;
            });
          },
          onDocumentLoadFailed: (details) {
            setState(() {
              _hasLocalError = true;
            });
          },
        ),
      );
    }

    if (widget.fileUrl != null) {
      if (_isOffice) {
        final String viewerUrl =
            '${ApiConstants.googleDocsViewerUrl}${Uri.encodeComponent(widget.fileUrl!)}';
        return OfficeDocViewer(viewerUrl: viewerUrl);
      }
      return Stack(
        children: [
          RotatedBox(
            quarterTurns: _rotationTurns,
            child: SfPdfViewer.network(
              widget.fileUrl!,
              key: _pdfViewerKey,
              controller: _pdfViewerController,
              onDocumentLoaded: (details) {
                setState(() {
                  _isLocalLoading = false;
                  _totalPages = details.document.pages.count;
                  _currentPage = 1;
                });
              },
              onPageChanged: (details) {
                setState(() {
                  _currentPage = details.newPageNumber;
                });
              },
              onDocumentLoadFailed: (details) {
                setState(() {
                  _isLocalLoading = false;
                  _hasLocalError = true;
                });
              },
            ),
          ),
          if (_isLocalLoading)
            Positioned.fill(
              child: Container(
                color: AppColors.of(context).surface,
                child: const _PdfShimmerLoader(),
              ),
            ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

class _PdfShimmerLoader extends StatelessWidget {
  const _PdfShimmerLoader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(width: double.infinity, height: 60.h),
          SizedBox(height: 20.h),
          ShimmerLoading(width: 250.w, height: 20.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: 200.w, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: 150.w, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: 220.w, height: 40.h),
        ],
      ),
    );
  }
}
