import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';

class CommonWebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const CommonWebViewScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<CommonWebViewScreen> createState() => _CommonWebViewScreenState();
}

class _CommonWebViewScreenState extends State<CommonWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (!mounted) return;
            setState(() {
              _progress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            if (!mounted) return;
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        backgroundColor: AppColors.of(context).surfaceContainerLowest,
        surfaceTintColor: AppColors.of(context).transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: AppColors.of(context).onSurfaceVariant,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: AppTextStyle.h3.copyWith(
            color: AppColors.of(context).onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: _isLoading
              ? LinearProgressIndicator(
                  value: _progress > 0 ? _progress : null,
                  backgroundColor: AppColors.of(context).surfaceContainerLow,
                  color: AppColors.of(context).primary,
                  minHeight: 2,
                )
              : Container(
                  color: AppColors.of(context).slate200.withValues(alpha: 0.5),
                  height: 1.h,
                ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
