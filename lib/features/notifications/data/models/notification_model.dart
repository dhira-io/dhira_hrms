import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification_entity.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    required String id,
    required String title,
    required String description,
    required String time,
    required String type,
    @JsonKey(name: 'is_read') required bool isRead,
    required String group,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      description: description,
      time: DateTime.tryParse(time) ?? DateTime.now(),
      type: NotificationType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => NotificationType.policy,
      ),
      isRead: isRead,
      group: group,
    );
  }
}
