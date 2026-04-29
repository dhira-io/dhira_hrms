import '../entities/notification_settings_entity.dart';

abstract class INotificationSettingsRepository {
  Future<NotificationSettingsEntity> getSettings();
  Future<void> saveSettings(NotificationSettingsEntity settings);
}
