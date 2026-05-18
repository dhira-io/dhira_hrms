import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/theme_bloc.dart';
import '../bloc/theme_event.dart';
import '../bloc/theme_state.dart';
import 'theme_preview.dart';

class ThemeSelectionGrid extends StatelessWidget {
  const ThemeSelectionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: AppConstants.p24,
      runSpacing: AppConstants.p24,
      children: [
        ThemeCardSelector(
          title: l10n.lightMode,
          subtitle: l10n.lightModeDesc,
          icon: Icons.light_mode,
          mode: ThemeMode.light,
          preview: const ThemePreview(isDark: false),
        ),
        ThemeCardSelector(
          title: l10n.darkMode,
          subtitle: l10n.darkModeDesc,
          icon: Icons.dark_mode,
          mode: ThemeMode.dark,
          preview: const ThemePreview(isDark: true),
        ),
        ThemeCardSelector(
          title: l10n.systemDefault,
          subtitle: l10n.systemDesc,
          icon: Icons.settings_suggest,
          mode: ThemeMode.system,
          preview: const ThemePreview(isSplit: true),
        ),
      ],
    );
  }
}

class ThemeCardSelector extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ThemeMode mode;
  final Widget preview;

  const ThemeCardSelector({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.mode,
    required this.preview,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeBloc, ThemeState, bool>(
      selector: (state) {
        return state.maybeWhen(
          loaded: (currentMode) => currentMode == mode,
          success: (_, currentMode) => currentMode == mode,
          orElse: () => false,
        );
      },
      builder: (context, isSelected) {
        return ThemeCard(
          title: title,
          subtitle: subtitle,
          icon: icon,
          mode: mode,
          isSelected: isSelected,
          onTap: () => context.read<ThemeBloc>().add(ThemeEvent.themeChanged(mode)),
          preview: preview,
        );
      },
    );
  }
}

class ThemeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ThemeMode mode;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget preview;

  const ThemeCard({
    super.key,
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
        final screenWidth = MediaQuery.of(context).size.width;
        final width = (constraints.maxWidth - (screenWidth > 768 ? 48 : 0)) / 
                     (screenWidth > 768 ? 3 : 1);
        
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.r20),
          child: Container(
            width: width > 200 ? width : double.infinity,
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppConstants.r20),
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
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.check, color: AppColors.white, size: 14),
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
                            color: isSelected ? AppColors.primaryFixed.withValues(alpha: 0.3) : AppColors.surfaceContainerHigh,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
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
                                  color: AppColors.onSurfaceVariant,
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
