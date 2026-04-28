import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';

class LeavePolicyPdfBottomSheet extends StatefulWidget {
  final String fileUrl;

  const LeavePolicyPdfBottomSheet({super.key, required this.fileUrl});

  static Future<void> show(BuildContext context, String fileUrl) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.r20),
        ),
      ),
      builder: (context) => LeavePolicyPdfBottomSheet(fileUrl: fileUrl),
    );
  }

  @override
  State<LeavePolicyPdfBottomSheet> createState() =>
      _LeavePolicyPdfBottomSheetState();
}

class _LeavePolicyPdfBottomSheetState extends State<LeavePolicyPdfBottomSheet> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  bool _isLoading = true;
  int _totalPages = 0;
  int _currentPage = 0;

  int _rotationTurns = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
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
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.slateText),
                ),
                const SizedBox(width: AppConstants.p10),
                Text(
                  l10n.leavePolicy,
                  style: AppTextStyle.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkSlate,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // PDF Viewer
          Expanded(
            child: Stack(
              children: [
                RotatedBox(
                  quarterTurns: _rotationTurns,
                  child: SfPdfViewer.network(
                    widget.fileUrl,
                    controller: _pdfViewerController,
                    onDocumentLoaded: (details) {
                      setState(() {
                        _isLoading = false;
                        _totalPages = details.document.pages.count;
                      });
                    },
                    onPageChanged: (details) {
                      setState(() {
                        _currentPage = details.newPageNumber;
                      });
                    },
                    onDocumentLoadFailed: (details) {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
              ],
            ),
          ),

          // Footer / Controls
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.p12,
              horizontal: AppConstants.p20,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
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
                          ? AppColors.primary
                          : AppColors.placeholdergrey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.p12,
                      vertical: AppConstants.p6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.slate200,
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                    child: Text(
                      '$_currentPage / $_totalPages',
                      style: AppTextStyle.label.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.slateText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _currentPage < _totalPages
                        ? () => _pdfViewerController.nextPage()
                        : null,
                    icon: Icon(
                      Icons.chevron_right,
                      color: _currentPage < _totalPages
                          ? AppColors.primary
                          : AppColors.slate400,
                    ),
                  ),
                  const Spacer(),
                  // Rotation Buttons
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rotationTurns = (_rotationTurns + 1) % 4;
                      });
                    },
                    icon: const Icon(
                      Icons.rotate_left,
                      color: AppColors.slateText,
                    ),
                    tooltip: l10n.rotateLeft,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rotationTurns = (_rotationTurns - 1) % 4;
                      });
                    },
                    icon: const Icon(
                      Icons.rotate_right,
                      color: AppColors.slateText,
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
}
