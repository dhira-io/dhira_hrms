import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/settings/presentation/bloc/notification_settings_cubit.dart';
import 'package:dhira_hrms/features/settings/presentation/bloc/notification_settings_state.dart';
import 'package:dhira_hrms/features/settings/presentation/widgets/notification_preferences_skeleton.dart';
import 'package:dhira_hrms/features/settings/presentation/widgets/notification_preferences_table.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/settings/data/constants/notification_settings_constants.dart';

class NotificationPreferencesScreen extends StatelessWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).slate100,
      appBar: CommonAppBar(
        title:
            AppLocalizations.of(context)?.notificationPreferences ??
            NotificationSettingsConstants.defaultAppBarTitle,
      ),
      body: BlocConsumer<NotificationSettingsCubit, NotificationSettingsState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (settings, isManager, isActionLoading, errorMessage) {
              if (errorMessage != null) {
                ToastUtils.showError(errorMessage);
                context.read<NotificationSettingsCubit>().clearError();
              }
            },
            error: (message) {
              ToastUtils.showError(message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const NotificationPreferencesSkeleton(isManager: false),
            error: (message) => Center(child: Text(message)),
            loaded: (settings, isManager, isActionLoading, errorMessage) {
              final pushSection = settings.sections.firstWhereOrNull(
                (s) => s.id == NotificationSettingsConstants.sectionPush,
              );
              final emailSection = settings.sections.firstWhereOrNull(
                (s) => s.id == NotificationSettingsConstants.sectionEmail,
              );

              return RefreshIndicator(
                onRefresh: () =>
                    context.read<NotificationSettingsCubit>().loadSettings(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (pushSection != null)
                        NotificationPreferencesTable(
                          title: AppLocalizations.of(context)!.pushNotifications,
                          icon: Icons.notifications_active_outlined,
                          section: pushSection,
                          isManager: isManager,
                          isActionLoading: isActionLoading,
                        ),
                      if (pushSection != null && emailSection != null)
                        SizedBox(height: 40.h),
                      if (emailSection != null)
                        NotificationPreferencesTable(
                          title: AppLocalizations.of(context)!.emailAlerts,
                          icon: Icons.mail_outline_outlined,
                          section: emailSection,
                          isManager: isManager,
                          isActionLoading: isActionLoading,
                        ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
