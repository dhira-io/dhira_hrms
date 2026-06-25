import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/bloc/theme_cubit.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
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
import '../../../../core/presentation/dialogs/logout_alert_dialog.dart';

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
          padding:       EdgeInsets.only(
            left: 16.0.w,
            right: 16.0.w,
            top: 16.0.h,
            bottom: 10.0.h,
          ),
          child: Column(
            children: [
              SettingsGroupWidget(
                title: l10n.preferences,
                items: [
                  SettingsItemWidget(
                    icon: Icons.notifications_none_outlined,
                    title: l10n.notifications,
                    iconColor: const Color(0xFF3B82F6),
                    onTap: () {
                      context.push(AppRouter.notificationPreferencesPath);
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.language_outlined,
                    title: l10n.language,
                    iconColor: const Color(0xFF10B981),
                    value: l10n.localeName == 'en' ? 'English' : 'हिन्दी',
                    onTap: () {
                      context.push(AppRouter.languageSelectionPath);
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.palette_outlined,
                    title: l10n.appearance,
                    iconColor: AppColors.of(context).brandPurple,
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
              SizedBox(height: 24.h),
              SettingsGroupWidget(
                title: l10n.information,
                items: [
                  SettingsItemWidget(
                    icon: Icons.error_outline,
                    title: l10n.aboutUs,
                    iconColor: const Color(0xFFEC4899),
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
                    iconColor: const Color(0xFFF59E0B),
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
                    iconColor: AppColors.of(context).brandPurple,
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
                    SizedBox(height: 24.h),
              Padding(
                padding:       EdgeInsets.only(top: 4.0.h),
                child: InkWell(
                  onTap: () => _showLogoutConfirmation(context),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: double.infinity,
                    padding:       EdgeInsets.all(16.0.w),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.of(
                            context,
                          ).onSurface.withValues(alpha: 0.02),
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
                              SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.of(context).error,
                                  ),
                                ),
                              )
                            else ...[
                              Icon(
                                Icons.logout,
                                color: AppColors.of(context).error,
                              ),
                                    SizedBox(width: 8.w),
                              Text(
                                l10n.logout,
                                style: TextStyle(
                                  color: AppColors.of(context).error,
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
                  //  SizedBox(height: 32.h),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    LogoutAlertDialog.show(context);
  }
}
