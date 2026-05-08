import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.freezed.dart';

enum NotificationType { leave, timesheet, policy, team, celebration }

@freezed
abstract class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    required String id,
    required String title,
    required String description,
    required DateTime time,
    required NotificationType type,
    required bool isRead,
    @Default('') String group,
  }) = _NotificationEntity;

  const NotificationEntity._();
}
