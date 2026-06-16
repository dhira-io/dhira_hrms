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
            id: 'push_leave_application',
            title: 'Leave Application',
            description: 'Real-time alerts delivered to your installed app',
            value: data['push_leave_application'] == 1,
          ),
          NotificationItemEntity(
            id: 'push_leave_application_team',
            title: 'Leave Application Team',
            description: 'Team alerts',
            value: data['push_leave_application_team'] == 1,
          ),
          NotificationItemEntity(
            id: 'push_attendance_regularization_request',
            title: 'Attendance Regularization',
            description: 'Real-time alerts delivered to your installed app',
            value: data['push_attendance_regularization_request'] == 1,
          ),
          NotificationItemEntity(
            id: 'push_attendance_regularization_request_team',
            title: 'Attendance Regularization Team',
            description: 'Team alerts',
            value: data['push_attendance_regularization_request_team'] == 1,
          ),
          NotificationItemEntity(
            id: 'push_employee_timesheet',
            title: 'Timesheet',
            description: 'Real-time alerts delivered to your installed app',
            value: data['push_employee_timesheet'] == 1,
          ),
          NotificationItemEntity(
            id: 'push_employee_timesheet_team',
            title: 'Timesheet Team',
            description: 'Team alerts',
            value: data['push_employee_timesheet_team'] == 1,
          ),
          NotificationItemEntity(
            id: 'push_compensatory_leave_request',
            title: 'Comp-Off Request',
            description: 'Real-time alerts delivered to your installed app',
            value: data['push_compensatory_leave_request'] == 1,
          ),
          NotificationItemEntity(
            id: 'push_compensatory_leave_request_team',
            title: 'Comp-Off Request Team',
            description: 'Team alerts',
            value: data['push_compensatory_leave_request_team'] == 1,
          ),
        ],
      ),
      NotificationSectionEntity(
        id: NotificationSettingsConstants.sectionEmail,
        title: NotificationSettingsConstants.l10nEmailAlerts,
        iconKey: NotificationSettingsConstants.iconMail,
        items: [
          NotificationItemEntity(
            id: 'email_leave_application',
            title: 'Leave Application',
            description: 'Formal email notifications for your records',
            value: data['email_leave_application'] == 1,
          ),
          NotificationItemEntity(
            id: 'email_leave_application_team',
            title: 'Leave Application Team',
            description: 'Team email alerts',
            value: data['email_leave_application_team'] == 1,
          ),
          NotificationItemEntity(
            id: 'email_attendance_regularization_request',
            title: 'Attendance Regularization',
            description: 'Formal email notifications for your records',
            value: data['email_attendance_regularization_request'] == 1,
          ),
          NotificationItemEntity(
            id: 'email_attendance_regularization_request_team',
            title: 'Attendance Regularization Team',
            description: 'Team email alerts',
            value: data['email_attendance_regularization_request_team'] == 1,
          ),
          NotificationItemEntity(
            id: 'email_employee_timesheet',
            title: 'Timesheet',
            description: 'Formal email notifications for your records',
            value: data['email_employee_timesheet'] == 1,
          ),
          NotificationItemEntity(
            id: 'email_employee_timesheet_team',
            title: 'Timesheet Team',
            description: 'Team email alerts',
            value: data['email_employee_timesheet_team'] == 1,
          ),
          NotificationItemEntity(
            id: 'email_compensatory_leave_request',
            title: 'Comp-Off Request',
            description: 'Formal email notifications for your records',
            value: data['email_compensatory_leave_request'] == 1,
          ),
          NotificationItemEntity(
            id: 'email_compensatory_leave_request_team',
            title: 'Comp-Off Request Team',
            description: 'Team email alerts',
            value: data['email_compensatory_leave_request_team'] == 1,
          ),
        ],
      ),
    ];
  }
}
