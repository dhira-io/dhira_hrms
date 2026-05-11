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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.viewerUrl)),
          onLoadStop: (controller, url) {
            setState(() {
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
