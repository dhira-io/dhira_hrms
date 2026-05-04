import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_entity.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];

  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.loading() = _Loading;
  const factory NotificationState.loaded({
    required List<NotificationEntity> notifications,
  }) = _Loaded;
  const factory NotificationState.error(String message) = _Error;

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<NotificationEntity> notifications)? loaded,
    T Function(String message)? error,
    required T Function() orElse,
  }) {
    if (this is _Initial && initial != null) return initial();
    if (this is _Loading && loading != null) return loading();
    if (this is _Loaded && loaded != null) return loaded((this as _Loaded).notifications);
    if (this is _Error && error != null) return error((this as _Error).message);
    return orElse();
  }
}

class _Initial extends NotificationState {
  const _Initial();
}

class _Loading extends NotificationState {
  const _Loading();
}

class _Loaded extends NotificationState {
  final List<NotificationEntity> notifications;
  const _Loaded({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class _Error extends NotificationState {
  final String message;
  const _Error(this.message);

  @override
  List<Object?> get props => [message];
}
