import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_entity.freezed.dart';

@freezed
abstract class NotificationSettingsEntity with _$NotificationSettingsEntity {
  const factory NotificationSettingsEntity({
    required List<NotificationSectionEntity> sections,
  }) = _NotificationSettingsEntity;

  factory NotificationSettingsEntity.initial() => const NotificationSettingsEntity(
        sections: [],
      );
}

@freezed
abstract class NotificationSectionEntity with _$NotificationSectionEntity {
  const factory NotificationSectionEntity({
    required String id,
    required String title,
    required String iconKey,
    required List<NotificationItemEntity> items,
  }) = _NotificationSectionEntity;
}

@freezed
abstract class NotificationItemEntity with _$NotificationItemEntity {
  const factory NotificationItemEntity({
    required String id,
    required String title,
    required String description,
    required bool value,
  }) = _NotificationItemEntity;
}
