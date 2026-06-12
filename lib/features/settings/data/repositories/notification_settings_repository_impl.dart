import '../../../../core/network/dio_client.dart';
import '../constants/notification_settings_api_constants.dart';
import '../constants/notification_settings_constants.dart';
import '../../domain/entities/notification_settings_entity.dart';
import '../../domain/repositories/notification_settings_repository.dart';

class NotificationSettingsRepository
    implements INotificationSettingsRepository {
  final DioClient _dioClient;

  NotificationSettingsRepository(this._dioClient);

  @override
  Future<NotificationSettingsEntity> getSettings() async {
    try {
      final response = await _dioClient.get(NotificationSettingsApiConstants.getPreferences);
      final data = response.data['message'];
      
      if (data == null || data is! Map<String, dynamic>) {
        return NotificationSettingsEntity.initial().copyWith(
          sections: _createDefaultSections({}), // Return default structure with empty data
        );
      }
      
      return _mapApiToEntity(data);
    } catch (e) {
      // Re-throw to be caught by Cubit
      rethrow;
    }
  }

  @override
  Future<void> saveSettings(NotificationSettingsEntity settings) async {
  }

  @override
  Future<void> updateItem(String field, bool value) async {
    await _dioClient.post(
      NotificationSettingsApiConstants.updatePreference,
      data: {
        NotificationSettingsConstants.apiKeyField: field,
        NotificationSettingsConstants.apiKeyValue: value ? 1 : 0,
      },
    );
  }

  NotificationSettingsEntity _mapApiToEntity(Map<String, dynamic> data) {
    return NotificationSettingsEntity(
      sections: _createDefaultSections(data),
    );
  }

  List<NotificationSectionEntity> _createDefaultSections(Map<String, dynamic> data) {
    return [
      NotificationSectionEntity(
        id: NotificationSettingsConstants.sectionPush,
        title: NotificationSettingsConstants.l10nPushNotifications,
        iconKey: NotificationSettingsConstants.iconNotificationsActive,
        items: [
          NotificationItemEntity(
            id: NotificationSettingsConstants.pushAttendance,
            title: NotificationSettingsConstants.l10nAttendance,
            description: NotificationSettingsConstants.l10nAttendancePushDesc,
            value: data[NotificationSettingsConstants.pushAttendance] == 1,
          ),
          NotificationItemEntity(
            id: NotificationSettingsConstants.pushLeave,
            title: NotificationSettingsConstants.l10nLeave,
            description: NotificationSettingsConstants.l10nLeavePushDesc,
            value: data[NotificationSettingsConstants.pushLeave] == 1,
          ),
          NotificationItemEntity(
            id: NotificationSettingsConstants.pushTimesheet,
            title: NotificationSettingsConstants.l10nTimesheetReminders,
            description: NotificationSettingsConstants.l10nTimesheetPushDesc,
            value: data[NotificationSettingsConstants.pushTimesheet] == 1,
          ),
          NotificationItemEntity(
            id: NotificationSettingsConstants.pushCompOff,
            title: NotificationSettingsConstants.l10nGeneralAnnouncements,
            description: NotificationSettingsConstants.l10nGeneralPushDesc,
            value: data[NotificationSettingsConstants.pushCompOff] == 1,
          ),
        ],
      ),
      NotificationSectionEntity(
        id: NotificationSettingsConstants.sectionEmail,
        title: NotificationSettingsConstants.l10nEmailAlerts,
        iconKey: NotificationSettingsConstants.iconMail,
        items: [
          NotificationItemEntity(
            id: NotificationSettingsConstants.emailAttendance,
            title: NotificationSettingsConstants.l10nAttendance,
            description: NotificationSettingsConstants.l10nAttendanceEmailDesc,
            value: data[NotificationSettingsConstants.emailAttendance] == 1,
          ),
          NotificationItemEntity(
            id: NotificationSettingsConstants.emailLeave,
            title: NotificationSettingsConstants.l10nLeave,
            description: NotificationSettingsConstants.l10nLeaveEmailDesc,
            value: data[NotificationSettingsConstants.emailLeave] == 1,
          ),
          NotificationItemEntity(
            id: NotificationSettingsConstants.emailTimesheet,
            title: NotificationSettingsConstants.l10nTimesheetReminders,
            description: NotificationSettingsConstants.l10nTimesheetEmailDesc,
            value: data[NotificationSettingsConstants.emailTimesheet] == 1,
          ),
          NotificationItemEntity(
            id: NotificationSettingsConstants.emailCompOff,
            title: NotificationSettingsConstants.l10nGeneralAnnouncements,
            description: NotificationSettingsConstants.l10nGeneralEmailDesc,
            value: data[NotificationSettingsConstants.emailCompOff] == 1,
          ),
        ],
      ),
    ];
  }
}
