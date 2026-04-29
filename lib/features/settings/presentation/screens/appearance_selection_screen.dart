import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/theme_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class AppearanceSelectionScreen extends StatelessWidget {
  const AppearanceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeCubit = context.read<ThemeCubit>();
    final currentTheme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.slate500),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.settings,
          style: AppTextStyle.h3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.slate500),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.slate200.withValues(alpha: 0.5),
            height: 1,
          ),
        ),
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
                color: AppColors.onSurfaceVariant,
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
            
            const SizedBox(height: 64),
            
            // Accent Color Section
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.accentColor,
                    style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.accentColorDesc,
                    style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _AccentColorButton(color: const Color(0xFF0047cc), isSelected: true),
                      const SizedBox(width: 16),
                      _AccentColorButton(color: const Color(0xFF006A60)),
                      const SizedBox(width: 16),
                      _AccentColorButton(color: const Color(0xFF8C1D18)),
                      const SizedBox(width: 16),
                      _AccentColorButton(color: const Color(0xFF6750A4)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
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
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.outlineVariant.withValues(alpha: 0.3),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.onSurface.withValues(alpha: 0.06),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              children: [
                if (isSelected)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 18),
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    preview,
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryFixed : AppColors.surfaceContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTextStyle.h3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                subtitle,
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: AppColors.onSurfaceVariant,
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
      return Container(
        height: 120,
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
      );
    }
    return _buildPreviewContent(isDark);
  }

  Widget _buildPreviewContent(bool dark) {
    final bgColor = dark ? const Color(0xFF1E2022) : AppColors.surfaceContainerLow;
    final cardColor = dark ? const Color(0xFF2E3132) : AppColors.surfaceContainerLowest;
    final itemColor = dark ? AppColors.onSurfaceVariant.withValues(alpha: 0.3) : AppColors.surfaceContainerHighest;

    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: isSplit ? BorderRadius.zero : BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 30, height: 10, decoration: BoxDecoration(color: itemColor, borderRadius: BorderRadius.circular(5))),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                if (!dark) BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 20, height: 4, decoration: BoxDecoration(color: itemColor, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 4),
                Container(width: 30, height: 4, decoration: BoxDecoration(color: itemColor, borderRadius: BorderRadius.circular(2))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccentColorButton extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const _AccentColorButton({required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        boxShadow: isSelected ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
      ),
      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
    );
  }
}
