import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/notification_settings_entity.dart';
import 'notification_settings_state.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  NotificationSettingsCubit() : super(NotificationSettingsState(
    settings: _getStaticSettings(),
  ));

  static NotificationSettingsEntity _getStaticSettings() {
    return const NotificationSettingsEntity(
      sections: [
        NotificationSectionEntity(
          id: 'push',
          title: 'pushNotifications',
          iconKey: 'notifications_active',
          items: [
            NotificationItemEntity(
              id: 'push_attendance',
              title: 'attendance',
              description: 'attendancePushDesc',
              value: true,
            ),
            NotificationItemEntity(
              id: 'push_leave',
              title: 'leave',
              description: 'leavePushDesc',
              value: true,
            ),
            NotificationItemEntity(
              id: 'push_timesheet',
              title: 'timesheetReminders',
              description: 'timesheetPushDesc',
              value: false,
            ),
            NotificationItemEntity(
              id: 'push_general',
              title: 'generalAnnouncements',
              description: 'generalPushDesc',
              value: true,
            ),
          ],
        ),
        NotificationSectionEntity(
          id: 'email',
          title: 'emailAlerts',
          iconKey: 'mail',
          items: [
            NotificationItemEntity(
              id: 'email_attendance',
              title: 'attendance',
              description: 'attendanceEmailDesc',
              value: false,
            ),
            NotificationItemEntity(
              id: 'email_leave',
              title: 'leave',
              description: 'leaveEmailDesc',
              value: true,
            ),
            NotificationItemEntity(
              id: 'email_timesheet',
              title: 'timesheetReminders',
              description: 'timesheetEmailDesc',
              value: true,
            ),
            NotificationItemEntity(
              id: 'email_general',
              title: 'generalAnnouncements',
              description: 'generalEmailDesc',
              value: true,
            ),
          ],
        ),
      ],
    );
  }

  void toggleItem(String sectionId, String itemId, bool value) {
    if (state.settings == null) return;

    final updatedSections = state.settings!.sections.map((section) {
      if (section.id == sectionId) {
        final updatedItems = section.items.map((item) {
          if (item.id == itemId) {
            return item.copyWith(value: value);
          }
          return item;
        }).toList();
        return section.copyWith(items: updatedItems);
      }
      return section;
    }).toList();

    emit(state.copyWith(
      settings: state.settings!.copyWith(sections: updatedSections),
    ));
  }
}
