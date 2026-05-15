import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/theme_bloc.dart';
import '../bloc/theme_event.dart';
import '../bloc/theme_state.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (message, _) => ToastUtils.showSuccess(message),
          error: (message) => ToastUtils.showError(message),
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CommonAppBar(
          title: l10n.settings,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Header Section
                  Text(
                    l10n.appearance,
                    style: AppTextStyle.h1.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    l10n.appearanceDesc,
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: AppColors.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Theme Selection Grid
                  const _ThemeSelectionGrid(),

                  const SizedBox(height: 64),

                  // Accent Color Section
                  const _AccentColorSection(),

                  const SizedBox(height: 80),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSelectionGrid extends StatelessWidget {
  const _ThemeSelectionGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _ThemeCardSelector(
          title: l10n.lightMode,
          subtitle: l10n.lightModeDesc,
          icon: Icons.light_mode,
          mode: ThemeMode.light,
          preview: const _ThemePreview(isDark: false),
        ),
        _ThemeCardSelector(
          title: l10n.darkMode,
          subtitle: l10n.darkModeDesc,
          icon: Icons.dark_mode,
          mode: ThemeMode.dark,
          preview: const _ThemePreview(isDark: true),
        ),
        _ThemeCardSelector(
          title: l10n.systemDefault,
          subtitle: l10n.systemDesc,
          icon: Icons.settings_suggest,
          mode: ThemeMode.system,
          preview: const _ThemePreview(isSplit: true),
        ),
      ],
    );
  }
}

class _ThemeCardSelector extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ThemeMode mode;
  final Widget preview;

  const _ThemeCardSelector({
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
        return _ThemeCard(
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
        final screenWidth = MediaQuery.of(context).size.width;
        final width = (constraints.maxWidth - (screenWidth > 768 ? 48 : 0)) / 
                     (screenWidth > 768 ? 3 : 1);
        
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
                  offset: Offset(0, 12),
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
                              child: Icon(Icons.check, color: Colors.white, size: 14),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                        SizedBox(width: 12),
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
    final bgColor = dark ? const Color(0xFF2C2E30) : const Color(0xFFF1F3F5);
    final cardColor = dark ? const Color(0xFF1E1F21) : Colors.white;
    final itemColor = dark ? Colors.white.withValues(alpha: 0.1) : AppColors.surfaceContainerHighest;
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

class _AccentColorSection extends StatelessWidget {
  const _AccentColorSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
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
          SizedBox(height: 4),
          Text(
            l10n.accentColorDesc,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              _AccentColorButton(color: Color(0xFF0047cc), isSelected: true),
              SizedBox(width: 16),
              _AccentColorButton(color: Color(0xFF006A60)),
              SizedBox(width: 16),
              _AccentColorButton(color: Color(0xFF8C1D18)),
              SizedBox(width: 16),
              _AccentColorButton(color: Color(0xFF6750A4)),
            ],
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
