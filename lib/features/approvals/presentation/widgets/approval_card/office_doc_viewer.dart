import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OfficeDocViewer extends StatefulWidget {
  final String viewerUrl;

  const OfficeDocViewer({
    super.key,
    required this.viewerUrl,
  });

  @override
  State<OfficeDocViewer> createState() => _OfficeDocViewerState();
}

class _OfficeDocViewerState extends State<OfficeDocViewer> {
  bool _isLoading = true;
  bool _hasError = false;
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (_hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text(l10n.somethingWentWrong, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(l10n.useBrowserToViewFile),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _isLoading = true;
                });
                _webViewController?.reload();
              },
              child: const Text('Reload'),
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
            color: AppColors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.loadingDocument),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
