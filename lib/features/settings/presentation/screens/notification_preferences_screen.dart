import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/notification_settings_cubit.dart';
import '../bloc/notification_settings_state.dart';
import '../widgets/notification_section_widget.dart';
import '../widgets/notification_toggle_item_widget.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() => _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState extends State<NotificationPreferencesScreen> {
  @override
  void initState() {
    super.initState();
  }

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
      backgroundColor: AppColors.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
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
            icon: const Icon(Icons.more_vert, color: AppColors.primary),
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
      body: BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
        builder: (context, state) {
          if (state.isLoading && state.settings == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.settings == null) {
            return const Center(child: Text('Failed to load settings'));
          }

          final settings = state.settings!;
          final cubit = context.read<NotificationSettingsCubit>();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.notificationPreferences,
                  style: AppTextStyle.h1.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.notificationDesc,
                  style: AppTextStyle.bodyLarge.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 40),
                ...settings.sections.map((section) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
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
                              description: _getLocalizedText(context, item.description),
                              value: item.value,
                              onToggle: (val) => cubit.toggleItem(section.id, item.id, val),
                            ),
                            if (index < section.items.length - 1)
                              const Divider(height: 1, color: AppColors.slate100),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }
}
