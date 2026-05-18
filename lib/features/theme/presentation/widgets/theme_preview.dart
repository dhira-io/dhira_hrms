import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ThemePreview extends StatelessWidget {
  final bool isDark;
  final bool isSplit;

  const ThemePreview({super.key, this.isDark = false, this.isSplit = false});

  @override
  Widget build(BuildContext context) {
    if (isSplit) {
      return AspectRatio(
        aspectRatio: 16 / 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Expanded(child: _buildPreviewContent(false)),
              Container(width: 1, color: AppColors.outlineVariant.withValues(alpha: 0.1)),
              Expanded(child: _buildPreviewContent(true)),
            ],
          ),
        ),
      );
    }
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: _buildPreviewContent(isDark),
    );
  }

  Widget _buildPreviewContent(bool dark) {
    final bgColor = dark ? AppColors.themePreviewBgDark : AppColors.themePreviewBgLight;
    final cardColor = dark ? AppColors.themePreviewCardDark : AppColors.white;
    final itemColor = dark ? AppColors.white.withValues(alpha: 0.1) : AppColors.surfaceContainerHighest;
    final accentItemColor = dark ? AppColors.primary.withValues(alpha: 0.4) : AppColors.primary.withValues(alpha: 0.1);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: isSplit ? BorderRadius.zero : BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 12,
              decoration: BoxDecoration(
                color: itemColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  if (!dark)
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 80, height: 4, decoration: BoxDecoration(color: itemColor, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 6),
                  Container(width: 100, height: 4, decoration: BoxDecoration(color: itemColor, borderRadius: BorderRadius.circular(2))),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: accentItemColor, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 6),
                  Container(width: 90, height: 4, decoration: BoxDecoration(color: itemColor, borderRadius: BorderRadius.circular(2))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
