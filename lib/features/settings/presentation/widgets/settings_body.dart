import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/settings_state.dart';
import 'settings_group_widget.dart';
import 'settings_item_widget.dart';
import 'settings_profile_card.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state.isLoading && state.userProfile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 120.0),
          child: Column(
            children: [
              SettingsProfileCard(
                profile: state.userProfile,
                onEditTap: () {
                  // TODO: Navigate to profile edit
                },
              ),
              const SizedBox(height: 24),
              SettingsGroupWidget(
                title: l10n.account,
                items: [
                  SettingsItemWidget(
                    icon: Icons.person_outline,
                    title: l10n.profile,
                    onTap: () {
                      // TODO: Navigate to profile
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.lock_outline,
                    title: l10n.privacyAndSecurity,
                    onTap: () {
                      // TODO: Navigate to privacy
                    },
                    showDivider: false,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SettingsGroupWidget(
                title: l10n.preferences,
                items: [
                  SettingsItemWidget(
                    icon: Icons.notifications_none,
                    title: l10n.notifications,
                    onTap: () {
                      context.push(AppRouter.notificationPreferencesPath);
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.language,
                    title: l10n.language,
                    value: l10n.localeName == 'en' ? 'English' : 'हिन्दी',
                    onTap: () {
                      context.push(AppRouter.languageSelectionPath);
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.palette_outlined,
                    title: l10n.theme,
                    value: l10n.light, // TODO: Get from LocalStorage
                    onTap: () {
                      // TODO: Show theme picker
                    },
                    showDivider: false,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SettingsGroupWidget(
                title: l10n.information,
                items: [
                  SettingsItemWidget(
                    icon: Icons.info_outline,
                    title: l10n.aboutUs,
                    onTap: () {
                      // TODO: Navigate to about us
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.description_outlined,
                    title: l10n.termsAndConditions,
                    onTap: () {
                      // TODO: Navigate to T&C
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.help_outline,
                    title: l10n.helpCenter,
                    onTap: () {
                      // TODO: Navigate to help center
                    },
                    showDivider: false,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: InkWell(
                  onTap: () => _showLogoutConfirmation(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.onSurface.withValues(alpha: 0.02),
                          blurRadius: 32,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.isActionLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.error),
                            ),
                          )
                        else ...[
                          const Icon(Icons.logout, color: AppColors.error),
                          const SizedBox(width: 8),
                          Text(
                            l10n.logout,
                            style: const TextStyle(
                              color: AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmLogout),
        content: Text(l10n.punchOutConfirmation('')), // Reusing string, might need adjustment
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SettingsCubit>().logout();
            },
            child: Text(
              l10n.logout,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
