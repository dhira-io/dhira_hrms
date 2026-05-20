import 'package:flutter/material.dart';
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
      appBar: CommonAppBar(
        title: l10n.settings,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Text(
              l10n.appearance,
              style: AppTextStyle.h1.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.appearanceDesc,
              style: AppTextStyle.bodyLarge.copyWith(
                color: AppColors.of(context).onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 48),
            
            // Theme Selection Grid (Using Wrap for responsiveness)
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                _ThemeCard(
                  title: l10n.lightMode,
                  subtitle: l10n.lightModeDesc,
                  icon: Icons.light_mode,
                  mode: ThemeMode.light,
                  isSelected: currentTheme == ThemeMode.light,
                  onTap: () => themeCubit.changeTheme(ThemeMode.light),
                  preview: const _ThemePreview(isDark: false),
                ),
                _ThemeCard(
                  title: l10n.darkMode,
                  subtitle: l10n.darkModeDesc,
                  icon: Icons.dark_mode,
                  mode: ThemeMode.dark,
                  isSelected: currentTheme == ThemeMode.dark,
                  onTap: () => themeCubit.changeTheme(ThemeMode.dark),
                  preview: const _ThemePreview(isDark: true),
                ),
                _ThemeCard(
                  title: l10n.systemDefault,
                  subtitle: l10n.systemDesc,
                  icon: Icons.settings_suggest,
                  mode: ThemeMode.system,
                  isSelected: currentTheme == ThemeMode.system,
                  onTap: () => themeCubit.changeTheme(ThemeMode.system),
                  preview: const _ThemePreview(isSplit: true),
                ),
              ],
            ),
            const SizedBox(height: 48),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - (MediaQuery.of(context).size.width > 768 ? 48 : 0)) / 
                     (MediaQuery.of(context).size.width > 768 ? 3 : 1);
        
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: width > 200 ? width : double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLowest,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.of(context).primary : AppColors.of(context).outlineVariant.withValues(alpha: 0.3),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.of(context).onSurface.withValues(alpha: 0.06),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        preview,
                        if (isSelected)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.of(context).primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check, color: Colors.white, size: 14),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.of(context).primaryFixed.withValues(alpha: 0.3) : AppColors.of(context).surfaceContainerHigh,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            color: isSelected ? AppColors.of(context).primary : AppColors.of(context).onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTextStyle.h3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                subtitle,
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: AppColors.of(context).onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
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
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.of(context).outlineVariant.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Expanded(child: _buildPreviewContent(context, false)),
              Container(width: 1, color: AppColors.of(context).outlineVariant.withValues(alpha: 0.1)),
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
    final cardColor = dark ? const Color(0xFF1E1F21) : Colors.white;
    final itemColor = dark ? Colors.white.withValues(alpha: 0.1) : AppColors.of(context).surfaceContainerHighest;
    final accentItemColor = dark ? AppColors.of(context).primary.withValues(alpha: 0.4) : AppColors.of(context).primary.withValues(alpha: 0.1);

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
