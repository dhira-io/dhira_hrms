import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification_settings_entity.dart';

part 'notification_settings_state.freezed.dart';

@freezed
class NotificationSettingsState with _$NotificationSettingsState {
  const factory NotificationSettingsState.initial() = _Initial;
  const factory NotificationSettingsState.loading() = _Loading;
  const factory NotificationSettingsState.loaded({
    required NotificationSettingsEntity settings,
    required bool isManager,
    @Default(false) bool isActionLoading,
    String? errorMessage,
  }) = _Loaded;
  const factory NotificationSettingsState.error(String message) = _Error;
}
