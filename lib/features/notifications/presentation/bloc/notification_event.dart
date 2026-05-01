import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.freezed.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.load() = LoadNotifications;
  const factory NotificationEvent.markAllRead() = MarkAllAsRead;
}

class MarkRead extends NotificationEvent {
  final String id;
  const MarkRead(this.id);
}

class MarkAllAsRead extends NotificationEvent {
  const MarkAllAsRead();
}
