import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/theme_bloc.dart';
import '../bloc/theme_event.dart';
import '../bloc/theme_state.dart';
import '../widgets/theme_selection_grid.dart';
import '../widgets/accent_color_section.dart';

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
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: AppColors.themeModeNotifier,
        builder: (context, mode, child) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: CommonAppBar(
              title: l10n.settings,
            ),
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p24, vertical: AppConstants.p32),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Header Section
                      Text(
                        l10n.appearance,
                        style: AppTextStyle.h1.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: AppConstants.p12),
                      Text(
                        l10n.appearanceDesc,
                        style: AppTextStyle.bodyLarge.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Theme Selection Grid
                      const ThemeSelectionGrid(),

                      const SizedBox(height: 64),

                      // Accent Color Section
                      const AccentColorSection(),

                      const SizedBox(height: 80),
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

