import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_entity.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];

  const factory NotificationEvent.load({bool isRefresh}) = LoadNotifications;
  const factory NotificationEvent.loadMore() = LoadMoreNotifications;
  const factory NotificationEvent.markRead(String id) = MarkRead;
  const factory NotificationEvent.markAllRead() = MarkAllAsRead;
}

class LoadNotifications extends NotificationEvent {
  final bool isRefresh;
  const LoadNotifications({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class LoadMoreNotifications extends NotificationEvent {
  const LoadMoreNotifications();
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
