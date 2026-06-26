import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';

class OfficeDocViewer extends StatefulWidget {
  final String viewerUrl;

  const OfficeDocViewer({super.key, required this.viewerUrl});

  @override
  State<OfficeDocViewer> createState() => _OfficeDocViewerState();
}

class _OfficeDocViewerState extends State<OfficeDocViewer> {
  bool _isLoading = true;
  bool _hasError = false;
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: colors.error,
              size: 48,
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.somethingWentWrong,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(l10n.useBrowserToViewFile),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _isLoading = true;
                });
                _webViewController?.reload();
              },
              child: Text(l10n.reload),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.viewerUrl)),
          onWebViewCreated: (controller) => _webViewController = controller,
          onLoadStop: (controller, url) {
            setState(() {
              _isLoading = false;
            });
          },
          onRenderProcessGone: (controller, detail) {
            setState(() {
              _hasError = true;
              _isLoading = false;
            });
          },
        ),
        if (_isLoading)
          Container(
            color: colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: ShimmerLoading(
                      width: 50.w,
                      height: 50.h,
                      borderRadius: 25,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(l10n.loadingDocument),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
