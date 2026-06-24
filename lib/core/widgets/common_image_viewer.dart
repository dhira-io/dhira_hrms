import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class CommonImageViewer extends StatefulWidget {
  final String title;
  final String imageUrl;

  const CommonImageViewer({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String imageUrl,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.of(context).transparent,
      builder: (_) {
        return CommonImageViewer(
          title: title,
          imageUrl: imageUrl,
        );
      },
    );
  }

  @override
  State<CommonImageViewer> createState() => _CommonImageViewerState();
}

class _CommonImageViewerState extends State<CommonImageViewer> {
  final TransformationController _transformationController =
      TransformationController();

  void _zoomIn() {
    final Matrix4 currentMatrix = _transformationController.value;
    final double currentScale = currentMatrix.getMaxScaleOnAxis();
    final double newScale = (currentScale * 1.25).clamp(0.5, 5.0);
    final Matrix4 newMatrix = Matrix4.diagonal3Values(newScale, newScale, 1.0);
    setState(() {
      _transformationController.value = newMatrix;
    });
  }

  void _zoomOut() {
    final Matrix4 currentMatrix = _transformationController.value;
    final double currentScale = currentMatrix.getMaxScaleOnAxis();
    final double newScale = (currentScale / 1.25).clamp(0.5, 5.0);
    final Matrix4 newMatrix = Matrix4.diagonal3Values(newScale, newScale, 1.0);
    setState(() {
      _transformationController.value = newMatrix;
    });
  }

  void _resetZoom() {
    setState(() {
      _transformationController.value = Matrix4.identity();
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    // Check if the image is local or network
    final File localFile = File(widget.imageUrl);
    final bool isLocal = localFile.existsSync();

    final bool isAbsolute = widget.imageUrl.startsWith('http://') ||
        widget.imageUrl.startsWith('https://');
    final String finalUrl = isAbsolute
        ? widget.imageUrl
        : (widget.imageUrl.startsWith('/')
            ? '${ApiConstants.baseUrl}${widget.imageUrl}'
            : widget.imageUrl);

    final storage = Get.find<LocalStorageService>();
    final cookieMap = storage.getCookieMap();
    final Map<String, String> headers = {};

    if (cookieMap != null) {
      final cookieHeader = cookieMap.entries
          .map((e) => "${e.key}=${e.value}")
          .join("; ");
      headers["Cookie"] = cookieHeader;
    }

    return Container(
      height: size.height * 0.9,
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
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
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.of(context).slate600,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1.h),

          // Body (Image Viewer with floating zoom controls)
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRect(
                    child: InteractiveViewer(
                      transformationController: _transformationController,
                      minScale: 0.5,
                      maxScale: 5.0,
                      child: Center(
                        child: isLocal
                            ? Image.file(
                                localFile,
                                fit: BoxFit.contain,
                              )
                            : Image.network(
                                finalUrl,
                                headers: headers,
                                fit: BoxFit.contain,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: AppColors.of(context).error,
                                        size: 48.w,
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                        l10n.somethingWentWrong,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),

                // Floating Zoom Controls
                Positioned(
                  bottom: 24.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.of(context)
                            .slate800
                            .withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: _zoomOut,
                            icon: const Icon(
                              Icons.zoom_out,
                              color: Colors.white,
                            ),
                            tooltip: 'Zoom Out',
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            onPressed: _resetZoom,
                            icon: const Icon(
                              Icons.zoom_in_map,
                              color: Colors.white,
                            ),
                            tooltip: 'Reset Zoom',
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            onPressed: _zoomIn,
                            icon: const Icon(
                              Icons.zoom_in,
                              color: Colors.white,
                            ),
                            tooltip: 'Zoom In',
                          ),
                        ],
                      ),
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
