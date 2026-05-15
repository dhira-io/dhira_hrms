import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification_settings_entity.dart';

part 'notification_settings_model.freezed.dart';
part 'notification_settings_model.g.dart';

@freezed
abstract class NotificationSettingsModel with _$NotificationSettingsModel {
  const factory NotificationSettingsModel({
    required List<NotificationSectionModel> sections,
  }) = _NotificationSettingsModel;

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);
}

@freezed
abstract class NotificationSectionModel with _$NotificationSectionModel {
  const factory NotificationSectionModel({
    required String id,
    required String title,
    required String iconKey,
    required List<NotificationItemModel> items,
  }) = _NotificationSectionModel;

  factory NotificationSectionModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSectionModelFromJson(json);
}

@freezed
abstract class NotificationItemModel with _$NotificationItemModel {
  const factory NotificationItemModel({
    required String id,
    required String title,
    required String description,
    required bool value,
  }) = _NotificationItemModel;

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemModelFromJson(json);
}

extension NotificationSettingsModelMapper on NotificationSettingsModel {
  NotificationSettingsEntity toEntity() => NotificationSettingsEntity(
        sections: sections.map((s) => s.toEntity()).toList(),
      );
}

extension NotificationSectionModelMapper on NotificationSectionModel {
  NotificationSectionEntity toEntity() => NotificationSectionEntity(
        id: id,
        title: title,
        iconKey: iconKey,
        items: items.map((i) => i.toEntity()).toList(),
      );
}

extension NotificationItemModelMapper on NotificationItemModel {
  NotificationItemEntity toEntity() => NotificationItemEntity(
        id: id,
        title: title,
        description: description,
        value: value,
      );
}

extension NotificationSettingsEntityMapper on NotificationSettingsEntity {
  NotificationSettingsModel toModel() => NotificationSettingsModel(
        sections: sections.map((s) => s.toModel()).toList(),
      );
}

extension NotificationSectionEntityMapper on NotificationSectionEntity {
  NotificationSectionModel toModel() => NotificationSectionModel(
        id: id,
        title: title,
        iconKey: iconKey,
        items: items.map((i) => i.toModel()).toList(),
      );
}

extension NotificationItemEntityMapper on NotificationItemEntity {
  NotificationItemModel toModel() => NotificationItemModel(
        id: id,
        title: title,
        description: description,
        value: value,
      );
}
