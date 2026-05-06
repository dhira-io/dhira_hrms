import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/bloc/theme_cubit.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_state.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/settings_state.dart';
import 'settings_group_widget.dart';
import 'settings_item_widget.dart';
import 'settings_profile_card.dart';
import 'settings_skeleton.dart';
import '../../data/constants/webview_urls.dart';


class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SettingsSkeleton();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 120.0),
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  final profile = profileState.maybeWhen(
                    loaded: (profile) => profile,
                    orElse: () => null,
                  );
                  return SettingsProfileCard(
                    profile: profile,
                    onEditTap: () {
                      context.push(AppRouter.profilePath);
                    },
                  );
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
                      context.push(AppRouter.profilePath);
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.lock_outline,
                    title: l10n.privacyAndSecurity,
                    onTap: () {
                      context.push(
                        AppRouter.commonWebViewPath,
                        extra: {
                          'url': SettingsWebViewUrls.privacyAndSecurity,
                          'title': l10n.privacyAndSecurity,
                        },
                      );
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
                    title: l10n.appearance,
                    value: context.watch<ThemeCubit>().state == ThemeMode.light
                        ? l10n.lightMode
                        : context.watch<ThemeCubit>().state == ThemeMode.dark
                            ? l10n.darkMode
                            : l10n.systemDefault,
                    onTap: () {
                      context.push(AppRouter.appearanceSelectionPath);
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
                      context.push(
                        AppRouter.commonWebViewPath,
                        extra: {
                          'url': SettingsWebViewUrls.aboutUs,
                          'title': l10n.aboutUs,
                        },
                      );
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.description_outlined,
                    title: l10n.termsAndConditions,
                    onTap: () {
                      context.push(
                        AppRouter.commonWebViewPath,
                        extra: {
                          'url': SettingsWebViewUrls.termsAndConditions,
                          'title': l10n.termsAndConditions,
                        },
                      );
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.help_outline,
                    title: l10n.helpCenter,
                    onTap: () {
                      context.push(
                        AppRouter.commonWebViewPath,
                        extra: {
                          'url': SettingsWebViewUrls.helpCenter,
                          'title': l10n.helpCenter,
                        },
                      );
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
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, authState) {
                        final isLoggingOut = authState.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isLoggingOut)
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
                        );
                      },
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
              context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
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
