import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/notification_settings_model.dart';
import '../../domain/entities/notification_settings_entity.dart';
import '../../domain/repositories/notification_settings_repository.dart';

class NotificationSettingsRepository implements INotificationSettingsRepository {
  final SharedPreferences _prefs;
  static const String _key = 'notification_settings';

  NotificationSettingsRepository(this._prefs);

  @override
  Future<NotificationSettingsEntity> getSettings() async {
    final String? jsonString = _prefs.getString(_key);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        return NotificationSettingsModel.fromJson(jsonMap).toEntity();
      } catch (e) {
        // Fallback to initial if decoding fails
      }
    }
    return _getInitialSettings();
  }

  @override
  Future<void> saveSettings(NotificationSettingsEntity settings) async {
    final model = settings.toModel();
    final jsonString = json.encode(model.toJson());
    await _prefs.setString(_key, jsonString);
  }

  NotificationSettingsEntity _getInitialSettings() {
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
}
