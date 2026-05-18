import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class ImagePreviewDialog extends StatelessWidget {
  final String imageUrl;
  final Map<String, String>? headers;

  const ImagePreviewDialog({
    super.key,
    required this.imageUrl,
    this.headers,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppConstants.p16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InteractiveViewer(
            child: Image.network(
              imageUrl,
              headers: headers,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                padding: const EdgeInsets.all(AppConstants.p20),
                decoration: BoxDecoration(
                  color: AppColors.of(context).white,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline,
                        color: AppColors.of(context).error, size: 48),
                    const SizedBox(height: AppConstants.p16),
                    Text(
                      AppLocalizations.of(context)!.failedToLoadImage,
                      style: AppTextStyle.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
