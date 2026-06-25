import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/theme_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';

class AppearanceSelectionScreen extends StatelessWidget {
  const AppearanceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeCubit = context.read<ThemeCubit>();
    final currentTheme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        backgroundColor: AppColors.of(context).surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: AppColors.of(context).onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.appearanceSettings,
            style: TextStyle(
              color: AppColors.of(context).onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Options Cards

            // Appearance Options Cards
            Column(
              children: [
                _ThemeCard(
                  title: l10n.lightMode,
                  subtitle: 'Clean and bright',
                  icon: Icons.light_mode_outlined,
                  mode: ThemeMode.light,
                  isSelected: currentTheme == ThemeMode.light,
                  onTap: () => themeCubit.changeTheme(ThemeMode.light),
                  preview: const _ThemePreview(isDark: false),
                ),
                SizedBox(height: 16.h),
                _ThemeCard(
                  title: l10n.darkMode,
                  subtitle: 'Easy to see',
                  icon: Icons.dark_mode_outlined,
                  mode: ThemeMode.dark,
                  isSelected: currentTheme == ThemeMode.dark,
                  onTap: () => themeCubit.changeTheme(ThemeMode.dark),
                  preview: const _ThemePreview(isDark: true),
                ),
                SizedBox(height: 16.h),
                _ThemeCard(
                  title: l10n.systemDefault,
                  subtitle: 'Matches OS setting',
                  icon: Icons.auto_awesome_outlined,
                  mode: ThemeMode.system,
                  isSelected: currentTheme == ThemeMode.system,
                  onTap: () => themeCubit.changeTheme(ThemeMode.system),
                  preview: const _ThemePreview(isSplit: true),
                ),
              ],
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ThemeMode mode;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget preview;

  const _ThemeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.mode,
    required this.isSelected,
    required this.onTap,
    required this.preview,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.of(context).primaryContainer.withValues(alpha: 0.5)
                : AppColors.of(context).outlineVariant.withValues(alpha: 0.3),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected 
            ? [
                BoxShadow(
                  color: AppColors.of(context).primaryContainer.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
        ),
            child: Row(
              children: [
                // Preview Image
                SizedBox(
                  width: 80.w,
                  height: 60.h,
                  child: preview,
                ),
                SizedBox(width: 16.w),
                // Icon
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.of(context).primaryContainer.withValues(alpha: 0.1)
                        : AppColors.of(context).surfaceContainerHigh.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? AppColors.of(context).primaryContainer
                        : AppColors.of(context).outline,
                    size: 16,
                  ),
                ),
            SizedBox(width: 12.w),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: AppColors.of(context).onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).outline,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Radio Button
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.of(context).brandPurple
                      : AppColors.of(context).outlineVariant,
                  width: isSelected ? 6.w : 2.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemePreview extends StatelessWidget {
  final bool isDark;
  final bool isSplit;

  const _ThemePreview({this.isDark = false, this.isSplit = false});

  @override
  Widget build(BuildContext context) {
    if (isSplit) {
      return AspectRatio(
        aspectRatio: 16 / 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.of(
                context,
              ).outlineVariant.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Expanded(child: _buildPreviewContent(context, false)),
              Container(
                width: 1.w,
                color: AppColors.of(
                  context,
                ).outlineVariant.withValues(alpha: 0.1),
              ),
              Expanded(child: _buildPreviewContent(context, true)),
            ],
          ),
        ),
      );
    }
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: _buildPreviewContent(context, isDark),
    );
  }

  Widget _buildPreviewContent(BuildContext context, bool dark) {
    final bgColor = dark ? const Color(0xFF2C2E30) : const Color(0xFFF1F3F5);
    final cardColor = dark ? const Color(0xFF1E1F21) : AppColors.of(context).surfaceContainerLowest;
    final itemColor = dark
        ? AppColors.of(context).white.withValues(alpha: 0.1)
        : AppColors.of(context).surfaceContainerHighest;
    final accentItemColor = dark
        ? AppColors.of(context).primary.withValues(alpha: 0.4)
        : AppColors.of(context).primary.withValues(alpha: 0.1);

    return Container(
      padding:       EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: isSplit ? BorderRadius.zero : BorderRadius.circular(12.r),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: itemColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
                  SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding:       EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  if (!dark)
                    BoxShadow(
                      color: AppColors.of(context).black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                        SizedBox(height: 6.h),
                  Container(
                    width: 100.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
            ),
                  SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding:       EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: accentItemColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                        SizedBox(height: 6.h),
                  Container(
                    width: 90.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: BorderRadius.circular(2.r),
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
