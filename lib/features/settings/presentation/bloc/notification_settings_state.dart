import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification_settings_entity.dart';

part 'notification_settings_state.freezed.dart';

@freezed
abstract class NotificationSettingsState with _$NotificationSettingsState {
  const factory NotificationSettingsState({
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
    NotificationSettingsEntity? settings,
  }) = _NotificationSettingsState;
}
