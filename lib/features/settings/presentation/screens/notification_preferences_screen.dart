import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/notification_settings_cubit.dart';
import '../bloc/notification_settings_state.dart';
import '../widgets/notification_section_widget.dart';
import '../widgets/notification_toggle_item_widget.dart';
import '../widgets/notification_preferences_skeleton.dart';
import '../../../../core/widgets/common_app_bar.dart';

import '../../data/constants/notification_settings_constants.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  IconData _getIconData(String key) {
    if (key == NotificationSettingsConstants.iconNotificationsActive) {
      return Icons.notifications_active;
    } else if (key == NotificationSettingsConstants.iconMail) {
      return Icons.mail;
    } else if (key == NotificationSettingsConstants.iconSettings) {
      return Icons.settings;
    }
    return Icons.notifications;
  }

  String _getLocalizedText(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    // Map of keys to l10n getters
    final map = {
      NotificationSettingsConstants.l10nPushNotifications: l10n.pushNotifications,
      NotificationSettingsConstants.l10nEmailAlerts: l10n.emailAlerts,
      NotificationSettingsConstants.l10nAttendance: l10n.attendance,
      NotificationSettingsConstants.l10nLeave: l10n.leave,
      NotificationSettingsConstants.l10nTimesheetReminders: l10n.timesheetReminders,
      NotificationSettingsConstants.l10nGeneralAnnouncements: l10n.generalAnnouncements,
      NotificationSettingsConstants.l10nAttendancePushDesc: l10n.attendancePushDesc,
      NotificationSettingsConstants.l10nLeavePushDesc: l10n.leavePushDesc,
      NotificationSettingsConstants.l10nTimesheetPushDesc: l10n.timesheetPushDesc,
      NotificationSettingsConstants.l10nGeneralPushDesc: l10n.generalPushDesc,
      NotificationSettingsConstants.l10nAttendanceEmailDesc: l10n.attendanceEmailDesc,
      NotificationSettingsConstants.l10nLeaveEmailDesc: l10n.leaveEmailDesc,
      NotificationSettingsConstants.l10nTimesheetEmailDesc: l10n.timesheetEmailDesc,
      NotificationSettingsConstants.l10nGeneralEmailDesc: l10n.generalEmailDesc,
    };
    return map[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.of(context).surfaceContainerLow,
      appBar: CommonAppBar(title: l10n.settings),
      body: BlocConsumer<NotificationSettingsCubit, NotificationSettingsState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.settings == null) {
            return const NotificationPreferencesSkeleton();
          }

          if (state.settings == null) {
            return Center(
              child: Text(l10n.failedToLoadSettings),
            );
          }

          final settings = state.settings!;

          return RefreshIndicator(
            onRefresh: () =>
                context.read<NotificationSettingsCubit>().loadSettings(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(24.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.notificationPreferences,
                    style: AppTextStyle.h1.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    l10n.notificationDesc,
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: AppColors.of(context).onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  ...settings.sections.map((section) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 32.0.h),
                      child: NotificationSectionWidget(
                        title: _getLocalizedText(context, section.title),
                        icon: _getIconData(section.iconKey),
                        children: section.items.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Column(
                            children: [
                              NotificationToggleItemWidget(
                                title: _getLocalizedText(context, item.title),
                                description: _getLocalizedText(
                                  context,
                                  item.description,
                                ),
                                value: item.value,
                                isLoading: item.isLoading,
                                isDisabled: state.isActionLoading,
                                onToggle: (val) => context
                                    .read<NotificationSettingsCubit>()
                                    .toggleItem(section.id, item.id, val),
                              ),
                              if (index < section.items.length - 1)
                                Divider(
                                  height: 1.h,
                                  color: AppColors.slate100,
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
