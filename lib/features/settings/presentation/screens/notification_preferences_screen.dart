import 'package:dhira_hrms/core/constants/app_constants.dart';
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

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  @override
  IconData _getIconData(String key) {
    switch (key) {
      case 'notifications_active':
        return Icons.notifications_active;
      case 'mail':
        return Icons.mail;
      case 'settings':
        return Icons.settings;
      default:
        return Icons.notifications;
    }
  }

  String _getLocalizedText(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    // Map of keys to l10n getters
    final map = {
      'pushNotifications': l10n.pushNotifications,
      'emailAlerts': l10n.emailAlerts,
      'attendance': l10n.attendance,
      'leave': l10n.leave,
      'timesheetReminders': l10n.timesheetReminders,
      'generalAnnouncements': l10n.generalAnnouncements,
      'attendancePushDesc': l10n.attendancePushDesc,
      'leavePushDesc': l10n.leavePushDesc,
      'timesheetPushDesc': l10n.timesheetPushDesc,
      'generalPushDesc': l10n.generalPushDesc,
      'attendanceEmailDesc': l10n.attendanceEmailDesc,
      'leaveEmailDesc': l10n.leaveEmailDesc,
      'timesheetEmailDesc': l10n.timesheetEmailDesc,
      'generalEmailDesc': l10n.generalEmailDesc,
    };
    return map[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.of(context).surfaceContainerLow,
      appBar: CommonAppBar(title: l10n.settings),
      body: BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
        builder: (context, state) {
          if (state.isLoading && state.settings == null) {
            return const NotificationPreferencesSkeleton();
          }

          if (state.settings == null) {
            return Center(child: Text(l10n.failedToLoadSettings));
          }

          final settings = state.settings!;

          return SingleChildScrollView(
            padding:       EdgeInsets.all(24.0.w),
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
                    padding:       EdgeInsets.only(bottom: 32.0.h),
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
          );
        },
      ),
    );
  }
}
