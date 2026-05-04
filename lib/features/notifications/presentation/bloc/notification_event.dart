import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];

  const factory NotificationEvent.load() = LoadNotifications;
  const factory NotificationEvent.markRead(String id) = MarkRead;
  const factory NotificationEvent.markAllRead() = MarkAllAsRead;
}

class LoadNotifications extends NotificationEvent {
  const LoadNotifications();
}

class MarkRead extends NotificationEvent {
  final String id;
  const MarkRead(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkAllAsRead extends NotificationEvent {
  const MarkAllAsRead();
}
